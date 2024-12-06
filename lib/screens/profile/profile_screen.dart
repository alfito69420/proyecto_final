import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/utils/text_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //  Handled Images
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    //  Colores
    final defaultColorScheme = Theme.of(context).colorScheme;

    final user = FirebaseAuth.instance.currentUser;

    //  External App Uris
    final Uri githubUrl = Uri.parse(TextStrings.github);
    final Uri telefono = Uri.parse("tel:${TextStrings.telefono}");
    final Uri email = Uri(
      scheme: 'mailto',
      path: TextStrings.email,
      query: 'subject=Hola&body=Este es el cuerpo del mensaje',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: user?.photoURL != null
                            ? Image.network(user!.photoURL!) // Foto de perfil desde Google
                            : const Image(image: AssetImage("assets/pfp.jpg"))),
                  ),
                  /*Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: defaultColorScheme.primary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          showCameraGalleryOption(context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 18.0,
                          color: defaultColorScheme.onPrimary,
                        ),
                      ),
                    ),
                  )*/
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: user?.displayName ?? "Nombre no disponible",
                icon: const Icon(Icons.person),
                onPress: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              ProfileMenuWidget(
                title: user?.email ?? "Correo no disponible",
                icon: const Icon(Icons.email),
                onPress: () {
                  // _launchUrl(email, context);
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Guardar la ruta de la imagen en SharedPreferences
  Future<void> _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }

// Obtener la ruta de la imagen desde SharedPreferences
  Future<String?> _loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image_path');
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  // Cargar la imagen al iniciar la pantalla
  void _loadImage() async {
    String? imagePath = await _loadImagePath();
    if (imagePath != null) {
      setState(() {
        selectedImage = File(imagePath);
      });
    }
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.textColor});

  final String title;
  final Icon icon;
  final VoidCallback onPress;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
