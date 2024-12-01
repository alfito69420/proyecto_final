import 'package:flutter/material.dart';

import '../services/auth_service.dart';
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
      body: Builder(builder: (context) => JaguarHomeScreen(),)
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                //child: selectedImage != null ? Image.file(selectedImage!) : const Image(image: AssetImage("assets/pfp.jpg"))),
                child: const Image(image: AssetImage("assets/pfp.jpg"))),
            accountName: const Text("Jaguar"),
            accountEmail: const Text("jaguar@gmail.com"),
          ),
          ListTile(
            onTap: () {
              //Navigator.pushNamed(context, "/movies");
            },
            title: const Text("Perfil"),
            //subtitle: const Text("lorem ipsum"),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: () {
              //Navigator.pushNamed(context, "/preferences_drawer");
            },
            title: const Text("Preferencias"),
            subtitle: const Text("Tema / Fuente"),
            leading: const Icon(Icons.room_preferences),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
          const Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                height: 2,
              )),
          ListTile(
            onTap: () {
              /*print(
                  "Custom theme enabled (logout): ${GlobalValues.customThemeEnabled.value}");*/
              /*Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  ModalRoute.withName("/login"));*/

              AuthService().signout(context: context);
            },
            title: const Text("Cerrar Sesión"),
            //subtitle: const Text("Tema / Fuente"),
            leading: const Icon(Icons.logout),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
          ),
        ],
      ),
    );
  }
}
