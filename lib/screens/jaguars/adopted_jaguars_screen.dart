import 'package:flutter/material.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/components/jaguar_card.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class AdoptedJaguarsScreen extends StatelessWidget {
  final List<Jaguar> adoptedJaguars;

  const AdoptedJaguarsScreen({Key? key, required this.adoptedJaguars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Jaguares Adoptados'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              ThemeSettings.generateSimilarColorHSL(Theme.of(context).scaffoldBackgroundColor),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jaguares que has adoptado',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: adoptedJaguars.isEmpty
                    ? Center(
                        child: Text(
                          'Aún no has adoptado ningún jaguar.',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(context),
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: adoptedJaguars.length,
                        itemBuilder: (context, index) {
                          return JaguarCard(jaguar: adoptedJaguars[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 5;
    } else if (screenWidth > 900) {
      return 4;
    } else if (screenWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }
}