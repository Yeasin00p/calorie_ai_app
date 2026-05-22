import 'package:flutter/material.dart';
import '../../../../theme/app_typography.dart';

class HeightWeightWidget extends StatelessWidget {
  const HeightWeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Height & Weight", style: AppTypography.headlineLarge),
        Text(
          'we\'ll use this for calorie calculaations',
          style: AppTypography.bodyMedium,
        ),
      ],
    );
  }
}
