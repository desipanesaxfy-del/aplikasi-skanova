import 'package:flutter/material.dart';

class IzinPage extends StatefulWidget {
  const IzinPage({super.key});

  @override
  State<IzinPage> createState() => _IzinPageState();
}

class _IzinPageState extends State<IzinPage> {
  final alasanController = TextEditingController();
  String jenisIzin = 'Sakit';

  @override
  void dispose() {
    alasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengajuan Izin')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Form Pengajuan Izin',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            initialValue: jenisIzin,
            decoration: const InputDecoration(
              labelText: 'Jenis Izin',
              border: OutlineInputBorder(),
            ),
            items: ['Sakit', 'Keperluan Keluarga', 'Lainnya']
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  jenisIzin = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: alasanController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Alasan Izin',
              hintText: 'Tuliskan alasan izin...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (alasanController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alasan izin harus diisi'),
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pengajuan izin berhasil (simulasi)'),
                  ),
                );
              },
              child: const Text('Kirim Pengajuan'),
            ),
          ),
        ],
      ),
    );
  }
}