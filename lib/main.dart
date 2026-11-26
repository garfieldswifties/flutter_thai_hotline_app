import 'package:material_ui/material_ui.dart';

import 'app_theme.dart';
import 'views/splash_screen_ui.dart';

void main() {
  runApp(const FlutterThaiHotlineApp());
}

class FlutterThaiHotlineApp extends StatelessWidget {
  const FlutterThaiHotlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      locale: const Locale('th'),
      supportedLocales: const [Locale('th')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        fontFamily: 'Kanit',
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        scaffoldBackgroundColor: canvas,
        appBarTheme: const AppBarThemeData(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const SplashScreenUI(),
    );
  }
}
