import 'package:flutter/material.dart';
import 'game_page.dart';

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
    final rounds = [
      {'title': 'Round 1', 'icon': Icons.looks_one},
      {'title': 'Semi-Final', 'icon': Icons.flag_circle},
      {'title': 'Final', 'icon': Icons.emoji_events},
      {'title': 'Absolute Champion', 'icon': Icons.star_rate},
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF007ACC),
        title: Text(
          '$level - Select Round',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF007ACC), Color(0xFFE0F7FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            image: DecorationImage(
              image: AssetImage('assets/bg_kazakh.png'),
              fit: BoxFit.cover,
              opacity: 0.08,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 210),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Choose Your Stage',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.95),
                  shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: rounds.length,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  separatorBuilder: (_, __) => const SizedBox(width: 24),
                  itemBuilder: (context, index) {
                    final round = rounds[index];
                    return GestureDetector(
                      onTap: () => goToGame(context, round['title'].toString()),
                      child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              round['icon'] as IconData,
                              size: 50,
                              color: Colors.teal,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              round['title'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
