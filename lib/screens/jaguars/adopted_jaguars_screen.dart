import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

import '../../components/jaguar_card.dart';
import '../../models/jaguar_firestore_model.dart';
import '../../services/firestore_service.dart';

class AdoptedJaguarsScreen extends StatefulWidget {
  final List<JaguarFirestoreModel> adoptedJaguars;

  const AdoptedJaguarsScreen({Key? key, required this.adoptedJaguars})
      : super(key: key);

  @override
  State<AdoptedJaguarsScreen> createState() => _AdoptedJaguarsScreenState();
}

class _AdoptedJaguarsScreenState extends State<AdoptedJaguarsScreen> {
  FirestoreService? firestoreService;
  List<JaguarFirestoreModel> adoptedJaguars = [];
  bool _isLoading =
      true; // Para mostrar un indicador mientras se cargan los datos.

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    _loadAdoptedJaguars();
  }

  Future<void> _loadAdoptedJaguars() async {
    try {
      // Obtener el ID del usuario actual
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        // Manejar el caso donde el usuario no está autenticado
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Consultar Firestore
      final querySnapshot = await firestoreService!.collectionReference!
          .where('adoptante', isEqualTo: userId)
          .get();

      // Mapear los datos a la lista
      setState(() {
        adoptedJaguars = querySnapshot.docs.map((doc) {
          return JaguarFirestoreModel.fromFirestore(
              doc.data() as Map<String, dynamic>);
        }).toList();
        _isLoading = false; // Indicar que se completó la carga
      });
    } catch (e) {
      print("Error al cargar jaguares adoptados: $e");
      setState(() {
        _isLoading = false; // Detener el indicador incluso si hay error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Jaguares Adoptados',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              ThemeSettings.generateSimilarColorHSL(
                  Theme.of(context).scaffoldBackgroundColor),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jaguares que has adoptado',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(height: 16),
              Flexible(
                child: StreamBuilder(
                    stream: firestoreService!
                        .SELECT(FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var movies = snapshot.data!.docs;
                        return adoptedJaguars.isEmpty
                            ? Center(
                                child: Text(
                                  'Aún no has adoptado ningún jaguar.',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var movieData = movies[index];

                                  var firestoreData = {
                                    'adoptante': movieData.get('adoptante'),
                                    'name': movieData.get('nombre'),
                                    'age': movieData.get('edad'),
                                    'sex': movieData.get('sexo'),
                                    'imageUrl': movieData.get('foto'),
                                    'status': movieData.get('estatus'),
                                    'description': movieData.get('descripcion')
                                  };
                                  return JaguarCard(
                                    jaguar: JaguarFirestoreModel.fromFirestore(
                                        firestoreData),
                                  );
                                },
                              );
                      } else {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.toString()));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
