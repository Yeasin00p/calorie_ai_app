import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/food_item.dart';
import '../../data/repositories/food_repository.dart';
import 'food_log_state.dart';

class FoodLogCubit extends Cubit<FoodLogState> {
  final FoodRepository _repository;

  FoodLogCubit(this._repository) : super(FoodLogState()) {
    loadMeals();
  }

  Future<void> loadMeals() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final meals = await _repository.getByDate(state.selectedDate);

      final totals = _computeTotals(meals);

      emit(
        state.copyWith(
          meals: meals,
          totalCalories: totals['calories'] ?? 0,
          totalProtein: totals['protein'] ?? 0,
          totalCarbs: totals['carbs'] ?? 0,
          totalFat: totals['fat'] ?? 0,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> selectDate(DateTime date) async {
    emit(state.copyWith(selectedDate: _normalizeDate(date)));

    await loadMeals();
  }

  Future<void> addMeal(FoodItem meal) async {
    await _repository.add(meal);
    await loadMeals();
  }

  Future<void> deleteMeal(FoodItem meal) async {
    await _repository.delete(meal);
    await loadMeals();
  }

  Future<void> updateMeal(FoodItem meal) async {
    await _repository.update(meal);
    await loadMeals();
  }

  Map<String, double> _computeTotals(List<FoodItem> meals) {
    double calories = 0;
    double protein = 0;
    double carbs = 0;
    double fat = 0;

    for (final meal in meals) {
      calories += meal.calories;
      protein += meal.protein;
      carbs += meal.carbs;
      fat += meal.fat;
    }

    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
