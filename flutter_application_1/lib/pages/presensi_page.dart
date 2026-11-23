import 'package:flutter/material.dart';
import '../theme.dart';

class PresensiPage extends StatelessWidget {
  const PresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Presensi Wajah')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 35),
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: line),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.face, size: 100, color: navy),
                  SizedBox(height: 12),
                  Text('Area Foto Wajah'),
                  Text(
                    'Foto presensi akan ditampilkan di sini',
                    style: TextStyle(color: muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur kamera belum diaktifkan'),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Ambil Foto'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur GPS belum diaktifkan'),
                    ),
                  );
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Periksa Lokasi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}