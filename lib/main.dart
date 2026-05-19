import 'package:calorie_ai_app/core/routes/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Calorie Ai App',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
