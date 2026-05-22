import 'package:calorie_ai_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/onboarding_cubit.dart';

const _kStartYear = 1924;
const _kItemExtent = 52.0;

class AgeWidget extends StatefulWidget {
  const AgeWidget({super.key});

  @override
  State<AgeWidget> createState() => _AgeWidgetState();
}

class _AgeWidgetState extends State<AgeWidget> {
  late final FixedExtentScrollController _monthController;
  late final FixedExtentScrollController _dayController;
  late final FixedExtentScrollController _yearController;

  final List<String> _months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  late final List<int> _years;

  int _selectedMonth = 0;
  int _selectedDay = 0;
  late int _selectedYearIndex;

  @override
  void initState() {
    super.initState();

    _years = List.generate(
      DateTime.now().year - _kStartYear + 1,
      (index) => _kStartYear + index,
    );

    _selectedYearIndex = 2000 - _kStartYear;

    _monthController = FixedExtentScrollController(initialItem: 0);
    _dayController = FixedExtentScrollController(initialItem: 0);
    _yearController = FixedExtentScrollController(
      initialItem: _selectedYearIndex,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notify();
    });
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _computeAge() {
    final now = DateTime.now();

    final birthDate = DateTime(
      _years[_selectedYearIndex],
      _selectedMonth + 1,
      _selectedDay + 1,
    );

    int age = now.year - birthDate.year;

    final hasHadBirthday =
        (now.month > birthDate.month) ||
        (now.month == birthDate.month && now.day >= birthDate.day);

    if (!hasHadBirthday) {
      age--;
    }

    return age;
  }

  void _notify() {
    final age = _computeAge();

    context.read<OnboardingCubit>().updateAge(age);
  }

  void _validateDay() {
    final maxDays = DateUtils.getDaysInMonth(
      _years[_selectedYearIndex],
      _selectedMonth + 1,
    );

    if ((_selectedDay + 1) > maxDays) {
      _selectedDay = maxDays - 1;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _dayController.jumpToItem(_selectedDay);

        _notify();
      });
    } else {
      _notify();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final selectedYear = _years[_selectedYearIndex];

    final daysInMonth = DateUtils.getDaysInMonth(
      selectedYear,
      _selectedMonth + 1,
    );

    final days = List.generate(daysInMonth, (index) => index + 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("When were you\nborn?", style: AppTypography.headlineLarge),
        const SizedBox(height: 10),
        Text(
          'This will be used to calibrate your custom plan.',
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: _kItemExtent * 5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 2),
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _PickerColumn(
                      controller: _monthController,
                      items: _months,
                      selectedIndex: _selectedMonth,
                      onChanged: (index) {
                        setState(() {
                          _selectedMonth = index;
                        });

                        _validateDay();
                      },
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: _PickerColumn(
                      controller: _dayController,
                      items: days.map((e) => e.toString()).toList(),
                      selectedIndex: _selectedDay,
                      onChanged: (index) {
                        setState(() {
                          _selectedDay = index;
                        });

                        _notify();
                      },
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: _PickerColumn(
                      controller: _yearController,
                      items: _years.map((e) => e.toString()).toList(),
                      selectedIndex: _selectedYearIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedYearIndex = index;
                        });

                        _validateDay();
                      },
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Column(
                    children: [
                      Container(
                        height: _kItemExtent * 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              scaffoldColor,
                              scaffoldColor.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: _kItemExtent * 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              scaffoldColor,
                              scaffoldColor.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PickerColumn extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _PickerColumn({
    required this.controller,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: _kItemExtent,
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
                    : Colors.grey.withValues(alpha: 0.3),
              ),
              child: Text(items[index]),
            ),
          );
        },
      ),
    );
  }
}
