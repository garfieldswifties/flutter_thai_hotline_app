import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_thai_hotline_app/main.dart';
import 'package:flutter_thai_hotline_app/models/hotline.dart';
import 'package:flutter_thai_hotline_app/models/hotline_data.dart';
import 'package:flutter_thai_hotline_app/views/about_ui.dart';
import 'package:flutter_thai_hotline_app/views/home_ui.dart';
import 'package:flutter_thai_hotline_app/views/splash_screen_ui.dart';
import 'package:flutter_thai_hotline_app/widgets/hotline_list.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class FakePhoneLauncher extends UrlLauncherPlatform {
  @override
  LinkDelegate? get linkDelegate => null;

  final requests = <String>[];
  final modes = <PreferredLaunchMode>[];
  bool result = true;
  bool throwsPlatformException = false;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    requests.add(url);
    modes.add(options.mode);
    if (throwsPlatformException) {
      throw PlatformException(code: 'NO_HANDLER');
    }
    return result;
  }
}

const tabLabels = ['การเดินทาง', 'ฉุกเฉิน', 'ธนาคาร', 'สาธารณูปโภค'];
const categoryHotlines = [
  travelHotlines,
  emergencyHotlines,
  bankHotlines,
  publicHotlines,
];

Future<void> openApp(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const FlutterThaiHotlineApp());
  expect(find.byType(SplashScreenUI), findsOneWidget);
  expect(find.text('THAI HOTLINE APP'), findsOneWidget);
  await tester.pump(const Duration(milliseconds: 2999));
  expect(find.byType(SplashScreenUI), findsOneWidget);
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pumpAndSettle();
  expect(find.byType(SplashScreenUI), findsNothing);
  expect(find.byType(HomeUI), findsOneWidget);
  expect(Navigator.of(tester.element(find.byType(HomeUI))).canPop(), isFalse);
  expect(tester.takeException(), isNull);
}

Future<void> selectTab(WidgetTester tester, int index) async {
  final nav = find.byType(BottomNavigationBar);
  final tab = find.descendant(of: nav, matching: find.text(tabLabels[index]));
  await tester.tap(tab);
  await tester.pumpAndSettle();
  expect(tester.widget<BottomNavigationBar>(nav).currentIndex, index);
}

void main() {
  testWidgets('all reference numbers and local image assets are bundled', (
    tester,
  ) async {
    const expectedNumbers = [
      '1146 1155 1193 1197 1348 1490 1543 1586 1690',
      '191 199 1192 1196 1300 1356 1554 1646 1669',
      '1333 1115 028888888 021111111 1572 1428 1588 1327 026459000 027777777 021655555 026975454 022851555 026336000 022042766 026267777',
      '1130 1129 1416 1125 1662 1242 1678 1175 1100',
    ];
    const imageDirectories = [
      'travel/travel',
      'emergency/emg',
      'bank/bank',
      'pubutil/pub',
    ];
    final assets = await AssetManifest.loadFromAssetBundle(rootBundle);
    for (var group = 0; group < categoryHotlines.length; group++) {
      final hotlines = categoryHotlines[group];
      final numbers = expectedNumbers[group].split(' ');
      expect(hotlines.length, numbers.length);
      final path = 'assets/images/${imageDirectories[group]}';
      expect(assets.listAssets(), contains('${path}_0.png'));
      for (var index = 0; index < hotlines.length; index++) {
        final hotline = hotlines[index];
        expect(hotline.name, isNotEmpty);
        expect(hotline.phoneUri, Uri.parse('tel:${numbers[index]}'));
        expect(hotline.image, '${path}_${index + 1}.png');
        expect(assets.listAssets(), contains(hotline.image));
      }
    }
    expect(
      assets.listAssets(),
      containsAll([
        'assets/icon/icon.png',
        'assets/images/aboutme/saulogo.png',
        'assets/images/aboutme/me.png',
      ]),
    );
    const formatted = Hotline('ตัวอย่าง', '02-888 8888', 'example.png');
    expect(formatted.phoneUri.toString(), 'tel:028888888');
  });

  for (final size in const [Size(440, 956), Size(430, 932), Size(320, 568)]) {
    testWidgets(
      'navigation, all rows and About at ${size.width} × ${size.height}',
      (tester) async {
        await openApp(tester, size);
        for (var index = 0; index < categoryHotlines.length; index++) {
          await selectTab(tester, index);
          final category = categoryHotlines[index];
          final list = find.descendant(
            of: find.byType(HotlineList),
            matching: find.byType(Scrollable),
          );
          for (final hotline in category) {
            final name = find.text(hotline.name);
            await tester.scrollUntilVisible(name, 160, scrollable: list);
            await tester.pumpAndSettle();
            final tile = find.ancestor(
              of: name,
              matching: find.byType(ListTile),
            );
            expect(
              find.descendant(of: tile, matching: find.text(hotline.phone)),
              findsOneWidget,
            );
            expect(
              find.descendant(
                of: tile,
                matching: find.byTooltip('โทร ${hotline.phone}'),
              ),
              findsOneWidget,
            );
            final logo = tester.widget<Image>(
              find.descendant(of: tile, matching: find.byType(Image)),
            );
            expect((logo.image as AssetImage).assetName, hotline.image);
            expect(tester.takeException(), isNull);
          }
        }

        await tester.tap(find.byTooltip('ผู้จัดทำ'));
        await tester.pumpAndSettle();
        expect(find.byType(AboutUI), findsOneWidget);
        expect(find.text('มหาวิทยาลัยเอเชียอาคเนย์'), findsOneWidget);
        final aboutList = find.byType(Scrollable);
        await tester.scrollUntilVisible(
          find.text('garfieldswifties'),
          120,
          scrollable: aboutList,
        );
        await tester.scrollUntilVisible(
          find.text('ชื่อคณะ'),
          120,
          scrollable: aboutList,
        );
        expect(find.text('ไม่ได้ระบุข้อมูล'), findsWidgets);
        expect(tester.takeException(), isNull);

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
        expect(find.byType(AboutUI), findsNothing);
        expect(
          tester
              .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
              .currentIndex,
          3,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'row and icon each make one external launch and report failures',
    (tester) async {
      final previous = UrlLauncherPlatform.instance;
      final fake = FakePhoneLauncher();
      UrlLauncherPlatform.instance = fake;
      addTearDown(() => UrlLauncherPlatform.instance = previous);

      await openApp(tester, const Size(440, 956));
      await selectTab(tester, 2);
      await tester.tap(find.text('ธนาคารกสิกรไทย'));
      await tester.pumpAndSettle();
      expect(fake.requests, ['tel:028888888']);

      await tester.tap(find.byTooltip('โทร 02 888 8888'));
      await tester.pumpAndSettle();
      expect(fake.requests, ['tel:028888888', 'tel:028888888']);
      expect(fake.modes, everyElement(PreferredLaunchMode.externalApplication));
      expect(find.byType(SnackBar), findsNothing);

      fake.result = false;
      await tester.tap(find.byTooltip('โทร 02 888 8888'));
      await tester.pumpAndSettle();
      expect(fake.requests.length, 3);
      expect(
        find.text('เปิดแอปโทรศัพท์ไม่ได้ เบอร์ 02 888 8888'),
        findsOneWidget,
      );
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      fake.throwsPlatformException = true;
      await tester.tap(find.text('ธนาคารกสิกรไทย'));
      await tester.pumpAndSettle();
      expect(fake.requests.length, 4);
      expect(
        find.text('เปิดแอปโทรศัพท์ไม่ได้ เบอร์ 02 888 8888'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
