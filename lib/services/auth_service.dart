import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_signin_promax/github_signin_promax.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_final/screens/dashboard_screen.dart';
import 'package:proyecto_final/screens/login_screen.dart';
import 'package:proyecto_final/screens/onboarding/onboarding_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(); // <----
  RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  //  LOGIN CON FACEBOOK

  //  LOGIN CON GITHUB
  githubLogin(BuildContext context) {
    // create required params
    var params = GithubSignInParams(
      clientId: 'Ov23liBokJh0vfcnEyyi',
      clientSecret: '08266e470e8b40cd03b8ad135cd898ebe994e5b5',
      redirectUrl:
          'https://proyecto-final-auth-69420.firebaseapp.com/__/auth/handler',
      scopes: 'read:user,user:email',
    );

    // Push [GithubSigninScreen] to perform login then get the [GithubSignInResponse]
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      FocusScope.of(context)
          .requestFocus(FocusNode()); // Esto oculta el teclado
      return GithubSigninScreen(
        params: params,
        headerColor: Colors.green,
        title: 'Login with github',
      );
    })).then((value) async {
      // TOTO: handle the response value as a GithubSignInResponse instance

      final githubSignInResponse = value as GithubSignInResponse;

      final githubAuthCredential =
          GithubAuthProvider.credential('${githubSignInResponse.accessToken}');

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
      User user = userCredential.user!;

      //await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);

      // Agregar usuario a Firestore
      await _addUserToFirestore(user);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Exitoso.")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const DashboardScreen(),
        ),
      );
    });
  }

  //  LOGIN CON GOOGLE
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //await FirebaseAuth.instance.signInWithCredential(credential);

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    User user = userCredential.user!;

    // Agregar usuario a Firestore
    await _addUserToFirestore(user);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  //  REGISTER CON EMAIL Y PASS
  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (emailRegExp.hasMatch(email)) {
        print('Correo válido');
        if (password.length >= 6) {
          print("contrasena valida");

          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
          User user = userCredential.user!;

          // Agregar usuario a Firestore
          await _addUserToFirestore(user);

          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const OnboardingScreen()));
        } else {
          Fluttertoast.showToast(
            msg: "Ingrese una contrasena de al menos 6 caracteres.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Ingrese un correo valido.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  //  LOGIN CON EMAIL Y PASS
  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (emailRegExp.hasMatch(email)) {
        print('Correo válido');
        if (password.length >= 6) {
          print("contrasena valida");

          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
          User user = userCredential.user!;

          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          // Agregar usuario a Firestore
          await _addUserToFirestore(user);

          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const DashboardScreen()));
        } else {
          Fluttertoast.showToast(
            msg: "Ingrese una contrasena de al menos 6 caracteres.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Ingrese un correo valido.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No se encontro un usuario asociado al correo.';
      } else if (e.code == 'wrong-password') {
        message = 'Contrasena incorrecta.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> _addUserToFirestore(User user) async {
    try {
      // Referencia a la colección "usuarios" en Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Crear un nuevo documento en Firestore con el ID del usuario de Firebase
      await users.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName ?? 'Sin nombre',
        'photoUrl': user.photoURL ?? '',
        'createdAt': Timestamp.now(),
      });

      print("Usuario agregado a Firestore.");
    } catch (e) {
      print("Error al agregar el usuario a Firestore: $e");
    }
  }


  Future<void> signout({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();

      // Opcional: Mostrar un mensaje indicando que la sesión se ha cerrado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Has cerrado sesión exitosamente")),
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen()));
    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cerrar sesión: $e")),
      );
    }
  }
}
