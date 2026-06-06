import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/food_item.dart';

class FoodRepository {
  final SharedPreferences _prefs;

  FoodRepository(this._prefs);

  String _keyForDate(DateTime date) {
    return 'food_log_'
        '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _saveItems(String key, List<FoodItem> items) async {
    await _prefs.setString(
      key,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<FoodItem>> getByDate(DateTime date) async {
    final key = _keyForDate(date);

    final jsonString = _prefs.getString(key);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded
        .map((item) => FoodItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> add(FoodItem item) async {
    final key = _keyForDate(item.timestamp);

    final items = await getByDate(item.timestamp);

    items.add(item);

    await _saveItems(key, items);
  }

  Future<void> delete(FoodItem item) async {
    final key = _keyForDate(item.timestamp);

    final items = await getByDate(item.timestamp);

    items.removeWhere((food) => food.id == item.id);

    await _saveItems(key, items);
  }

  Future<void> update(FoodItem item) async {
    final key = _keyForDate(item.timestamp);

    final items = await getByDate(item.timestamp);

    final index = items.indexWhere((food) => food.id == item.id);

    if (index == -1) return;

    items[index] = item;

    await _saveItems(key, items);
  }
}
