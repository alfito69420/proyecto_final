import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/onboarding/content_model.dart';

class Horizontal extends StatefulWidget {
  Horizontal(
    {
      super.key, 
      required this.content,
      this.index,
      this.currentFont,
    }
  );

  OnboardingContent content;
  int? index;
  String? currentFont;

  @override
  State<Horizontal> createState() => _HorizontalState();
}

class _HorizontalState extends State<Horizontal> {
  final List<String> fonts = ['Roboto', 'Lobster', 'Poppins', 'Pacifico', 'Oswald'];

  @override
  Widget build(BuildContext context) {
    List<Color> colorHistory = [];
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                widget.content.image!,
                height: currentHeight * .5,
              ),
            ]
          ),
          Expanded(
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.content.title!,
                ),
                widget.index != null && widget.index == 2 ?
                Column(
                  children: [
                      numberCounter('1', 'Jaguar silvestre nacido'),
                      numberCounter('5', 'Jaguares rehabilitados y liberados en selvas seguras'),
                      numberCounter('11', 'Jaguares en proceso de rehabilitación'),
                  ],
                )
                :
                Text(
                  widget.content.description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget numberCounter(number, text) {
    return Column(
      children: [
        IntrinsicWidth(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: Text(
                  '${number}',
                  style: TextStyle(
                    fontSize: 32,
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 3),
        Text(
          text, // Aplicar fuente de muestra
        ),
        SizedBox(height: 10),
      ],
    );
  }

}