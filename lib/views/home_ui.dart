import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import 'about_ui.dart';
import 'bank_ui.dart';
import 'emg_ui.dart';
import 'pub_ui.dart';
import 'travel_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [TravelUI(), EmgUI(), BankUI(), PubUI()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            tooltip: 'ผู้จัดทำ',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => const AboutUI()),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(bottom: false, child: _pages[_currentIndex]),
      // แสดงหมวดที่เลือกด้วย currentIndex ตามตัวอย่างในบทเรียน
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: _currentIndex == 1 ? emergencyRed : navy,
        unselectedItemColor: const Color(0xFF515F70),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            activeIcon: Icon(Icons.directions_bus, size: 27),
            label: 'การเดินทาง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_outlined),
            activeIcon: Icon(Icons.emergency, size: 27),
            label: 'ฉุกเฉิน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            activeIcon: Icon(Icons.account_balance, size: 27),
            label: 'ธนาคาร',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt_outlined),
            activeIcon: Icon(Icons.bolt, size: 27),
            label: 'สาธารณูปโภค',
          ),
        ],
      ),
    );
  }
}
