import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_state.dart';
import 'package:calorie_ai_app/theme/app_colors.dart';
import 'package:calorie_ai_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _kMale = 'Male';
const _kFemale = 'Female';

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What is your\biological sex', style: AppTypography.headlineLarge),
        const SizedBox(height: 10),
        Text(
          'This helps us calculate your metabolism',
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: 20),
        BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Column(
              children: [
                _GenderCard(
                  label: _kMale,
                  icon: Icons.male,
                  isSelected: state.gender == _kMale,
                  onTap: () {
                    context.read<OnboardingCubit>().updateGender(_kMale);
                  },
                ),
                const SizedBox(height: 12),
                _GenderCard(
                  label: _kFemale,
                  icon: Icons.female,
                  isSelected: state.gender == _kFemale,
                  onTap: () {
                    context.read<OnboardingCubit>().updateGender(_kFemale);
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final contentColor = isSelected ? AppColors.black : AppColors.grey;
    final borderColor = isSelected
        ? AppColors.black
        : AppColors.grey.withValues(alpha: 0.3);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 0.5),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: contentColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: contentColor,
                ),
              ),
            ),
            if (isSelected)
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.black,
                child: Icon(Icons.check, size: 12, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
