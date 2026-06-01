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
            const SizedBox(height: 36),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _MacroItem(
                    value: '${state.proteinGoal.toInt()}g',
                    label: 'Protein',
                    color: const Color(0xFF5B8DEF),
                  ),
                  _VerticalDivider(),
                  _MacroItem(
                    value: '${state.carbsGoal.toInt()}g',
                    label: 'Carbs',
                    color: const Color(0xFFF5A623),
                  ),
                  _VerticalDivider(),
                  _MacroItem(
                    value: '${state.fatGoal.toInt()}g',
                    label: 'Fat',
                    color: const Color(0xFFF5654A),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.center,
              child: Text(
                "You're all set! Start scanning your meals\nand we'll help you stay on track.",
                textAlign: TextAlign.center,
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

class _MacroItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _MacroItem({
    required this.value,
    required this.label,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.labelSmall.copyWith(color: color, fontSize: 22),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: const Color(0xFFE8E8E8));
  }
}
