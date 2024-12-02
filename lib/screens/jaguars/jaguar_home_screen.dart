import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/components/post_banner.dart';
import 'package:proyecto_final/components/jaguar_card.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/models/post.dart';
import 'package:proyecto_final/screens/general/post_screen.dart';
import 'package:proyecto_final/screens/jaguars/adopted_jaguars_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_carousel_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_detail_screen.dart';

class JaguarHomeScreen extends StatefulWidget {
  JaguarHomeScreen(
    {super.key,}
  );

  @override
  State<JaguarHomeScreen> createState() => _JaguarHomeScreenState();
}

class _JaguarHomeScreenState extends State<JaguarHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jaguares'),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.cat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdoptedJaguarsScreen(adoptedJaguars: [],)                  
                ),
              );
            }
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                PostBanner(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostScreen(post: jaguarPost,)),
                    );
                  },
                  post: jaguarPost,
                ),
                SizedBox(height: 10,),
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