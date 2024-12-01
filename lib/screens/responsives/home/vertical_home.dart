import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/screens/general/team_screen.dart';

class VerticalHome extends StatelessWidget {
  const VerticalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(12), // Margen alrededor de la imagen
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Bordes redondeados
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100), // Asegura bordes redondeados
              child: Image.asset(
                'assets/general/intro_jaguars.png',
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trabajando por el futuro del Jaguar',
                      style: GoogleFonts.oswald(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Somos una asociación comprometida con el desarrollo e implementación de '
                      'nuevos métodos que ayudan a dejar la huella del jaguar en la selva, al '
                      'contribuir en la reincorporación a su hábitat natural, queremos ver cada '
                      'vez más Jaguares en la Selva.',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeamScreen()),
                        );
                      },
                      child: const Text('Conócenos'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}