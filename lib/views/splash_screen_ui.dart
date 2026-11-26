import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import 'home_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    // แทนหน้า Splash เพื่อให้ปุ่มย้อนกลับไม่พากลับมารออีกครั้ง
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (context) => const HomeUI()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Image.asset(
                    'assets/icon/icon.png',
                    width: 176,
                    height: 176,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'THAI HOTLINE APP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: navy,
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'สายด่วน',
                  style: TextStyle(color: navy, fontSize: 23),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
