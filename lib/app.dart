import 'package:flutter/material.dart';
import 'package:spbee/pages/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Қош келдіңіз!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3949AB),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Spelling Bee — балалар мен оқушыларға арналған\nзаманауи білім сайысы.',
                style: TextStyle(fontSize: 20, color: Color(0xFF303F9F)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Image.asset('assets/images/logo.jpg', height: 160),
              const SizedBox(height: 30),
              const Text(
                'Біз туралы',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Spelling Bee — бұл қазақ және ағылшын тілдерінде емле мен дұрыс жазуды\n дамытуға бағытталған сайыстық форматтағы мобильді платформа.',
                style: TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Біз — Қазақстандағы алғашқы\nSpelling Bee білім платформасымыз!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF283593),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                child: const Text('🚀 Let\'s go!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
