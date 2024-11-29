import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_final/components/my_textfield.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final defaultColorScheme = Theme.of(context).colorScheme;
    final currentWidth = MediaQuery.of(context).size.width;

    //  Controllers
    final txtUserController = TextEditingController();
    final txtpWDController = TextEditingController();

    //  Iniciar Sesion Metodo
    void signInUser() {
      Navigator.pushNamed(context, "/home");
    }

    bool isValidEmail(String email) {
      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      return emailRegex.hasMatch(email);
    }

    void signupUser() {
      final email = txtUserController.text.trim();
      final password = txtpWDController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Fluttertoast.showToast(
          msg: 'Por favor, complete todos los campos.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      if (!isValidEmail(email)) {
        Fluttertoast.showToast(
          msg: 'Por favor, ingrese un correo válido.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      AuthService().signin(email: email, password: password, context: context);
    }

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            //  LOGO
            Image.asset(
              "assets/jaguar.png",
              width: 200,
            ),
            const SizedBox(
              height: 50,
            ),

            //  SALUDO
            const Text(
              'Bienvenido',
              style: TextStyle(color: Colors.grey, fontSize: 32),
            ),
            const SizedBox(
              height: 25,
            ),

            //  TEXTFIELD USUARIO
            MyTextField(
              controller: txtUserController,
              obscureText: false,
              hintText: 'Usuario',
            ),

            const SizedBox(
              height: 10,
            ),

            //  TEXTFIELD PASSWORD
            MyTextField(
              controller: txtpWDController,
              hintText: 'Contraseña',
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            //  OLVIDO CONTRASENA
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('¿Olvidó su contraseña?'),
                ],
              ),
            ),

            const SizedBox(
              height: 75,
            ),

            //  SIGN IN BUTTON
            /*          MyButton(
              onTap: signInUser, btnText: 'Iniciar Sesion',
                        ),*/
            Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    signupUser();
                  },
                  child: const Text(
                    "Iniciar Sesion",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ),

            const SizedBox(
              height: 50,
            ),

            //  REGISTER BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No está registrado?'),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector.new(
                  onTap: () => Navigator.pushNamed(context, "/register"),
                  child: const Text(
                    'Regístrese ahora',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    )));
  }
}
