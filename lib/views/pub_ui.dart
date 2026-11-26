import 'package:material_ui/material_ui.dart';

import '../models/hotline_data.dart';
import '../widgets/hotline_list.dart';

class PubUI extends StatelessWidget {
  const PubUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const HotlineList(
      title: 'สาธารณูปโภค',
      banner: 'assets/images/pubutil/pub_0.png',
      hotlines: publicHotlines,
    );
  }
}
