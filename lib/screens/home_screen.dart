import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proyecto_final/models/caroussel_item.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/models/post.dart';
import 'package:proyecto_final/screens/general/posts_list_screen.dart';
import 'package:proyecto_final/screens/general/team_screen.dart';
import 'package:proyecto_final/screens/general/theme_screen.dart';
import 'package:proyecto_final/screens/jaguars/adopted_jaguars_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_home_screen.dart';
import 'package:proyecto_final/screens/responsives/home/horizontal_home.dart';
import 'package:proyecto_final/screens/responsives/home/vertical_home.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemeScreen()),
              );
            },
            tooltip: 'Configuración de temas',
          ),
          IconButton(
            icon: Icon(Icons.newspaper),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostsListScreen(posts: posts,)),
              );
            },
            tooltip: 'Noticias del Santuario',
          ),
          IconButton(
            icon: Icon(Icons.pets),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JaguarHomeScreen()),
              );
            },
            tooltip: 'Pantalla de jaguares',
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to "Mis adopciones" screen
              // Replace MyAdoptionsScreen() with the actual screen widget
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdoptedJaguarsScreen(adoptedJaguars: [jaguars.first],)),
              );
            },
            tooltip: 'Mis adopciones',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
              ),
              items: carousselItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.title!,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => JaguarHomeScreen()),
                                );
                              },
                              child: Text('Adopta'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[800],
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // colors: [Colors.green[900]!, Colors.green[700]!],
                  colors: [Theme.of(context).scaffoldBackgroundColor,
                    ThemeSettings.generateSimilarColorHSL(Theme.of(context).scaffoldBackgroundColor)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '"Cuando la sangre de tus venas retorne al mar, recordarás que esta tierra no '
                      'te pertenece, sino que tú perteneces a ella"',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    currentWidth > 600 ?
                    HorizontalHome()
                    :
                    VerticalHome(),
                    //customThemeBtn(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customThemeBtn(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThemeScreen()),
        );
      },
      child: Text('Temas'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}