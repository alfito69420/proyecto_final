import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/screens/general/map_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900], // Fondo verde oscuro
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Card(
                color: const Color.fromARGB(255, 218, 222, 215),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildAnimatedSection('Nuestra Historia', _buildHistoryContent()),
                      SizedBox(height: 20),
                      _buildAnimatedSection('El Santuario', _buildSanctuaryContent()),
                      SizedBox(height: 20),
                      _buildAnimatedSection('Nuestros Objetivos', _buildObjectivesContent()),
                      SizedBox(height: 20),
                      _buildAnimatedSection('Nuestro Equipo', _buildTeamContent()),
                      SizedBox(height: 20),
                      _buildVisitButton(context),
                      SizedBox(height: 20),
                      _buildContactSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.green[900],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Fundación Jaguares en la Selva',
          style: GoogleFonts.oswald(
            textStyle: TextStyle(
              color: Theme.of(context).canvasColor,
              fontSize: 16.0,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/general/equipo_tecnico.jpg',
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.green[900]!.withOpacity(0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title, Widget content) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          content,
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.oswald(
          textStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryContent() {
    return _buildParagraph(
      'En 2015 se creó la Fundación Jaguares en la Selva, presidida por Víctor Rosas Cosío. '
      'Mediante un convenio de colaboración, la fundación realiza sus actividades en las '
      'instalaciones del Santuario del Jaguar Yaguar Xoo, un espacio abierto en el año 2000 '
      'originalmente para cuidar animales silvestres decomisados.',
    );
  }

  Widget _buildSanctuaryContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'El Santuario del Jaguar Yaguar Xoo ha recibido y albergado grandes '
          'félidos desde su creación en el 2000. El lugar fungió principalmente como un centro '
          'de consignación de animales decomisados por la Procuraduría Federal de Protección al '
          'Ambiente (Profepa), la máxima autoridad mexicana de protección de la vida silvestre.',
        ),
        SizedBox(height: 15),
        _buildParagraph(
          'Con el correr de los años, los administradores del santuario decidieron concentrar '
          'su trabajo en el jaguar, aunque actualmente todavía conservan otros grandes félidos. '
          'Estos ejemplares les permiten enseñar a los visitantes las diferencias entre los grandes félidos del mundo.',
        ),
      ],
    );
  }

  Widget _buildObjectivesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'Entre los objetivos del Santuario del Jaguar Yaguar Xoo está el enseñar a diversas '
          'especies de félidos a regresar a su hábitat y para ello han diseñado todo un programa:',
        ),
        SizedBox(height: 10),
        _buildBulletPoint('Simuladores de vida silvestre'),
        _buildBulletPoint('Terrenos aislados del contacto humano'),
        _buildBulletPoint('Recreación de condiciones del hábitat natural'),
      ],
    );
  }

  Widget _buildTeamContent() {
    return _buildParagraph(
      'Liderado por Víctor Rosas Cosío, nuestro equipo está compuesto por biólogos, '
      'veterinarios y conservacionistas apasionados por la protección de los jaguares '
      'y su hábitat natural.',
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.circle, size: 8, color: Colors.orange[800]),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapLocation()),
            );
          },
          child: Text('¡Visítanos aquí!'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[800],
            foregroundColor: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contáctanos',
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
          ),
          SizedBox(height: 12),
          _buildContactInfo(FontAwesomeIcons.instagram, '@panterinha_jwf', 'https://www.instagram.com/jaguarsintothewild/', context),
          _buildContactInfo(FontAwesomeIcons.squareFacebook, 'Jaguares en la Selva', 'https://www.facebook.com/jaguarsintothewild?ref=ts&fref=ts', context),
          _buildContactInfo(FontAwesomeIcons.squareYoutube, 'Jaguars Into The Wild Foundation', 'https://www.youtube.com/channel/UCiQ7b_-eDiRjHSJI9W6LAGw', context),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text, String url, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(icon, color: Theme.of(context).canvasColor, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri _url = Uri.parse(url);
    // if (await canLaunchUrl(_url)) {
    //   await launchUrl(_url);
    // } else {
    //   throw 'No se pudo abrir la URL: $_url';
    // }
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}