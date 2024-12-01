import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/models/onboardingContent.dart';
import 'package:proyecto_final/screens/responsives/onboarding/horizontal.dart';
import 'package:proyecto_final/screens/responsives/onboarding/vertical.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;
  String? _selectedFont; // Fuente de letra inicial

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  if(currentWidth < 600){
                    return Vertical(
                      content: contents[i], 
                      index: currentIndex,
                      currentFont: 'Roboto',
                    );
                  } else {
                    return Horizontal(
                      content: contents[i],
                      index: currentIndex,
                      currentFont: 'Roboto',
                    );
                  }
                }
              ),
            ),
            Container(
              // Puntitos de selección actual
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Container(
              // Botón de siguiente
              height: 60,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 15),
              width: double.infinity,
              child: TextButton(
                child: Text(
                    currentIndex == contents.length - 1 ? 'Continuar' : 'Siguiente',
                    style: GoogleFonts.getFont(
                      'Roboto',
                    )
                ),
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.pushNamed(context, "/newhome");
                  }
                  _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor, // Color de fondo
                  foregroundColor: Colors.white, // Color del texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
