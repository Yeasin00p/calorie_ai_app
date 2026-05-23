import 'package:calorie_ai_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/onboarding_cubit.dart';
import 'picker_column.dart';

const _kMinFeet = 3;
const _kMaxFeet = 7;

const _kMinInches = 0;
const _kMaxInches = 11;

const _kMinWeight = 40;
const _kMaxWeight = 200;

class HeightWeightWidget extends StatefulWidget {
  const HeightWeightWidget({super.key});

  @override
  State<HeightWeightWidget> createState() => _HeightWeightWidgetState();
}

class _HeightWeightWidgetState extends State<HeightWeightWidget> {
  late final FixedExtentScrollController _feetController;
  late final FixedExtentScrollController _inchesController;
  late final FixedExtentScrollController _weightController;

  final List<int> _feet = List.generate(
    _kMaxFeet - _kMinFeet + 1,
    (index) => _kMinFeet + index,
  );

  final List<int> _inches = List.generate(
    _kMaxInches - _kMinInches + 1,
    (index) => _kMinInches + index,
  );

  final List<int> _weights = List.generate(
    _kMaxWeight - _kMinWeight + 1,
    (index) => _kMinWeight + index,
  );

  // Defaults: 5ft 7in, 70kg
  int _selectedFeetIndex = 5 - _kMinFeet;
  int _selectedInchesIndex = 7;
  int _selectedWeightIndex = 70 - _kMinWeight;

  @override
  void initState() {
    super.initState();

    _feetController = FixedExtentScrollController(
      initialItem: _selectedFeetIndex,
    );

    _inchesController = FixedExtentScrollController(
      initialItem: _selectedInchesIndex,
    );

    _weightController = FixedExtentScrollController(
      initialItem: _selectedWeightIndex,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notify();
    });
  }

  @override
  void dispose() {
    _feetController.dispose();
    _inchesController.dispose();
    _weightController.dispose();

    super.dispose();
  }

  double _heightToCm() {
    final feet = _feet[_selectedFeetIndex];
    final inches = _inches[_selectedInchesIndex];

    return ((feet * 12) + inches) * 2.54;
  }

  void _notify() {
    final cubit = context.read<OnboardingCubit>();

    cubit.updateHeight(_heightToCm());

    cubit.updateWeight(_weights[_selectedWeightIndex].toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Height & Weight', style: AppTypography.headlineLarge),
        const SizedBox(height: 6),
        Text(
          "We'll use this for calorie calculations.",
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: 24),

        Row(
          children: const [
            Expanded(flex: 3, child: _ColumnLabel('FEET')),
            Expanded(flex: 3, child: _ColumnLabel('INCHES')),
            Expanded(flex: 4, child: _ColumnLabel('WEIGHT')),
          ],
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: kPickerItemExtent * 5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
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
                    flex: 3,
                    child: PickerColumn(
                      controller: _feetController,
                      items: _feet.map((e) => '$e ft').toList(),
                      selectedIndex: _selectedFeetIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedFeetIndex = index;
                        });

                        _notify();
                      },
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: PickerColumn(
                      controller: _inchesController,
                      items: _inches.map((e) => '$e in').toList(),
                      selectedIndex: _selectedInchesIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedInchesIndex = index;
                        });

                        _notify();
                      },
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: PickerColumn(
                      controller: _weightController,
                      items: _weights.map((e) => '$e kg').toList(),
                      selectedIndex: _selectedWeightIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedWeightIndex = index;
                        });

                        _notify();
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
                        height: kPickerItemExtent * 1.5,
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
                        height: kPickerItemExtent * 1.5,
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

        const SizedBox(height: 20),

        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 2),
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                ),
              ],
            ),
            child: Text(
              '${_feet[_selectedFeetIndex]}ft '
              '${_inches[_selectedInchesIndex]}in'
              ' • '
              '${_weights[_selectedWeightIndex]}kg',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ColumnLabel extends StatelessWidget {
  final String label;
  const _ColumnLabel(this.label);

  @override
  Widget build(BuildContext context) =>
      Text(label, textAlign: TextAlign.center, style: AppTypography.bodyMedium);
}
