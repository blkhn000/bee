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

    final rounds =
        levelRounds
            .map((r) => {'title': r, 'icon': iconMap[r] ?? Icons.circle})
            .toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Упрощенный градиент без фонового изображения
          gradient: LinearGradient(
            colors: [Color(0xFF007ACC), Color(0xFFB2EBF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Header with back button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(
                          0x33FFFFFF,
                        ), // Упрощенная прозрачность
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),

                const SizedBox(height: 20),

                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x4D000000), // Упрощенная прозрачность
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '$level - Select Round',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // Subtitle
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x26FFFFFF), // Упрощенная прозрачность
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Choose Your Stage',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Rounds grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                    itemCount: rounds.length,
                    itemBuilder: (context, index) {
                      final round = rounds[index];
                      return GestureDetector(
                        onTap:
                            () => goToGame(context, round['title'].toString()),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(
                              0xF0FFFFFF,
                            ), // Упрощенная прозрачность
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0x336366F1,
                                    ), // Упрощенная прозрачность
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    round['icon'] as IconData,
                                    size: 32,
                                    color: const Color(0xFF6366F1),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  round['title'].toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
