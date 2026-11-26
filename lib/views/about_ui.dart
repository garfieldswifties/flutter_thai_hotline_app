import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({super.key});

  // แก้ข้อมูลผู้จัดทำได้ที่รายการนี้
  static const _details = {
    'รหัสนักศึกษา': 'ไม่ได้ระบุข้อมูล',
    'ชื่อ-สกุลนักศึกษา': 'garfieldswifties',
    'อีเมลนักศึกษา': 'ไม่ได้ระบุข้อมูล',
    'ชื่อสาขาวิชา': 'ไม่ได้ระบุข้อมูล',
    'ชื่อคณะ': 'ไม่ได้ระบุข้อมูล',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appName)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'ผู้จัดทำ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: navy,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset('assets/images/aboutme/saulogo.png', height: 92),
                const SizedBox(height: 10),
                const Text(
                  'มหาวิทยาลัยเอเชียอาคเนย์',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: navy,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/aboutme/me.png',
                      width: 116,
                      height: 116,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: Color(0xFFE0E7F0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        for (final detail in _details.entries)
                          ListTile(
                            dense: true,
                            title: Text(
                              detail.key,
                              style: const TextStyle(color: Color(0xFF515F70)),
                            ),
                            subtitle: Text(
                              detail.value,
                              style: const TextStyle(
                                color: navy,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
