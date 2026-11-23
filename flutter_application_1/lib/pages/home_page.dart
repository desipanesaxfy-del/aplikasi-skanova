import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common_widgets.dart';
import 'presensi_page.dart';
import 'izin_page.dart';
import 'poin_page.dart';
import 'cbt_page.dart';
import 'pembelajaran_page.dart';
import 'akun_page_page.dart';
import 'data_diri_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [navy, blue],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELAMAT DATANG',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                Text(
                  'Halo, Admin!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Selamat beraktivitas di SKANOVA.',
                  style: TextStyle(color: Colors.white),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const SectionHeading('Ringkasan Hari Ini'),
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Kehadiran',
                  value: 'Hadir',
                  icon: Icons.check_circle,
                  color: green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  title: 'Poin',
                  value: '100',
                  icon: Icons.stars,
                  color: blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const SectionHeading('Menu Utama'),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _MenuCard(
                icon: Icons.face,
                title: 'Presensi Wajah',
                onTap: () => openPage(
                  context,
                  const PresensiPage(),
                ),
              ),
              _MenuCard(
                icon: Icons.edit_calendar,
                title: 'Pengajuan Izin',
                onTap: () => openPage(
                  context,
                  const IzinPage(),
                ),
              ),
              _MenuCard(
                icon: Icons.menu_book,
                title: 'Pembelajaran',
                onTap: () => openPage(
                  context,
                  const PembelajaranPage(),
                ),
              ),
              _MenuCard(
                icon: Icons.quiz,
                title: 'CBT',
                onTap: () => openPage(
                  context,
                  const CbtPage(),
                ),
              ),
              _MenuCard(
                icon: Icons.stars,
                title: 'Poin Pelanggaran',
                onTap: () => openPage(
                  context,
                  const PoinPage(),
                ),
              ),
              _MenuCard(
                icon: Icons.badge,
                title: 'Data Diri',
                onTap: () => openPage(
                  context,
                  const DataDiriPage(),
                ),
              ),
              _MenuCard(
                icon: Icons.person,
                title: 'Akun',
                onTap: () => openPage(
                  context,
                  const AkunPage(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const SectionHeading('Jadwal Hari Ini'),
          const InfoTile(
            icon: Icons.computer,
            title: 'Pemrograman Dasar',
            subtitle: '07.00 - 09.00 | Lab Komputer',
          ),
          const InfoTile(
            icon: Icons.book,
            title: 'Bahasa Indonesia',
            subtitle: '09.30 - 11.00 | Ruang Kelas',
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title, style: const TextStyle(color: muted)),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: line),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: blue, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}