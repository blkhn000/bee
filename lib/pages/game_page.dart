import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spbee/data/words.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GamePage extends StatefulWidget {
  final String level;
  final String? round;

  const GamePage({super.key, required this.level, required this.round});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<List<String>> words;
  late List<String> currentWord;
  String userInput = '';
  bool isChecked = false;
  late FlutterTts flutterTts;
  late AudioPlayer audioPlayer;
  final TextEditingController _textController = TextEditingController();
  bool _isTtsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _initializeWords();
    loadNewWord();
  }

  void _initializeAudio() {
    // Инициализируем аудио плееры один раз
    audioPlayer = AudioPlayer();
    flutterTts = FlutterTts();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    try {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      _isTtsInitialized = true;
    } catch (e) {
      print('TTS initialization error: $e');
    }
  }

  void _initializeWords() {
    final levelMap = wordLevels[widget.level];
    words = [];
    if (levelMap != null) {
      for (var entry in levelMap.entries) {
        if (widget.round != null && widget.round!.isNotEmpty) {
          if (entry.key == widget.round) {
            words.addAll(entry.value);
          }
        } else {
          words.addAll(entry.value);
        }
      }
    }
  }

  void loadNewWord() {
    if (words.isEmpty) return;

    final random = Random();
    currentWord = words[random.nextInt(words.length)];
    isChecked = false;
    userInput = '';
    _textController.clear();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _speakWord() async {
    if (!_isTtsInitialized) {
      await _initializeTts();
    }

    try {
      await flutterTts.speak(currentWord[0]);
      print('Speaking word: ${currentWord[0]}');
    } catch (e) {
      print('TTS speak error: $e');
    }
  }

  Future<void> _playSound(String soundPath) async {
    try {
      await audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      print('Audio play error: $e');
    }
  }

  void _checkAnswer() {
    final isCorrect =
        userInput.trim().toLowerCase() == currentWord[0].toLowerCase();

    if (isCorrect) {
      _playSound('sounds/next-level.mp3');
      _showSnackBar(
        '✅ Correct! ${currentWord[0]} — ${currentWord.length > 1 ? currentWord[1] : ""}',
        Colors.green,
        Icons.check_circle,
      );

      // Очищаем и загружаем новое слово
      _textController.clear();
      userInput = '';
      loadNewWord();
    } else {
      _playSound('sounds/reject.mp3');
      _showSnackBar('❌ Incorrect! Try again', Colors.red, Icons.error);

      // Только очищаем поле
      _textController.clear();
      userInput = '';
    }
  }

  void _showSnackBar(String message, Color backgroundColor, IconData icon) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Упрощенный градиент без изображения для лучшей производительности
          gradient: LinearGradient(
            colors: [Color(0xFF007ACC), Color(0xFFB2EBF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),

                // Logo
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  '${widget.level} — ${widget.round}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                // Debug info (remove in production)
                if (currentWord.isNotEmpty)
                  Text(
                    currentWord[0],
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),

                const SizedBox(height: 20),

                // Instruction
                const Text(
                  'Listen and write the word',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Audio button
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF), // Упрощенная прозрачность
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.volume_up_rounded, size: 40),
                    color: Colors.white,
                    onPressed: _speakWord,
                  ),
                ),

                const SizedBox(height: 40),

                // Input field
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: TextField(
                    controller: _textController,
                    onChanged: (value) => userInput = value,
                    textAlign: TextAlign.center,
                    enabled: !isChecked,
                    style: const TextStyle(fontSize: 22, letterSpacing: 1.2),
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      filled: true,
                      fillColor: const Color(
                        0xF2FFFFFF,
                      ), // Упрощенная прозрачность
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF6366F1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Check button
                ElevatedButton.icon(
                  onPressed: _checkAnswer,
                  icon: const Icon(Icons.check),
                  label: const Text('Check'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    flutterTts.stop();
    _textController.dispose();
    super.dispose();
  }
}
