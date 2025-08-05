import 'dart:ui';
import 'package:flutter/material.dart';
import 'game_page.dart';
import '../data/words.dart';

class RoundPage extends StatelessWidget {
  final String level;

  const RoundPage({super.key, required this.level});

  void goToGame(BuildContext context, String round) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(level: level, round: round),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Получаем все раунды для выбранного уровня из wordLevels
    final levelRounds = wordLevels[level]?.keys.toList() ?? [];
    // Маппим раунды на иконки
    final iconMap = {
      'Round 1': Icons.looks_one,
      'Semi-Final': Icons.flag_circle,
      'Semi Final': Icons.flag_circle,
      'Final': Icons.emoji_events,
      'Absolute Champion': Icons.star_rate,
      'Absolute champion': Icons.star_rate,
      'Trial Round': Icons.school,
      'Commonly Misspelled Words': Icons.spellcheck,
      'Champion': Icons.emoji_events,
    };
    final rounds = levelRounds.map((r) => {
      'title': r,
      'icon': iconMap[r] ?? Icons.circle,
    }).toList();

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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '$level - Select Round',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(blurRadius: 12, color: Colors.black26, offset: Offset(0, 4)),
                          Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Choose Your Stage',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                      shadows: const [Shadow(color: Colors.black26, blurRadius: 4)],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 3.0,
                    ),
                    itemCount: rounds.length,
                    itemBuilder: (context, index) {
                      final round = rounds[index];
                      return GestureDetector(
                        onTap: () => goToGame(context, round['title'].toString()),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  round['icon'] as IconData,
                                  size: 40,
                                  color: Color(0xFF6366F1),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  round['title'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
