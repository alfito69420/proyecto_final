import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proyecto_final/provider/provider_vars.dart';
import 'package:proyecto_final/screens/general/map_screen.dart';
import 'package:proyecto_final/screens/general/team_screen.dart';
import 'package:proyecto_final/screens/general/theme_screen.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_home_screen.dart';
import 'package:proyecto_final/screens/login_screen.dart';
import 'package:proyecto_final/screens/dashboard_screen.dart';
import 'package:proyecto_final/screens/onboarding_screen.dart';
import 'package:proyecto_final/screens/pagos/payment_info_screen.dart';
import 'package:proyecto_final/screens/pagos/plan_details_screen.dart';
import 'package:proyecto_final/screens/pagos/plan_selection_screen.dart';
import 'package:proyecto_final/screens/profile/profile_screen.dart';
import 'package:proyecto_final/screens/services/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase

  final PreferenceService _preferenceService = PreferenceService();
  // Cargar el tema guardado
  final ThemeData loadedTheme = await _preferenceService.loadTheme();

  runApp(MyApp(initialTheme: loadedTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData initialTheme;

  const MyApp({super.key, required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderVars(initialTheme),
      child: Consumer<ProviderVars>(
        builder: (context, providerVars, child) {
          return MaterialApp(
            title: 'Jaguares en la Selva',
            home: const LoginScreen(),
            theme: providerVars.currentTheme,
            routes: {
              "/login": (context) => const LoginScreen(),
              "/home": (context) => const DashboardScreen(),
              "/newhome": (context) => HomeScreen(),
              "/onboarding": (context) => const OnboardingScreen(),
              "/jaguarhome": (context) => JaguarHomeScreen(),
              "/us": (context) => TeamScreen(),
              "/locationmap": (context) => MapLocation(),
              "/themes": (context) => ThemeScreen(),
              "/planselect": (context) => PlanSelectionScreen(),
              "/profile": (context) => const ProfileScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
