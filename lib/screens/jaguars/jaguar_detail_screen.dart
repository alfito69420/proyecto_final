// lib/screens/jaguar_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/jaguar.dart';
import 'package:proyecto_final/models/jaguar_firestore_model.dart';

import 'package:proyecto_final/screens/pagos/plan_selection_screen.dart';

class JaguarDetailScreen extends StatelessWidget {
  final JaguarFirestoreModel jaguar;

  const JaguarDetailScreen({Key? key, required this.jaguar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(jaguar.name!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
              background: Hero(
                tag: 'jaguar-${jaguar.name}',
                child: Image.asset(
                  jaguar.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  SizedBox(height: 24),
                  Text(
                    'Descripción',
                  ),
                  SizedBox(height: 8),
                  Text(
                    jaguar.description!,
                  ),
                  // Solo si no ha sido liberado (En refugio), puede adoptarse
                  if(jaguar.status == 'Recinto') SizedBox(height: 24),
                  if(jaguar.status == 'Recinto') _buildAdoptButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem(Icons.cake, '${jaguar.age} años'),
            _buildInfoItem(jaguar.sex == 'Macho' ? Icons.male : Icons.female, jaguar.sex!),
            _buildInfoItem(
              jaguar.status == 'Liberado'
              ? Icons.done 
              : Icons.pending, jaguar.status!
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.orange[800]),
        SizedBox(height: 8),
        Text(
          text,
        ),
      ],
    );
  }

  Widget _buildAdoptButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.pets),
        label: Text('Adoptar a ${jaguar.name}'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[800],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlanSelectionScreen(
              jaguar: jaguar
            )),
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('¡Gracias por querer adoptar a ${jaguar.name}!')),
          // );
        },
      ),
    );
  }
}