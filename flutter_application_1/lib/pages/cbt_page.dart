import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/common_widgets.dart';

class CbtPage extends StatelessWidget {
  const CbtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CBT')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.quiz, size: 85, color: navy),
          const SizedBox(height: 15),
          const Text(
            'Computer Based Test',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Pilih ujian yang tersedia.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          const InfoTile(
            icon: Icons.assignment,
            title: 'Ujian Pemrograman Dasar',
            subtitle: 'Status: Belum dimulai',
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ujian belum tersedia'),
                ),
              );
            },
            child: const Text('Mulai Ujian'),
          ),
        ],
      ),
    );
  }
}