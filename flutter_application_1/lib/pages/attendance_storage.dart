import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceStorage {
  static final ValueNotifier<bool> attendanceNotifier =
      ValueNotifier<bool>(false);

  static final ValueNotifier<bool> pulangNotifier =
      ValueNotifier<bool>(false);

  static String get today {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  static Future<bool> isMasukToday() async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString('tanggal_masuk') == today &&
        prefs.getBool('presensi_masuk') == true;

    attendanceNotifier.value = result;
    return result;
  }

  static Future<bool> isPulangToday() async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString('tanggal_pulang') == today &&
        prefs.getBool('presensi_pulang') == true;

    pulangNotifier.value = result;
    return result;
  }

  static Future<void> markMasuk() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('tanggal_masuk', today);
    await prefs.setBool('presensi_masuk', true);
    await prefs.setString(
      'waktu_masuk',
      DateTime.now().toIso8601String(),
    );

    attendanceNotifier.value = true;
  }

  static Future<void> markPulang() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('tanggal_pulang', today);
    await prefs.setBool('presensi_pulang', true);
    await prefs.setString(
      'waktu_pulang',
      DateTime.now().toIso8601String(),
    );

    pulangNotifier.value = true;
  }

  static Future<String?> getWaktuMasuk() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('waktu_masuk');
  }

  static Future<String?> getWaktuPulang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('waktu_pulang');
  }
}