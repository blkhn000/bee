import 'package:flutter/material.dart';
import 'package:spbee/pages/round_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void startGame(BuildContext context, String level) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoundPage(level: level)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final levels = [
      {'title': 'Kids', 'image': 'assets/images/kids.png'},
      {'title': 'Seniour', 'image': 'assets/images/seniour.png'},
      {'title': 'Absolute', 'image': 'assets/images/seniour.png'},
    ];

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                Text(
                  'BILIM BÄYGESI',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Level cards
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      final level = levels[index];
                      return SimpleLevelCard(
                        level: level,
                        onTap: () => startGame(context, level['title']!),
                      );
                    },
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
}

class SimpleLevelCard extends StatelessWidget {
  final Map<String, String> level;
  final VoidCallback onTap;

  const SimpleLevelCard({super.key, required this.level, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 280,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(level['image']!),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xB3000000), // Упрощенная прозрачность
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
