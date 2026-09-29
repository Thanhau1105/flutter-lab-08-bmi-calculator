enum BmiCategory { underweight, normal, overweight, obesity }

class CalculatorBrain {
  const CalculatorBrain({required this.heightCm, required this.weightKg})
    : assert(heightCm > 0 && weightKg > 0);

  final int heightCm;
  final double weightKg;

  double get bmi {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  String get formattedBmi => bmi.toStringAsFixed(1);

  BmiCategory get category {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25) return BmiCategory.normal;
    if (bmi < 30) return BmiCategory.overweight;
    return BmiCategory.obesity;
  }

  String get categoryLabel => switch (category) {
    BmiCategory.underweight => 'UNDERWEIGHT',
    BmiCategory.normal => 'NORMAL',
    BmiCategory.overweight => 'OVERWEIGHT',
    BmiCategory.obesity => 'OBESITY',
  };

  String get interpretation => switch (category) {
    BmiCategory.underweight =>
      'BMI thấp hơn khoảng tham chiếu cho người lớn. Nếu bạn lo lắng về cân nặng, hãy trao đổi với nhân viên y tế.',
    BmiCategory.normal =>
      'BMI nằm trong khoảng tham chiếu cho người lớn. Hãy duy trì ăn uống cân bằng và vận động đều đặn.',
    BmiCategory.overweight =>
      'BMI cao hơn khoảng tham chiếu. Bạn có thể trao đổi với nhân viên y tế về lối sống phù hợp.',
    BmiCategory.obesity =>
      'BMI thuộc nhóm béo phì. Nên trao đổi với nhân viên y tế để được đánh giá sức khỏe toàn diện.',
  };
}
