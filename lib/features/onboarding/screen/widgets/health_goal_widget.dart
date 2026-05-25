import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_state.dart';
import 'package:calorie_ai_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kGoals = [
  (label: 'Weight Loss', icon: Icons.trending_down_rounded),
  (label: 'Maintenance', icon: Icons.swap_horiz),
  (label: 'Muscle Gain', icon: Icons.trending_up_rounded),
];

class HealthGoalWidget extends StatelessWidget {
  const HealthGoalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Goal', style: AppTypography.headlineLarge),
        const SizedBox(height: 10),
        Text(
          'Choose the goal you want to focus on.',
          style: AppTypography.bodyMedium.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: Center(
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,

                  children: _kGoals.map((goal) {
                    final isSelected = state.goal == goal.label;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _GoalCard(
                        label: goal.label,
                        icon: goal.icon,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<OnboardingCubit>().updateGoal(
                            goal.label,
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final contentColor = isSelected ? Colors.black : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: contentColor, size: 28),
            const SizedBox(width: 16),

            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyLarge.copyWith(
                  color: contentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}
