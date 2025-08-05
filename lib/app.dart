import 'package:flutter/material.dart';
import 'package:spbee/pages/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isWide)
                    Container(
                      width: constraints.maxWidth * 0.45,
                      height: constraints.maxHeight,
                      margin: const EdgeInsets.only(right: 32),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF6366F1).withOpacity(0.08),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32), // added rounding to top-left
                          bottomLeft: Radius.circular(32), // added rounding to bottom-left
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/kz_back.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // changed to center alignment
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isGrid = constraints.maxWidth > 600;
                              if (isGrid) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center, // center third element vertically
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          buildCard1(),
                                          buildCard2(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 24),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center, // center third element horizontally
                                        children: [
                                          buildCard3(),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    buildCard1(),
                                    buildCard2(),
                                    buildCard3(),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 32),
                          Align(
                            alignment: Alignment.center, // ensure button stays centered
                            child: Container(
                              width: 200,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(), // Replace with your target page
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6366F1),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  'Бастау'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard1() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E8), // light green
        borderRadius: BorderRadius.circular(48), // increased rounding
        // border removed
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spelling Bee',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Қош келдіңіз!'.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6366F1),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '32 Сөздер (60m күн сайын)',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Spelling Bee — балалар мен оқушыларға арналған заманауи білім сайысы.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/logo.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard2() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD), // light blue
        borderRadius: BorderRadius.circular(48), // increased rounding
        // border removed
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Біз туралы',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '12 Сөздер (60m күн сайын)',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Spelling Bee — бұл қазақ және ағылшын тілдерінде емле мен дұрыс жазуды дамытуға бағытталған сайыстық форматтағы мобильді платформа.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/logo.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard3() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Color(0xFFFCE4EC), // light pink
        borderRadius: BorderRadius.circular(48), // increased rounding
        // border removed
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Артықшылық',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '16 Сөздер (120m күн сайын)',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Біз — Қазақстандағы алғашқы Spelling Bee білім платформасымыз!',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/logo.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
