import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';

class DataDiriPage extends StatelessWidget {
  const DataDiriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Diri')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CircleAvatar(
            radius: 45,
            backgroundColor: navy,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 55,
            ),
          ),
          SizedBox(height: 25),
          InfoTile(
            icon: Icons.person,
            title: 'Nama',
            subtitle: 'Admin SKANOVA',
          ),
          InfoTile(
            icon: Icons.badge,
            title: 'NIS',
            subtitle: 'Belum diisi',
          ),
          InfoTile(
            icon: Icons.school,
            title: 'Kelas',
            subtitle: 'Belum diisi',
          ),
          InfoTile(
            icon: Icons.email,
            title: 'Email',
            subtitle: 'Belum diisi',
          ),
        ],
      ),
    );
  }
}