import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import '../models/hotline_data.dart';
import '../widgets/hotline_list.dart';

class EmgUI extends StatelessWidget {
  const EmgUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const HotlineList(
      title: 'อุบัติเหตุ-เหตุฉุกเฉิน',
      banner: 'assets/images/emergency/emg_0.png',
      hotlines: emergencyHotlines,
      accent: emergencyRed,
    );
  }
}
