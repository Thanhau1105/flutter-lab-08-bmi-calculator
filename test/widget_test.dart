import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_08/calculator_brain.dart';
import 'package:lab_08/main.dart';

void main() {
  test('CalculatorBrain uses adult BMI boundaries', () {
    expect(
      const CalculatorBrain(heightCm: 170, weightKg: 70).formattedBmi,
      '24.2',
    );
    expect(
      const CalculatorBrain(heightCm: 200, weightKg: 73.96).category,
      BmiCategory.underweight,
    );
    expect(
      const CalculatorBrain(heightCm: 200, weightKg: 74).category,
      BmiCategory.normal,
    );
    expect(
      const CalculatorBrain(heightCm: 200, weightKg: 100).category,
      BmiCategory.overweight,
    );
    expect(
      const CalculatorBrain(heightCm: 200, weightKg: 120).category,
      BmiCategory.obesity,
    );
  });

  testWidgets('inputs calculate BMI and return with values preserved', (
    tester,
  ) async {
    await tester.pumpWidget(const BmiCalculatorApp());
    expect(find.text('170'), findsOneWidget);
    expect(find.text('70kg'), findsOneWidget);
    expect(find.text('22'), findsOneWidget);

    await tester.tap(find.byKey(const Key('female-card')));
    await tester.pump();
    final slider = tester.widget<Slider>(
      find.byKey(const Key('height-slider')),
    );
    slider.onChanged!(180);
    await tester.pump();
    await tester.tap(find.byKey(const Key('weight-increase')));
    await tester.tap(find.byKey(const Key('age-increase')));
    await tester.pump();

    expect(find.text('180'), findsOneWidget);
    expect(find.text('71kg'), findsOneWidget);
    expect(find.text('23'), findsOneWidget);

    await tester.tap(find.byKey(const Key('calculate-button')));
    await tester.pumpAndSettle();
    expect(find.text('21.9'), findsOneWidget);
    expect(find.text('NORMAL'), findsOneWidget);
    expect(
      find.textContaining('Nữ · 23 tuổi · 180 cm · 71 kg'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('recalculate-button')));
    await tester.pumpAndSettle();
    expect(find.text('180'), findsOneWidget);
    expect(find.text('71kg'), findsOneWidget);
  });
}
