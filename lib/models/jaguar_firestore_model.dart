class JaguarFirestoreModel {
  String? name;
  String? sex;
  int? age;
  String? imageUrl;
  String? status;
  String? description;
  String? adoptante;

  JaguarFirestoreModel(
      {this.adoptante,
      this.name,
      this.sex,
      this.age,
      this.imageUrl,
      this.status,
      this.description});

  // Método para convertir un documento de Firestore a un objeto de tipo User
  factory JaguarFirestoreModel.fromFirestore(
      Map<String, dynamic> firestoreData) {
    return JaguarFirestoreModel(
      adoptante: firestoreData['adoptante'],
      name: firestoreData['name'],
      age: firestoreData['age'],
      sex: firestoreData['sex'],
      description: firestoreData['description'],
      status: firestoreData['status'],
      imageUrl: firestoreData['imageUrl'],
    );
  }
}
