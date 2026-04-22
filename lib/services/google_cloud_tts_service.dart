import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:spbee/config/app_config.dart';

class GoogleCloudTtsService {
  GoogleCloudTtsService({
    http.Client? client,
    AudioPlayer? player,
    FlutterTts? nativeTts,
  })
    : _client = client ?? http.Client(),
      _player = player ?? AudioPlayer(),
      _nativeTts = nativeTts ?? FlutterTts();

  static const String _apiKeyFromEnv = String.fromEnvironment(
    'GOOGLE_CLOUD_TTS_API_KEY',
  );
  static const String _voiceNameFromEnv = String.fromEnvironment(
    'GOOGLE_CLOUD_TTS_VOICE_NAME',
  );
  static final Uri _synthesizeUri = Uri.parse(
    'https://texttospeech.googleapis.com/v1/text:synthesize',
  );

  final http.Client _client;
  final AudioPlayer _player;
  final FlutterTts _nativeTts;
  final Map<String, Uint8List> _audioCache = {};
  bool _nativeTtsConfigured = false;
  bool _preferNativeTts = false;

  String get _apiKey =>
      AppConfig.googleCloudTtsApiKey.isNotEmpty
          ? AppConfig.googleCloudTtsApiKey
          : _apiKeyFromEnv;

  String get _voiceName =>
      AppConfig.googleCloudTtsVoiceName.isNotEmpty
          ? AppConfig.googleCloudTtsVoiceName
          : _voiceNameFromEnv;

  Future<void> speak(String text) async {
    final normalizedText = _normalizeText(text);
    if (normalizedText.isEmpty) {
      return;
    }

    Object? cloudError;
    if (_apiKey.isNotEmpty && !_preferNativeTts) {
      try {
        Uint8List audioBytes;
        final cachedAudio = _audioCache[normalizedText];
        if (cachedAudio != null) {
          audioBytes = cachedAudio;
        } else {
          audioBytes = await _synthesize(normalizedText);
          _audioCache[normalizedText] = audioBytes;
        }

        await _nativeTts.stop();
        await _player.stop();
        await _player.play(BytesSource(audioBytes, mimeType: 'audio/mpeg'));
        return;
      } catch (error) {
        cloudError = error;
        if (_isPermanentCloudError(error)) {
          _preferNativeTts = true;
        }
      }
    }

    try {
      await _speakWithNativeTts(normalizedText);
    } catch (nativeError) {
      final cloudMessage =
          cloudError == null
              ? _apiKey.isEmpty
                  ? 'Google Cloud TTS API key is missing.'
                  : 'Google Cloud TTS was skipped.'
              : _describeError(cloudError);
      final nativeMessage = _describeError(nativeError);
      throw StateError(
        'Speech playback is unavailable. '
        'Cloud TTS: $cloudMessage '
        'Native TTS: $nativeMessage',
      );
    }
  }

  Future<void> stop() async {
    await _player.stop();
    await _nativeTts.stop();
  }

  void dispose() {
    _nativeTts.stop();
    _player.dispose();
    _client.close();
  }

  String _normalizeText(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  Future<void> _speakWithNativeTts(String text) async {
    await _configureNativeTts();
    await _player.stop();
    await _nativeTts.stop();
    final result = await _nativeTts.speak(text);
    if (result is int && result != 1) {
      throw StateError('Device TTS engine rejected the utterance.');
    }
  }

  Future<void> _configureNativeTts() async {
    if (_nativeTtsConfigured) {
      return;
    }

    await _nativeTts.awaitSpeakCompletion(true);
    await _nativeTts.setPitch(1.0);
    await _nativeTts.setSpeechRate(0.45);

    try {
      await _nativeTts.setLanguage('en-GB');
    } catch (_) {
      await _nativeTts.setLanguage('en-US');
    }

    _nativeTtsConfigured = true;
  }

  bool _isPermanentCloudError(Object error) {
    final message = _describeError(error).toLowerCase();
    return message.contains('billing to be enabled') ||
        message.contains('api key not valid') ||
        message.contains('permission denied');
  }

  String _describeError(Object error) {
    return error.toString().replaceFirst('Bad state: ', '').trim();
  }

  Future<Uint8List> _synthesize(String text) async {
    final voice = <String, dynamic>{
      'languageCode': 'en-GB',
      'ssmlGender': 'MALE',
    };

    if (_voiceName.isNotEmpty) {
      voice['name'] = _voiceName;
    }

    final response = await _client
        .post(
          _synthesizeUri.replace(queryParameters: {'key': _apiKey}),
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'input': {'text': text},
            'voice': voice,
            'audioConfig': {
              'audioEncoding': 'MP3',
              'speakingRate': 0.9,
              'pitch': 0.0,
            },
          }),
        )
        .timeout(const Duration(seconds: 20));

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final error = body['error'];
      final message =
          error is Map<String, dynamic> ? error['message']?.toString() : null;
      throw StateError(message ?? 'Google Cloud TTS request failed.');
    }

    final audioContent = body['audioContent']?.toString();
    if (audioContent == null || audioContent.isEmpty) {
      throw StateError('Google Cloud TTS returned an empty audio payload.');
    }

    return base64Decode(audioContent);
  }
}
