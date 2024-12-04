import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_final/models/post.dart';
import 'package:proyecto_final/screens/general/posts_list_screen.dart';
import 'package:proyecto_final/screens/jaguars/adopted_jaguars_screen.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';
import 'jaguars/jaguar_home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Clave para el Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    //  TEMA PRINCIPAL
    final defaultColorScheme = Theme.of(context);

    return Scaffold(
        key: _scaffoldKey,
        // Asigna la clave al Scaffold
        appBar: AppBar(
          backgroundColor: defaultColorScheme.primaryColor,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Abre el drawer
            },
            icon: Icon(
              Icons.menu,
              color: defaultColorScheme.canvasColor,
            ),
          ),
          title: Text(
            "Inicio",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            /*GestureDetector(
            onTap: () {},
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.ads_click_sharp,
                  //color: defaultColorScheme.onPrimary,
                ),
              ),
            ),
          ),*/
          ],
        ),
        drawer: myDrawer(context),
        body: Builder(
          builder: (context) => HomeScreen(),
        ));
  }

  Widget myDrawer(context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      // shadowColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: user?.photoURL != null
                  ? Image.network(
                      user!.photoURL!) // Foto de perfil desde Google
                  : const Image(
                      image: AssetImage("assets/pfp.jpg")), // Placeholder
            ),
            accountName: Text(user?.displayName ?? "Nombre no disponible"),
            accountEmail: Text(user?.email ?? "Correo no disponible"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
            title: const Text("Perfil"),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdoptedJaguarsScreen(
                          adoptedJaguars: [],
                        )),
              );
            },
            title: const Text("Mis Adopciones"),
            subtitle: const Text("Mis Jaguares"),
            leading: const Icon(Icons.pets),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JaguarHomeScreen()),
              );
            },
            title: const Text("Jaguares"),
            subtitle: const Text("Todos los Jaguares"),
            leading: const FaIcon(FontAwesomeIcons.cat),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/themes");
            },
            title: const Text("Preferencias"),
            subtitle: const Text("Tema / Fuente"),
            leading: const Icon(Icons.room_preferences),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/registerfill");
            },
            title: const Text("FormRegistro2"),
            subtitle: const Text("._.XD"),
            leading: const FaIcon(FontAwesomeIcons.user),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostsListScreen(
                          posts: posts,
                        )),
              );
            },
            title: const Text("Noticias del Santuario"),
            subtitle: const Text("Noticias"),
            leading: const Icon(Icons.newspaper),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Divider(height: 2),
          ),
          ListTile(
            onTap: () {
              AuthService().signout(context: context);
            },
            title: const Text("Cerrar Sesión"),
            leading: const Icon(Icons.logout),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
        ],
      ),
    );
  }
}
