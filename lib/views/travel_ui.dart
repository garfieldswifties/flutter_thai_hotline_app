import 'package:material_ui/material_ui.dart';

import '../models/hotline_data.dart';
import '../widgets/hotline_list.dart';

class TravelUI extends StatelessWidget {
  const TravelUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const HotlineList(
      title: 'การเดินทาง',
      banner: 'assets/images/travel/travel_0.png',
      hotlines: travelHotlines,
    );
  }
}
