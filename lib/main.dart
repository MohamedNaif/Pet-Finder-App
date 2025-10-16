import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder_app/bloc_observer.dart';
import 'package:pet_finder_app/config/lang_manager.dart';
import 'package:pet_finder_app/config/routing/app_router.dart';
import 'package:pet_finder_app/config/theme/app_theme.dart';
import 'package:pet_finder_app/core/di/dependency_injection.dart';
import 'package:pet_finder_app/core/storage/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.initialSharedPreference();

  Bloc.observer = MyBlocObserver();
  MyBlocObserver();

  setupDependencyInjection();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocal, englishLocal],
      fallbackLocale: englishLocal,
      path: assetsLocalization,

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    context.setLocale(arabicLocal);
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
      routerConfig: router,
      theme: AppTheme.lightTheme,
     
    );
  }
}
