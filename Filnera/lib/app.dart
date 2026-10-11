import 'package:flutter/material.dart';

import 'config/index.dart';
import 'core/services/theme_service.dart';
import 'core/theme/manara_theme.dart';

class ManaraApp extends StatefulWidget {
  const ManaraApp({super.key});

  @override
  State<ManaraApp> createState() => _ManaraAppState();
}

class _ManaraAppState extends State<ManaraApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemePreferenceService.initialMode;
    ThemePreferenceService.themeMode.addListener(_themeChanged);
  }

  @override
  void dispose() {
    ThemePreferenceService.themeMode.removeListener(_themeChanged);
    super.dispose();
  }

  void _themeChanged() {
    if (!mounted) return;
    setState(() => _themeMode = ThemePreferenceService.themeMode.value);
  }

  @override
  Widget build(BuildContext context) {
    final light = ManaraTheme.lightTheme();
    final dark = ManaraTheme.darkTheme();

    return AnimatedTheme(
      data: _themeMode == ThemeMode.dark ? dark : light,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
      child: MaterialApp.router(
        title: 'Filnera Store',
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        themeMode: _themeMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
