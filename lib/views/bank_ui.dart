import 'package:material_ui/material_ui.dart';

import '../models/hotline_data.dart';
import '../widgets/hotline_list.dart';

class BankUI extends StatelessWidget {
  const BankUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const HotlineList(
      title: 'ธนาคาร',
      banner: 'assets/images/bank/bank_0.png',
      hotlines: bankHotlines,
    );
  }
}
