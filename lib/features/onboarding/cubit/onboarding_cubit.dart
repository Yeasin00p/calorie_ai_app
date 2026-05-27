import 'package:calorie_ai_app/features/onboarding/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void updateGender(String value) => emit(state.copyWith(gender: value));

  void updateAge(int value) => emit(state.copyWith(age: value));

  void updateWeight(double value) => emit(state.copyWith(weight: value));

  void updateHeight(double value) => emit(state.copyWith(height: value));

  void updateActivityLevel(String value) =>
      emit(state.copyWith(activityLevel: value));

  void updateGoal(String value) => emit(state.copyWith(goal: value));
}
