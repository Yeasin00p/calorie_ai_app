import 'package:flutter/material.dart';

const kPickerItemExtent = 52.0;

class PickerColumn extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const PickerColumn({
    super.key,
    required this.controller,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: kPickerItemExtent,
      physics: const FixedExtentScrollPhysics(),
      perspective: 0.002,
      diameterRatio: 1.3,
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: items.length,
        builder: (context, index) {
          final isSelected = index == selectedIndex;

          return Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontSize: isSelected ? 17 : 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? Colors.black
                    : Colors.grey.withValues(alpha: 0.8),
              ),
              child: Text(items[index]),
            ),
          );
        },
      ),
    );
  }
}
