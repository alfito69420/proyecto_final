import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';
import 'jaguars/jaguar_home_screen.dart';
import 'login_screen.dart';

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
    final defaultColorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      // Asigna la clave al Scaffold
      appBar: AppBar(
        backgroundColor: defaultColorScheme.primary,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Abre el drawer
          },
          icon: Icon(
            Icons.menu,
            color: defaultColorScheme.onPrimary,
          ),
        ),
        title: Text(
          "Jaguar",
          style: TextStyle(color: defaultColorScheme.onPrimary),
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
      drawer: myDrawer(),
      body: Builder(builder: (context) => HomeScreen(),)
    );
  }

  Widget myDrawer() {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: user?.photoURL != null
                  ? Image.network(user!.photoURL!) // Foto de perfil desde Google
                  : const Image(image: AssetImage("assets/pfp.jpg")), // Placeholder
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
              Navigator.pushNamed(context, "/themes");
            },
            title: const Text("Preferencias"),
            subtitle: const Text("Tema / Fuente"),
            leading: const Icon(Icons.room_preferences),
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
