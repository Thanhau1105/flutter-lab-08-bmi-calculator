import 'package:flutter/material.dart';

import '../calculator_brain.dart';
import '../components/bottom_button.dart';
import '../components/reuseable_card.dart';
import '../constants.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    super.key,
    required this.calculator,
    required this.genderLabel,
    required this.age,
  });

  final CalculatorBrain calculator;
  final String genderLabel;
  final int age;

  Color get _resultColor => switch (calculator.category) {
    BmiCategory.normal => AppColors.green,
    BmiCategory.underweight => AppColors.amber,
    BmiCategory.overweight => AppColors.amber,
    BmiCategory.obesity => AppColors.accent,
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('KẾT QUẢ BMI'),
      centerTitle: true,
      backgroundColor: AppColors.card,
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'KẾT QUẢ CỦA BẠN',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ReuseableCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        calculator.categoryLabel,
                        key: const Key('bmi-category'),
                        style: TextStyle(
                          color: _resultColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            calculator.formattedBmi,
                            key: const Key('bmi-value'),
                            style: const TextStyle(
                              fontSize: 78,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            'kg/m²',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                      Text(
                        calculator.interpretation,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 17, height: 1.45),
                      ),
                      Column(
                        children: [
                          const Divider(color: Color(0xFF4B526C)),
                          const SizedBox(height: 8),
                          Text(
                            '$genderLabel · $age tuổi · '
                            '${calculator.heightCm} cm · '
                            '${calculator.weightKg.toStringAsFixed(0)} kg',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'BMI chỉ là chỉ số sàng lọc cho người lớn, '
                            'không thay thế chẩn đoán y khoa.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            BottomButton(
              key: const Key('recalculate-button'),
              label: 'RE-CALCULATE',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    ),
  );
}
