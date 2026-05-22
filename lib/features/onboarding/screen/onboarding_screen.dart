import 'package:calorie_ai_app/features/onboarding/screen/widgets/age_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ AgeWidget()]));
  }
}
