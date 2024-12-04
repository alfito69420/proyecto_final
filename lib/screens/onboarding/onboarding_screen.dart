import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/onboarding/content_model.dart';
import 'package:proyecto_final/screens/onboarding/responsive-screens/horizontal.dart';
import 'package:proyecto_final/screens/onboarding/responsive-screens/vertical.dart';

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
                      currentFont: 'Oswald',
                    );
                  } else {
                    return Horizontal(
                      content: contents[i],
                      index: currentIndex,
                      currentFont: 'Oswald',
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
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.pushNamed(context, "/home");
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
                child: Text(
                    currentIndex == contents.length - 1 ? 'Continue' : 'Next',
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
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
