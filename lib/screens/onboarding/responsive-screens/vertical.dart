import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/screens/onboarding/content_model.dart';

class Vertical extends StatefulWidget {
  Vertical({super.key,
   required this.content,
   this.index,
   this.currentFont,
  });

  OnboardingContent content;
  int? index;
  String? currentFont;

  @override
  State<Vertical> createState() => _VerticalState();
}

class _VerticalState extends State<Vertical> {
  
  final List<String> fonts = ['Roboto', 'Lobster', 'Poppins', 'Pacifico', 'Oswald'];

  @override
  Widget build(BuildContext context) {
    List<Color> colorHistory = [];
    
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          widget.index != null && widget.index == 2 ?
          Image.asset(
            widget.content.image!,
            height: currentHeight * .22,
            width: currentWidth * 1,
            // height: currentHeight * .1,
            // width: currentWidth * 1,
          )
          :
          Image.asset(
            widget.content.image!,
            height: currentHeight * .25,
            width: currentWidth * 1.25,
            // height: currentHeight * .1,
            // width: currentWidth * 1,
          ),
          Text(
            widget.content.title!,
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              widget.currentFont != null ? widget.currentFont! : 'Roboto',
              fontSize: widget.index != null && widget.index == 2 ? 28 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: widget.index != null && widget.index == 2 ? 15 : 20,
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
              style: GoogleFonts.getFont(
                widget.currentFont != null ? widget.currentFont! : 'Roboto',
                fontSize: 16,
                //color: Colors.grey
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
                    fontSize: 26,
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
          text,
          style: GoogleFonts.getFont(
            widget.currentFont != null ? widget.currentFont! : 'Roboto',
          ), // Aplicar fuente de muestra
        ),
        SizedBox(height: 10),
      ],
    );
  }
}