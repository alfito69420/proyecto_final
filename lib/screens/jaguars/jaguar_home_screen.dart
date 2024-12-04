import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final/components/post_banner.dart';
import 'package:proyecto_final/models/post.dart';
import 'package:proyecto_final/screens/general/post_screen.dart';
import 'package:proyecto_final/screens/jaguars/adopted_jaguars_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_carousel_screen.dart';
import 'package:proyecto_final/screens/jaguars/jaguar_detail_screen.dart';

import '../../components/jaguar_card.dart';
import '../../models/jaguar_firestore_model.dart';
import '../../services/firestore_service.dart';

class JaguarHomeScreen extends StatefulWidget {
  JaguarHomeScreen({
    super.key,
  });

  @override
  State<JaguarHomeScreen> createState() => _JaguarHomeScreenState();
}

class _JaguarHomeScreenState extends State<JaguarHomeScreen> {
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
      final querySnapshot = await firestoreService!.collectionReference!.get();

      // Mapear los datos a la lista
      setState(() {
        adoptedJaguars = querySnapshot.docs.map((doc) {
          return JaguarFirestoreModel.fromFirestore(
              doc.data() as Map<String, dynamic>);
        }).toList();
        _isLoading = false; // Indicar que se completó la carga
      });

      print(adoptedJaguars.first.name);
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
        title: Text('Jaguares'),
        actions: [
          IconButton(
              icon: Icon(Icons.pets),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdoptedJaguarsScreen(
                            adoptedJaguars: [],
                          )),
                );
              }),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                PostBanner(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostScreen(
                                post: posts[0], // Post de mauricio
                              )),
                    );
                  },
                  post: posts[0],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '¡Jaguares Liberados!',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: firestoreService!.SELECTALL(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay jaguares disponibles por el momento.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    }

                    // Mapea los documentos obtenidos a widgets
                    final jaguarDocs = snapshot.data!.docs;
                    final jaguars = jaguarDocs.map((doc) {
                      return JaguarFirestoreModel.fromFirestore(
                          doc.data() as Map<String, dynamic>);
                    }).toList();

                    //  EN ESTE CARRUSEL SOLO SE MUESTRAN JAGUARES LIBERADOS
                    return JaguarCarouselScreen(
                      jaguars: jaguars,
                      onJaguarTap: (jaguar) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JaguarDetailScreen(jaguar: jaguar),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Jaguares para Adoptar',
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          //  AQUI SON LOS JAGUARES QUEW SE PUEDEN ADOPTAR, CUYO ESTADO SEA EN RECINTO



          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestoreService!.SELECT_JAGUARES_PARA_ADOPTAR(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No hay jaguares para liberar disponibles por el momento.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  );
                }

                // Mapeamos los documentos obtenidos
                final jaguarDocs = snapshot.data!.docs;
                final jaguars = jaguarDocs.map((doc) {
                  return JaguarFirestoreModel.fromFirestore(doc.data());
                }).toList();

                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return JaguarCard(jaguar: jaguars[index]);
                    },
                    childCount: jaguars.length,
                  ),
                );
              },
            ),
          ),


/*          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return JaguarCard(jaguar: jaguars[index]);
                },
                childCount: jaguars.length,
              ),
            ),
          ),*/



        ],
      ),
    );
  }
}
