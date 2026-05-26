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
}
