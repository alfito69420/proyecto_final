import 'package:cloud_firestore/cloud_firestore.dart';

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

  Stream<QuerySnapshot> SELECTALL() {
    CollectionReference? collectionReference2;
    collectionReference2 = firebaseFirestore.collection('jaguaresLibres');
    print(collectionReference2.parameters.entries.first.value);
    return collectionReference2!
        .snapshots(); // Retorna todos los documentos de Firebase
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
