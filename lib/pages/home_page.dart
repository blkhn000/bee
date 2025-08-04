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
      {'title': 'Junior', 'image': 'assets/images/middle.png'},
      {'title': 'Seniour', 'image': 'assets/images/seniour.png'},
      {'title': 'Absolute', 'image': 'assets/images/seniour.png'},
    ];

    return Scaffold(
      body: Container(
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
            opacity: 0.1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 180),
            const Center(
              child: Text(
                'Bilim Bäygesi',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black45)],
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 320,
              width: double.infinity,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    return GestureDetector(
                      onTap: () => startGame(context, level['title']!),
                      child: Container(
                        width: 280,
                        // height: 280,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.asset(
                                level['image']!,
                                height: 240,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              level['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
