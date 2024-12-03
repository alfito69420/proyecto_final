import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/general/team_screen.dart';

class HorizontalHome extends StatelessWidget {
  const HorizontalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/general/intro_jaguars.png',
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trabajando por el futuro del Jaguar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(height: 12),
                  const Text(
                    'Somos una asociación comprometida con el desarrollo e implementación de '
                    'nuevos métodos que ayudan a dejar la huella del jaguar en la selva, al '
                    'contribuir en la reincorporación a su hábitat natural, queremos ver cada '
                    'vez más Jaguares en la Selva.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeamScreen()),
                      );
                    },
                    child: Text('Conócenos'),
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
    );
  }
}