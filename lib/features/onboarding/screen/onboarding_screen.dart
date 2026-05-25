import 'package:calorie_ai_app/features/onboarding/screen/widgets/health_goal_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(children: [Expanded(child: HealthGoalWidget())]),
        ),
      ),
    );
  }
}
