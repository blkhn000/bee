// import 'dart:ui'; // Убираем для лучшей производительности
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
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Собираем все слова из всех раундов выбранного уровня
    final levelMap = wordLevels[widget.level];
    words = [];
    if (levelMap != null) {
      for (var entry in levelMap.entries) {
        // Если round задан, берем только нужный раунд
        if (widget.round != null && widget.round!.isNotEmpty) {
          if (entry.key == widget.round) {
            words.addAll(entry.value);
          }
        } else {
          words.addAll(entry.value);
        }
      }
    }
    loadNewWord();
  }

  void loadNewWord() {
    final random = Random();
    currentWord = words[random.nextInt(words.length)];
    isChecked = false;
    userInput = '';
    _textController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect =
        userInput.trim().toLowerCase() == currentWord[0].toLowerCase();
    final AudioPlayer player = AudioPlayer();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF007ACC), Color(0xFFB2EBF2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: AssetImage('assets/bg_kazakh.png'),
                fit: BoxFit.cover,
                opacity: 0.35,
              ),
            ),
          ),
          // Убираем BackdropFilter для лучшей производительности
          Container(color: Colors.black.withValues(alpha: 0.1)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
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
                  Center(
                    child: Container(
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
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${widget.level} — ${widget.round}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Hide the answer from user view in production
                  Text(
                    currentWord[0],
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  const Text(
                    'Listen and write the word',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.volume_up_rounded, size: 40),
                      color: Colors.white,
                      tooltip: 'Прослушать слово',
                      onPressed: () async {
                        await flutterTts.setLanguage("en-US");
                        await flutterTts.setPitch(1.0);
                        await flutterTts.speak(currentWord[0]);
                        print('Speaking word: ${currentWord[0]}');
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
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
                        fillColor: Colors.white.withValues(alpha: 0.95),
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
                  ElevatedButton.icon(
                    onPressed: () {
                      final isCorrect =
                          userInput.trim().toLowerCase() ==
                          currentWord[0].toLowerCase();
                      if (isCorrect) {
                        final filePath = 'sounds/next-level.mp3';
                        player.play(AssetSource(filePath));
                        // Show toast for correct answer with word and translation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    '✅ Correct! ${currentWord[0]} — ${currentWord.length > 1 ? currentWord[1] : ""}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                        // Clear text field and load next word immediately
                        _textController.clear();
                        userInput = '';
                        loadNewWord();
                      } else {
                        // Show toast for incorrect answer
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.error, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(
                                  '❌ Incorrect! Try again',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                        final filePath = 'sounds/reject.mp3';
                        player.play(AssetSource(filePath));
                        // Clear text field after check
                        _textController.clear();
                        userInput = '';
                      }
                    },
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
