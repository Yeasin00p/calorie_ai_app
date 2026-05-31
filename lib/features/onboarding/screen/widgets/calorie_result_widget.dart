import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_typography.dart';

class CalorieResultWidget extends StatelessWidget {
  const CalorieResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your plan is ready!', style: AppTypography.headlineLarge),
            const SizedBox(height: 10),
            Text(
              "Here's your personalized nutrition plan.",
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${state.estimatedCalories}',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFF5A623),
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your Daily calories',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.black.withValues(alpha: .6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
