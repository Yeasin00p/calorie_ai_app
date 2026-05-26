class CalorieCalculator {
  static int fallbackEstimateCalories({
    required double weight,
    required double height,
    required int age,
    required String activityLevel,
    required String gender,
  }) {
    double bmr;

    if (gender == 'Male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else if (gender == 'Female') {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    } else {
      double maleBmr =
          88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      double femaleBmr =
          447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      bmr = (maleBmr + femaleBmr) / 2;
    }

    double activityMultiplier = switch (activityLevel) {
      'Sedentary' => 1.2,
      'Light' => 1.375,
      'Moderate' => 1.55,
      'Active' => 1.725,
      'Very Active' => 1.9,
      _ => 1.2,
    };

    return (bmr * activityMultiplier).toInt();
  }

  static int calculateCaloriesBasedOnGoal({
    required int maintenanceCalories,
    required String goal,
  }) {
    return switch (goal) {
      'Weight Loss' => (maintenanceCalories * 0.8).round(),
      'Muscle Gain' => (maintenanceCalories * 1.15).round(),
      _ => maintenanceCalories,
    };
  }

  static Map<String, int> calculateMacroGoals({
    required int calories,
    required String goal,
  }) {
    double proteinPercent;
    double fatPercent;
    double carbsPercent;

    switch (goal) {
      case 'Weight Loss':
        proteinPercent = 0.30;
        fatPercent = 0.25;
        carbsPercent = 0.45;
        break;
      case 'Muscle Gain':
        proteinPercent = 0.25;
        fatPercent = 0.25;
        carbsPercent = 0.50;
        break;
      default:
        proteinPercent = 0.25;
        fatPercent = 0.25;
        carbsPercent = 0.50;
    }

    return {
      'proteinGoal': (calories * proteinPercent / 4).round(),
      'fatGoal': (calories * fatPercent / 9).round(),
      'carbsGoal': (calories * carbsPercent / 4).round(),
    };
  }

  static int calculateWaterIntake({
    required double weight,
    required String activityLevel,
  }) {
    double baseWater = weight * 33;

    double activityMultiplier = switch (activityLevel) {
      'Sedentary' => 1.0,
      'Light' => 1.1,
      'Moderate' => 1.2,
      'Active' => 1.3,
      'Very Active' => 1.4,
      _ => 1.0,
    };

    return (baseWater * activityMultiplier).round();
  }

  static int calculateProteinNeeds({
    required double weight,
    required String activityLevel,
    required String goal,
  }) {
    double proteinMultiplier = switch (goal) {
      'Weight Loss' => 2.0,
      'Muscle Gain' => 2.2,
      _ => 1.8,
    };

    if (activityLevel == 'Active' || activityLevel == 'Very Active') {
      proteinMultiplier += 0.2;
    }

    return (weight * proteinMultiplier).round();
  }
}
