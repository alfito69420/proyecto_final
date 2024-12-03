import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {

  // Función pa subir imágenes al bucket
  Future<void> uploadImage(File imageFile) async {
    try {
      // Subir archivo al bucket
      final String filePath = 'general/${imageFile.path.split('/').last}';
      await Supabase.instance.client.storage
          .from('proyecto_final_bucket') // Reemplaza con tu bucket
          .upload(filePath, imageFile);

      print('Image uploaded successfully: $filePath');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // Función para descargar imágenes del bucket
  Future<void> downloadImage(String remotePath) async {
    try {
      // Descargar la imagen como bytes
      final Uint8List fileData = await Supabase.instance.client.storage
          .from('proyecto_final_bucket')
          .download(remotePath); // Path completo del archivo remoto

      // Guardar los datos en un archivo local
      final directory = await getApplicationDocumentsDirectory();
      final String localPath = '${directory.path}/${remotePath.split('/').last}';
      final File localFile = File(localPath);
      await localFile.writeAsBytes(fileData);

      print('Image downloaded successfully and saved at: $localPath');
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}
