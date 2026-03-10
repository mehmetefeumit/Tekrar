import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'router.dart';

class TekrarApp extends StatelessWidget {
  const TekrarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tekrar',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
