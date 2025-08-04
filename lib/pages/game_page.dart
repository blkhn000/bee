import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spbee/data/words.dart';
import 'package:audioplayers/audioplayers.dart';

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

  @override
  void initState() {
    super.initState();
    words = List.from(wordLevels[widget.level]!);
    loadNewWord();
  }

  void loadNewWord() {
    final random = Random();
    currentWord = words[random.nextInt(words.length)];
    isChecked = false;
    userInput = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect =
        userInput.trim().toLowerCase() == currentWord[0].toLowerCase();
    final AudioPlayer player = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.level} — ${widget.round}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF007ACC),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF007ACC), Color(0xFFE0F7FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: DecorationImage(
            image: AssetImage('assets/kz_back.png'),
            fit: BoxFit.cover,
            opacity: 0.0999,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currentWord[0],
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
            const Text(
              'Listen and write the word',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            IconButton(
              icon: const Icon(Icons.volume_up_rounded, size: 60),
              color: Colors.teal,
              splashRadius: 40,
              tooltip: 'Прослушать слово',
              onPressed: () {
                final soundPath = currentWord[1];
                player.play(AssetSource(soundPath));
                // _speakWord(currentWord);
                print('Playing sound for: ${currentWord[1]}');
              },
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 240),
              child: TextField(
                onChanged: (value) => userInput = value,
                textAlign: TextAlign.center,
                enabled: !isChecked,
                style: const TextStyle(fontSize: 22, letterSpacing: 1.2),
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.95),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isChecked = true;
                });
                final isCorrect =
                    userInput.trim().toLowerCase() ==
                    currentWord[0].toLowerCase();
                final filePath =
                    isCorrect ? 'sounds/next-level.mp3' : 'sounds/reject.mp3';
                player.play(AssetSource(filePath));
              },
              icon: const Icon(Icons.check),
              label: const Text('Check'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (isChecked)
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color:
                      isCorrect ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isCorrect ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      isCorrect ? '✅ Correct!' : '❌ Incorrect',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Correct word: ${currentWord[0]}',
                      style: const TextStyle(fontSize: 20),
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loadNewWord,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Next Word'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
