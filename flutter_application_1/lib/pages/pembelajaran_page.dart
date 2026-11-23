import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class PembelajaranPage extends StatelessWidget {
  const PembelajaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembelajaran')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          SectionHeading('Materi Pembelajaran'),
          InfoTile(
            icon: Icons.computer,
            title: 'Pemrograman Dasar',
            subtitle: 'Materi dan tugas pemrograman.',
          ),
          InfoTile(
            icon: Icons.book,
            title: 'Bahasa Indonesia',
            subtitle: 'Materi Bahasa Indonesia.',
          ),
          InfoTile(
            icon: Icons.calculate,
            title: 'Matematika',
            subtitle: 'Materi Matematika.',
          ),
          InfoTile(
            icon: Icons.language,
            title: 'Bahasa Inggris',
            subtitle: 'Materi Bahasa Inggris.',
          ),
        ],
      ),
    );
  }
}