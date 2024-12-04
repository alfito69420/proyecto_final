import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/jaguar_firestore_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  FirestoreService() {
    collectionReference = firebaseFirestore.collection('jaguares');
  }

  Stream<QuerySnapshot> SELECT(String id) {
    return collectionReference!.where('adoptante', isEqualTo: id).snapshots();
  }
/*
  // Método para obtener usuarios desde Firestore
  Future<List<JaguarFirestoreModel>> getJaguares() async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;

      // Obtener los documentos de la colección 'users'
      QuerySnapshot snapshot = await _firestore
          .collection('jaguares')
          .where('adoptante', isEqualTo: user)
          .get();

      // Convertir los documentos a una lista de objetos 'User'
      List<JaguarFirestoreModel> users = snapshot.docs.map((doc) {
        // Convertir el documento a un mapa
        return JaguarFirestoreModel.fromFirestore(
            doc.data() as Map<String, dynamic>);
      }).toList();

      print(users.first.name);

      return users;
    } catch (e) {
      print("Error al obtener usuarios: $e");
      return [];
    }
  }*/
}
