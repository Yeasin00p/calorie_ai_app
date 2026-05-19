import 'package:calorie_ai_app/core/routes/app_routes.dart';
import 'package:calorie_ai_app/features/home/home_screen.dart';
import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:calorie_ai_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:calorie_ai_app/features/setting/setting_screen.dart';
import 'package:calorie_ai_app/features/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => OnboardingCubit(),
            child: const OnboardingScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
