import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/app_typography.dart';
import '../../cubit/onboarding_state.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key});
  static const List<Map<String, String>> _activityLevels = [
    {'label': 'Sedentary', 'description': 'Little or no exercise'},
    {'label': 'Light', 'description': 'Exercise 1-3 days/week'},
    {'label': 'Moderate', 'description': 'Exercise 3-5 days/week'},
    {'label': 'Active', 'description': 'Exercise 6-7 days/week'},
    {'label': 'Very Active', 'description': 'Hard exercise daily'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('How active are you?', style: AppTypography.headlineLarge),
          const SizedBox(height: 10),
          Text(
            'Your daily activity affects calorie needs.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 32),
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return Column(
                children: _activityLevels.map((activity) {
                  final label = activity['label']!;
                  final description = activity['description']!;
                  final isSelected = state.activityLevel == label;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ActivityCard(
                      label: label,
                      description: description,
                      isSelected: isSelected,
                      onTap: () {
                        context.read<OnboardingCubit>().updateActivityLevel(
                          label,
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
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
