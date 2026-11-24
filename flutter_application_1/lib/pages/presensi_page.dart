import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;

import 'attendance_storage.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  final ImagePicker picker = ImagePicker();
  final loc.Location location = loc.Location();

  Uint8List? fotoBytes;
  loc.LocationData? posisi;

  bool masukSelesai = false;
  bool pulangSelesai = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    cekPresensi();
  }

  Future<void> cekPresensi() async {
    final masuk = await AttendanceStorage.isMasukToday();
    final pulang = await AttendanceStorage.isPulangToday();

    if (!mounted) return;

    setState(() {
      masukSelesai = masuk;
      pulangSelesai = pulang;
    });
  }

  Future<void> ambilFoto() async {
    try {
      final XFile? hasil = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );

      if (hasil == null) return;

      final bytes = await hasil.readAsBytes();

      if (!mounted) return;

      setState(() {
        fotoBytes = bytes;
      });
    } catch (e) {
      tampilPesan('Kamera tidak dapat dibuka: $e');
    }
  }

  Future<void> ambilLokasi() async {
    setState(() {
      loading = true;
    });

    try {
      bool serviceAktif = await location.serviceEnabled();

      if (!serviceAktif) {
        serviceAktif = await location.requestService();
      }

      if (!serviceAktif) {
        tampilPesan('Aktifkan GPS terlebih dahulu.');
        return;
      }

      loc.PermissionStatus izin = await location.hasPermission();

      if (izin == loc.PermissionStatus.denied) {
        izin = await location.requestPermission();
      }

      if (izin != loc.PermissionStatus.granted) {
        tampilPesan('Izin lokasi belum diberikan.');
        return;
      }

      final hasil = await location.getLocation();

      if (hasil.latitude == null || hasil.longitude == null) {
        tampilPesan('Lokasi belum berhasil didapatkan.');
        return;
      }

      if (!mounted) return;

      setState(() {
        posisi = hasil;
      });

      tampilPesan('Lokasi berhasil didapatkan.');
    } catch (e) {
      tampilPesan('Gagal mengambil lokasi: $e');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> konfirmasiPresensi() async {
    if (fotoBytes == null) {
      tampilPesan('Silakan ambil foto terlebih dahulu.');
      return;
    }

    if (posisi == null) {
      tampilPesan('Silakan ambil lokasi GPS terlebih dahulu.');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      if (!masukSelesai) {
        await AttendanceStorage.markMasuk();
        masukSelesai = true;
      } else if (!pulangSelesai) {
        await AttendanceStorage.markPulang();
        pulangSelesai = true;
      }

      if (!mounted) return;

      setState(() {
        fotoBytes = null;
        posisi = null;
      });

      tampilPesan(
        masukSelesai && pulangSelesai
            ? 'Presensi pulang berhasil!'
            : 'Presensi masuk berhasil!',
      );
    } catch (e) {
      tampilPesan('Presensi gagal disimpan: $e');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void tampilPesan(String pesan) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  String get tahapPresensi {
    if (!masukSelesai) return 'Presensi Masuk';
    if (!pulangSelesai) return 'Presensi Pulang';
    return 'Presensi Selesai';
  }

  @override
  Widget build(BuildContext context) {
    final sudahSelesai = masukSelesai && pulangSelesai;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Presensi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF102A43),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PRESENSI SKANOVA',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tahapPresensi,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sudahSelesai
                        ? 'Presensi masuk dan pulang hari ini sudah selesai.'
                        : 'Lengkapi foto dan lokasi untuk melakukan presensi.',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Status Presensi Hari Ini',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            statusCard(
              'Presensi Masuk',
              masukSelesai,
              Icons.login,
            ),

            const SizedBox(height: 10),

            statusCard(
              'Presensi Pulang',
              pulangSelesai,
              Icons.logout,
            ),

            const SizedBox(height: 24),

            if (!sudahSelesai) ...[
              const Text(
                'Verifikasi Presensi',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E7EF)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    if (fotoBytes == null)
                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F8FC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 48,
                              color: Color(0xFF78909C),
                            ),
                            SizedBox(height: 8),
                            Text('Belum ada foto'),
                          ],
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          fotoBytes!,
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: loading ? null : ambilFoto,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Ambil Foto'),
                      ),
                    ),

                    const Divider(height: 28),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF1976D2),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            posisi == null
                                ? 'Lokasi belum diambil'
                                : 'Lat: ${posisi!.latitude}, Long: ${posisi!.longitude}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: loading ? null : ambilLokasi,
                        icon: const Icon(Icons.my_location),
                        label: const Text('Ambil Lokasi GPS'),
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loading ? null : konfirmasiPresensi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF102A43),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text('Konfirmasi $tahapPresensi'),
                      ),
                    ),
                  ],
                ),
              ),
            ] else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 42,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Presensi Hari Ini Selesai!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget statusCard(String judul, bool selesai, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E7EF)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1976D2), size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              judul,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            selesai ? 'Sudah' : 'Belum',
            style: TextStyle(
              color: selesai ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}