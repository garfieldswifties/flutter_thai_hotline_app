import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_theme.dart';
import '../models/hotline.dart';

class HotlineList extends StatelessWidget {
  const HotlineList({
    super.key,
    required this.title,
    required this.banner,
    required this.hotlines,
    this.accent = navy,
  });

  final String title;
  final String banner;
  final List<Hotline> hotlines;
  final Color accent;

  Future<void> _openDialer(BuildContext context, Hotline hotline) async {
    bool opened;
    try {
      // ส่ง tel URI ให้ระบบเปิดแอปโทรศัพท์
      opened = await launchUrl(
        hotline.phoneUri,
        mode: LaunchMode.externalApplication,
      );
    } on PlatformException {
      opened = false;
    }
    if (opened || !context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('เปิดแอปโทรศัพท์ไม่ได้ เบอร์ ${hotline.phone}')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: hotlines.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Text(
                    'สายด่วน',
                    style: TextStyle(
                      color: accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accent,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(banner, width: 256, fit: BoxFit.contain),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 14),
                    child: Text(
                      'หมายเลขจากโจทย์การศึกษา ยังไม่ได้ตรวจสอบความเป็นปัจจุบัน',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF515F70), fontSize: 12),
                    ),
                  ),
                ],
              );
            }

            final hotline = hotlines[index - 1];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE0E7F0)),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(12, 7, 10, 7),
                onTap: () => _openDialer(context, hotline),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    hotline.image,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(
                  hotline.name,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  hotline.phone,
                  style: const TextStyle(
                    color: Color(0xFF515F70),
                    fontSize: 15,
                  ),
                ),
                trailing: IconButton.filled(
                  tooltip: 'โทร ${hotline.phone}',
                  onPressed: () => _openDialer(context, hotline),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFE6F5EC),
                    foregroundColor: const Color(0xFF17633E),
                    minimumSize: const Size.square(48),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.phone, size: 17),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
