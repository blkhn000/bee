import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:spbee/config/app_config.dart';

class GoogleCloudTtsService {
  GoogleCloudTtsService({http.Client? client, AudioPlayer? player})
    : _client = client ?? http.Client(),
      _player = player ?? AudioPlayer();

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
  final Map<String, Uint8List> _audioCache = {};

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

    if (_apiKey.isEmpty) {
      throw StateError(
        'Google Cloud TTS API key is missing. Run with '
        '--dart-define=GOOGLE_CLOUD_TTS_API_KEY=YOUR_KEY.',
      );
    }

    Uint8List audioBytes;
    final cachedAudio = _audioCache[normalizedText];
    if (cachedAudio != null) {
      audioBytes = cachedAudio;
    } else {
      audioBytes = await _synthesize(normalizedText);
      _audioCache[normalizedText] = audioBytes;
    }

    await _player.stop();
    await _player.play(BytesSource(audioBytes, mimeType: 'audio/mpeg'));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
    _client.close();
  }

  String _normalizeText(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ');
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
