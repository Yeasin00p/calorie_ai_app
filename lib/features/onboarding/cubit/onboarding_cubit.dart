import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/calorie_calculator.dart';
import '../data/local/preference_manager.dart';
import '../data/model/user_model.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PreferenceManager _prefManager;

  OnboardingCubit(this._prefManager) : super(const OnboardingState());

  void updateGender(String value) => emit(state.copyWith(gender: value));

  void updateAge(int value) => emit(state.copyWith(age: value));

  void updateWeight(double value) => emit(state.copyWith(weight: value));

  void updateHeight(double value) => emit(state.copyWith(height: value));

  void updateActivityLevel(String value) =>
      emit(state.copyWith(activityLevel: value));

  void updateGoal(String value) => emit(state.copyWith(goal: value));

  Future<void> saveAndCalculate() async {
    final heightInCm = state.height!;

    final maintenanceCalories = CalorieCalculator.fallbackEstimateCalories(
      weight: state.weight!,
      height: heightInCm,
      age: state.age!,
      activityLevel: state.activityLevel,
      gender: state.gender,
    );

    final adjustedCalories = CalorieCalculator.calculateCaloriesBasedOnGoal(
      maintenanceCalories: maintenanceCalories,
      goal: state.goal,
    );

    final macros = CalorieCalculator.calculateMacroGoals(
      calories: adjustedCalories,
      goal: state.goal,
    );

    emit(
      state.copyWith(
        estimatedCalories: adjustedCalories,
        proteinGoal: macros['protein']!.toDouble(),
        fatGoal: macros['fat']!.toDouble(),
        carbsGoal: macros['carbs']!.toDouble(),
      ),
    );

    final userData = UserData(
      weight: state.weight!,
      height: heightInCm,
      age: state.age!,
      activityLevel: state.activityLevel,
      gender: state.gender,
      goal: state.goal,
      estimatedCalories: adjustedCalories,
      proteinGoal: macros['protein']!,
      fatGoal: macros['fat']!,
      carbsGoal: macros['carbs']!,
    );

    await _prefManager.saveUserData(userData);
    await _prefManager.setOnboardingComplete();
  }
}
