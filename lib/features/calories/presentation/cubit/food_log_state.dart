import '../../data/models/food_item.dart';

class FoodLogState {
  static const _undefined = Object();

  final List<FoodItem> meals;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final DateTime selectedDate;
  final bool isLoading;
  final bool isScanning;
  final String? error;

  FoodLogState({
    this.meals = const [],
    this.totalCalories = 0,
    this.totalProtein = 0,
    this.totalCarbs = 0,
    this.totalFat = 0,
    DateTime? selectedDate,
    this.isLoading = false,
    this.isScanning = false,
    this.error,
  }) : selectedDate = selectedDate ?? _today();

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  FoodLogState copyWith({
    List<FoodItem>? meals,
    double? totalCalories,
    double? totalProtein,
    double? totalCarbs,
    double? totalFat,
    DateTime? selectedDate,
    bool? isLoading,
    bool? isScanning,
    Object? error = _undefined,
  }) {
    return FoodLogState(
      meals: meals ?? this.meals,
      totalCalories: totalCalories ?? this.totalCalories,
      totalProtein: totalProtein ?? this.totalProtein,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalFat: totalFat ?? this.totalFat,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      isScanning: isScanning ?? this.isScanning,
      error: error == _undefined ? this.error : error as String?,
    );
  }

  @override
  String toString() {
    return 'FoodLogState('
        'meals: ${meals.length}, '
        'totalCalories: $totalCalories, '
        'totalProtein: $totalProtein, '
        'totalCarbs: $totalCarbs, '
        'totalFat: $totalFat, '
        'selectedDate: $selectedDate, '
        'isLoading: $isLoading, '
        'isScanning: $isScanning, '
        'error: $error'
        ')';
  }
}
