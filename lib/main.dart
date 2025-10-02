import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:biboo_pro/presentation/auth/pages/login.dart';
import 'core/constants/di/getIt.dart';
import 'core/services/hive_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  

  await configureDependencies();
  await Hive.initFlutter();
  await HiveRepository.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: const Login(),
      // Optional: add localization delegates if needed
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
