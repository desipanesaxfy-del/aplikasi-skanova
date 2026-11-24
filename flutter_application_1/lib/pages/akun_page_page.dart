import 'package:flutter/material.dart';
import '../theme.dart';
import 'login_page.dart';
import 'data_diri_page.dart';
import 'poin_page.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: navy,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 55,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Admin SKANOVA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          ListTile(
            leading: const Icon(
              Icons.badge,
              color: navy,
            ),
            title: const Text('Data Diri'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DataDiriPage(),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.stars,
              color: navy,
            ),
            title: const Text('Poin Pelanggaran'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PoinPage(),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Keluar',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}