import 'package:flutter/material.dart';

import '../calculator_brain.dart';
import '../components/bottom_button.dart';
import '../components/icon_content.dart';
import '../components/reuseable_card.dart';
import '../components/round_icon_button.dart';
import '../constants.dart';
import 'results_page.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender _gender = Gender.male;
  int _heightCm = 170;
  int _weightKg = 70;
  int _age = 22;

  void _openResults() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ResultsPage(
          calculator: CalculatorBrain(
            heightCm: _heightCm,
            weightKg: _weightKg.toDouble(),
          ),
          genderLabel: _gender == Gender.male ? 'Nam' : 'Nữ',
          age: _age,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('BMI CALCULATOR'),
      centerTitle: true,
      backgroundColor: AppColors.card,
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ReuseableCard(
                      key: const Key('male-card'),
                      selected: _gender == Gender.male,
                      onTap: () => setState(() => _gender = Gender.male),
                      child: const IconContent(
                        icon: Icons.male_rounded,
                        label: 'NAM',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ReuseableCard(
                      key: const Key('female-card'),
                      selected: _gender == Gender.female,
                      onTap: () => setState(() => _gender = Gender.female),
                      child: const IconContent(
                        icon: Icons.female_rounded,
                        label: 'NỮ',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 3,
              child: ReuseableCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CHIỀU CAO',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$_heightCm',
                          key: const Key('height-value'),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          ' cm',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.accent,
                        inactiveTrackColor: const Color(0xFF4B526C),
                        thumbColor: AppColors.accent,
                        overlayColor: AppColors.accent.withValues(alpha: 0.18),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        key: const Key('height-slider'),
                        min: 120,
                        max: 220,
                        divisions: 100,
                        value: _heightCm.toDouble(),
                        label: '$_heightCm cm',
                        onChanged: (value) =>
                            setState(() => _heightCm = value.round()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: ReuseableCard(
                      child: _NumberControl(
                        label: 'CÂN NẶNG',
                        value: _weightKg,
                        unit: 'kg',
                        decreaseKey: const Key('weight-decrease'),
                        increaseKey: const Key('weight-increase'),
                        valueKey: const Key('weight-value'),
                        onDecrease: () => setState(() {
                          if (_weightKg > 20) _weightKg--;
                        }),
                        onIncrease: () => setState(() {
                          if (_weightKg < 300) _weightKg++;
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ReuseableCard(
                      child: _NumberControl(
                        label: 'TUỔI',
                        value: _age,
                        unit: '',
                        decreaseKey: const Key('age-decrease'),
                        increaseKey: const Key('age-increase'),
                        valueKey: const Key('age-value'),
                        onDecrease: () => setState(() {
                          if (_age > 18) _age--;
                        }),
                        onIncrease: () => setState(() {
                          if (_age < 100) _age++;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            BottomButton(
              key: const Key('calculate-button'),
              label: 'CALCULATE',
              onPressed: _openResults,
            ),
          ],
        ),
      ),
    ),
  );
}

class _NumberControl extends StatelessWidget {
  const _NumberControl({
    required this.label,
    required this.value,
    required this.unit,
    required this.decreaseKey,
    required this.increaseKey,
    required this.valueKey,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String label;
  final int value;
  final String unit;
  final Key decreaseKey;
  final Key increaseKey;
  final Key valueKey;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        '$value$unit',
        key: valueKey,
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundIconButton(
            key: decreaseKey,
            icon: Icons.remove,
            onPressed: onDecrease,
          ),
          const SizedBox(width: 8),
          RoundIconButton(
            key: increaseKey,
            icon: Icons.add,
            onPressed: onIncrease,
          ),
        ],
      ),
    ],
  );
}
