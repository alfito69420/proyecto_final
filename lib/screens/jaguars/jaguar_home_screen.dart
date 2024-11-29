// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/components/jaguar_card.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_carousel_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_detail_screen.dart';

class JaguarHomeScreen extends StatelessWidget {
  final List<Jaguar> jaguars = [
    Jaguar(
      name: 'Autano',
      age: 5,
      sex: 'Macho',
      imageUrl: 'assets/jaguars/autano1.jpg',
      description: 'Autano es un jaguar wey. Le encanta explorar su hábitat y es muy ágil al trepar árboles.',
    ),
    Jaguar(
      name: 'Balam',
      age: 3,
      sex: 'Macho',
      imageUrl: 'assets/jaguars/balam1.jpg',
      description: 'Balam es un jaguar fuerte y territorial. Tiene un pelaje oscuro y manchas bien definidas.',
    ),
    Jaguar(
      name: 'Sugar',
      age: 1,
      sex: 'Hembra',
      imageUrl: 'assets/jaguars/sugar1.jpg',
      description: 'Sugar es la más joven del grupo. Es muy energética y le gusta jugar con enriquecimiento ambiental.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jaguares'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text(
                  '¡Jaguares Liberados!',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 10,),
                JaguarCarouselScreen(
                  jaguars: jaguars,
                  onJaguarTap: (jaguar) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JaguarDetailScreen(jaguar: jaguar),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text(
                  'Jaguares para Adoptar',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return JaguarCard(jaguar: jaguars[index]);
                },
                childCount: jaguars.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}