import 'package:flutter/material.dart';
import 'package:proyecto_final/services/auth_service.dart';

import '../components/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    //  Controllers
    final txtUserController = TextEditingController();
    final txtpWDController = TextEditingController();

    //  Iniciar Sesion Metodo
    void registerUser() async {
      await AuthService().signup(
          email: txtUserController.text,
          password: txtpWDController.text,
          context: context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Registro',
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(
              height: 50,
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
              height: 50,
            ),

            //  SIGN IN BUTTON
/*            MyButton(
              onTap: registerUser,
              btnText: 'Registrar',
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
                  onPressed: () async {
                    await AuthService().signup(
                        email: txtUserController.text,
                        password: txtpWDController.text,
                        context: context);

                    Navigator.pushNamed(context, "/onboarding");
                  },
                  child: const Text(
                    "Registrar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
