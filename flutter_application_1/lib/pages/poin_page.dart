import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/common_widgets.dart';

class PoinPage extends StatelessWidget {
  const PoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poin Pelanggaran')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                Text(
                  'TOTAL POIN',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                Text(
                  '100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const SectionHeading('Riwayat Poin'),
          const InfoTile(
            icon: Icons.check_circle,
            title: 'Belum ada pelanggaran',
            subtitle: 'Riwayat pelanggaran belum tersedia.',
          ),
        ],
      ),
    );
  }
}