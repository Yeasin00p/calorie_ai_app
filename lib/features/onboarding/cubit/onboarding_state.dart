class OnboardingState {
  final String gender;
  final int age;
  final double weight;
  final double height;
  final String activityLevel;
  final String goal;
  final int estimatedCalories;
  final double proteinGoal;
  final double fatGoal;
  final double carbsGoal;

  const OnboardingState({
    this.gender = '',
    this.age = 0,
    this.weight = 0.0,
    this.height = 0.0,
    this.activityLevel = 'Moderate',
    this.goal = 'Maintenance',
    this.estimatedCalories = 0,
    this.proteinGoal = 0,
    this.fatGoal = 0,
    this.carbsGoal = 0,
  });
  OnboardingState copyWith({
    String? gender,
    int? age,
    double? weight,
    double? height,
    String? activityLevel,
    String? goal,
    int? estimatedCalories,
    double? proteinGoal,
    double? fatGoal,
    double? carbsGoal,
  }) {
    return OnboardingState(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      estimatedCalories: estimatedCalories ?? this.estimatedCalories,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      fatGoal: fatGoal ?? this.fatGoal,
      carbsGoal: carbsGoal ?? this.carbsGoal,
    );
  }
}
