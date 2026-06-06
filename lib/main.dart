import 'package:calorie_ai_app/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/calories/data/repositories/food_repository.dart';
import 'features/calories/presentation/cubit/food_log_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = FoodRepository(prefs);
  runApp(
    BlocProvider(
       create: (_) => FoodLogCubit(repository),
       child: const MyApp(),
       ),
  );
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
