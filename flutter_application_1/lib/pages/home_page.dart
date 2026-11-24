import 'package:flutter/material.dart';
import '../theme.dart';
import 'izin_page.dart';
import 'attendance_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AttendanceStorage.isMasukToday();
    AttendanceStorage.isPulangToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // HEADER PROFIL
            ClipPath(
              clipper: _HeaderClipper(),
              child: Container(
                height: 205,
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [navy, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 43,
                          height: 43,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 43,
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SKANOVA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              'SMK NEGERI 1 BUKATEJA',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 43,
                            color: navy,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HI, ADMIN!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'XI RPL 1 | SMK Negeri 1 Bukateja',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // KARTU PRESENSI
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: blue,
                      ),
                      SizedBox(width: 9),
                      Text(
                        'Presensi',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 25),

                  ValueListenableBuilder<bool>(
                    valueListenable:
                        AttendanceStorage.attendanceNotifier,
                    builder: (context, masuk, child) {
                      return _AttendanceRow(
                        title: 'Presensi Masuk',
                        selesai: masuk,
                        icon: Icons.circle,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  ValueListenableBuilder<bool>(
                    valueListenable:
                        AttendanceStorage.pulangNotifier,
                    builder: (context, pulang, child) {
                      return _AttendanceRow(
                        title: 'Presensi Pulang',
                        selesai: pulang,
                        icon: Icons.circle,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // JADWAL PEMBELAJARAN
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jadwal Pembelajaran',
                    style: TextStyle(
                      color: blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _ScheduleRow(
                    title: 'Pemrograman Dasar',
                    time: '07.00 - 09.00',
                    room: 'Lab Komputer',
                  ),

                  const Divider(height: 22),

                  _ScheduleRow(
                    title: 'Bahasa Indonesia',
                    time: '09.30 - 11.00',
                    room: 'Ruang Kelas',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // PENGAJUAN IZIN
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const IzinPage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 22,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.add,
                      color: Color(0xFF00A6C7),
                      size: 65,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'PENGAJUAN IZIN',
                      style: TextStyle(
                        color: blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Ajukan izin jika kamu berhalangan hadir',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// BARIS STATUS PRESENSI
class _AttendanceRow extends StatelessWidget {
  final String title;
  final bool selesai;
  final IconData icon;

  const _AttendanceRow({
    required this.title,
    required this.selesai,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: selesai ? green : Colors.grey.shade300,
          size: 45,
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: navy,
            ),
          ),
        ),
        Text(
          selesai ? 'Sudah Presensi' : 'Belum Presensi',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selesai ? green : muted,
          ),
        ),
      ],
    );
  }
}

// BARIS JADWAL
class _ScheduleRow extends StatelessWidget {
  final String title;
  final String time;
  final String room;

  const _ScheduleRow({
    required this.title,
    required this.time,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: navy,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          time,
          style: const TextStyle(
            color: muted,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          room,
          style: const TextStyle(
            color: muted,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// BENTUK HEADER MELENGKUNG
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 35);

    path.quadraticBezierTo(
      size.width * 0.65,
      size.height + 15,
      0,
      size.height - 25,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}