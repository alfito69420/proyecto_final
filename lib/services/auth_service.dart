import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_signin_promax/github_signin_promax.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_final/screens/dashboard_screen.dart';
import 'package:proyecto_final/screens/login_screen.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(); // <----

  //  LOGIN CON FABECOOK

  //  LOGIN CON GITHUB
  githubLogin(BuildContext context) {
    // create required params
    var params = GithubSignInParams(
      clientId: 'Ov23liBokJh0vfcnEyyi',
      clientSecret: '08266e470e8b40cd03b8ad135cd898ebe994e5b5',
      redirectUrl: 'https://proyecto-final-auth-69420.firebaseapp.com/__/auth/handler',
      scopes: 'read:user,user:email',
    );

    // Push [GithubSigninScreen] to perform login then get the [GithubSignInResponse]
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      FocusScope.of(context).requestFocus(FocusNode()); // Esto oculta el teclado
      return GithubSigninScreen(
        params: params,
        headerColor: Colors.green,
        title: 'Login with github',
      );
    })).then((value) async {
      // TOTO: handle the response value as a GithubSignInResponse instance

      final githubSignInResponse = value as GithubSignInResponse;

      final githubAuthCredential = GithubAuthProvider.credential('${githubSignInResponse.accessToken}');

      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Exitoso Perra")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const DashboardScreen(),
        ),
      );
    });
  }
  /*Future<UserCredential> signInWithGithub(BuildContext context) async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen()));

    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);

    *//*try {
      GithubAuthProvider githubProvider = GithubAuthProvider();

      // Autenticación con ventana emergente
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithPopup(githubProvider);

      // Navegación al Dashboard si es exitoso
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen(),
          ),
        );
      }

      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error al iniciar sesión con GitHub: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      rethrow;
    }*//*


  }*/

/*  Future<void> handleRedirectResult(BuildContext context) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.getRedirectResult();

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen(),
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error al procesar redirección: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }*/


  //  LOGIN CON GOOGLE
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen()));

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //  REGISTER CON EMAIL Y PASS
  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const DashboardScreen()));
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const DashboardScreen()));
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

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
  }
}
