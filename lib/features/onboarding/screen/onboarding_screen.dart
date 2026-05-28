import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../cubit/onboarding_cubit.dart';
import 'widgets/activity_widget.dart';
import 'widgets/age_widget.dart';
import 'widgets/calorie_result_widget.dart';
import 'widgets/gender_widget.dart';
import 'widgets/health_goal_widget.dart';
import 'widgets/height_weight_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  int _currentPage = 0;

  static const int _kTotalPages = 6;

  final List<Widget> _pages = const [
    GenderWidget(),
    AgeWidget(),
    HeightWeightWidget(),
    ActivityWidget(),
    HealthGoalWidget(),
    CalorieResultWidget(),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    final cubit = context.read<OnboardingCubit>();

    if (_currentPage == _kTotalPages - 2) {
      await cubit.saveAndCalculate();

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      return;
    }

    if (_currentPage == _kTotalPages - 1) {
      context.go(AppRoutes.home);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentPage == 0
            ? null
            : IconButton(
                onPressed: _previousPage,
                icon: const Icon(Icons.arrow_back),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            LinearProgressIndicator(value: (_currentPage + 1) / _kTotalPages),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AppButton(
            text: _currentPage == _kTotalPages - 1 ? 'Get Started' : 'Continue',
            onTap: _nextPage,
          ),
        ),
      ),
    );
  }
}
