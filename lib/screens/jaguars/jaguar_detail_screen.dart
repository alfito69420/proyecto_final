// lib/screens/jaguar_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/jaguar.dart';

class JaguarDetailScreen extends StatelessWidget {
  final Jaguar jaguar;

  const JaguarDetailScreen({super.key, required this.jaguar});

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
              title: Text(jaguar.name,
                  ),
              background: Hero(
                tag: 'jaguar-${jaguar.name}',
                child: Image.asset(
                  jaguar.imageUrl,
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
                  const SizedBox(height: 24),
                  Text(
                    'Descripción',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    jaguar.description,
                  ),
                  const SizedBox(height: 24),
                  _buildAdoptButton(context),
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
            _buildInfoItem(jaguar.sex == 'Macho' ? Icons.male : Icons.female, jaguar.sex),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.orange[800]),
        const SizedBox(height: 8),
        Text(
          text,
        ),
      ],
    );
  }

  Widget _buildAdoptButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.pets),
        label: Text('Adoptar a ${jaguar.name}'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[800],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // Aquí puedes agregar la lógica para el proceso de adopción
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('¡Gracias por querer adoptar a ${jaguar.name}!')),
          );
        },
      ),
    );
  }
}