import 'package:calorie_ai_app/core/routes/app_routes.dart';
import 'package:calorie_ai_app/features/home/home_screen.dart';
import 'package:calorie_ai_app/features/onboarding/onboarding_screen.dart';
import 'package:calorie_ai_app/features/setting/setting_screen.dart';
import 'package:calorie_ai_app/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
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
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
