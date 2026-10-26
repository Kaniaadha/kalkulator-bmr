import 'constants.dart';

// Activity levels and their multipliers.
class ActivityLevel {
  final String name;
  final String description;
  final double multiplier;

  const ActivityLevel({
    required this.name,
    required this.description,
    required this.multiplier,
  });
}

const List<ActivityLevel> activityLevels = [
  ActivityLevel(
    name: 'Sedentary',
    description: 'Little or no exercise',
    multiplier: 1.2,
  ),
  ActivityLevel(
    name: 'Lightly active',
    description: 'Exercise 1–3 times per week',
    multiplier: 1.375,
  ),
  ActivityLevel(
    name: 'Moderately active',
    description: 'Exercise 4–5 times per week',
    multiplier: 1.465,
  ),
  ActivityLevel(
    name: 'Active',
    description: 'Daily exercise or intense exercise 3–4 times per week',
    multiplier: 1.55,
  ),
  ActivityLevel(
    name: 'Very active',
    description: 'Intense exercise 6–7 times per week',
    multiplier: 1.725,
  ),
  ActivityLevel(
    name: 'Extra active',
    description: 'Very intense exercise or a physical job',
    multiplier: 1.9,
  ),
];

// Kelas inti perhitungan BMR (tidak berisi tampilan).
// Dipanggil dari InputPage._calculate() setelah input lolos validasi.
// Rumus yang dipakai berbasis satuan metrik: weight (kg), height (cm), age (tahun).
// Hasil BMR selalu dalam kcal/hari; konversi ke kJ dilakukan di ResultPage.
class BMRCalculator {
  final double weight;
  final double height;
  final int age;
  final Gender gender;
  final BMRFormula formula;
  final double? bodyFatPercentage;

  BMRCalculator({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.formula,
    this.bodyFatPercentage,
  });

  // Calculate BMR using the selected formula.
  // Alur: memilih rumus berdasarkan nilai enum `formula` (lihat constants.dart),
  // lalu memanggil fungsi privat yang sesuai.
  double calculateBMR() {
    switch (formula) {
      case BMRFormula.mifflinStJeor:
        return _calculateMifflinStJeor();

      case BMRFormula.revisedHarrisBenedict:
        return _calculateHarrisBenedict();

      case BMRFormula.katchMcArdle:
        return _calculateKatchMcArdle();
    }
  }

  // Mifflin-St Jeor formula.
  double _calculateMifflinStJeor() {
    // Bagian yang sama untuk pria dan wanita; bedanya hanya konstanta di akhir (+5 / -161).
    final base = (10 * weight) + (6.25 * height) - (5 * age);

    if (gender == Gender.male) {
      return base + 5;
    }

    return base - 161;
  }

  // Revised Harris-Benedict formula.
  double _calculateHarrisBenedict() {
    if (gender == Gender.male) {
      return (13.397 * weight) +
          (4.799 * height) -
          (5.677 * age) +
          88.362;
    }

    return (9.247 * weight) +
        (3.098 * height) -
        (4.330 * age) +
        447.593;
  }

  // Katch-McArdle formula requires body fat percentage.
  double _calculateKatchMcArdle() {
    if (bodyFatPercentage == null) {
      throw ArgumentError(
        'Body fat percentage is required for the Katch-McArdle formula.',
      );
    }

    final fatFraction = bodyFatPercentage! / 100;

    return 370 + (21.6 * (1 - fatFraction) * weight);
  }

  // Calculate estimated daily calorie needs.
  double calculateDailyCalories(double activityMultiplier) {
    return calculateBMR() * activityMultiplier;
  }

  // Convert calories to kilojoules when needed.
  double convertToKilojoules(double calories) {
    return calories * 4.184;
  }

  // Return the selected formula name.
  String getFormulaName() {
    switch (formula) {
      case BMRFormula.mifflinStJeor:
        return 'Mifflin-St Jeor';

      case BMRFormula.revisedHarrisBenedict:
        return 'Revised Harris-Benedict';

      case BMRFormula.katchMcArdle:
        return 'Katch-McArdle';
    }
  }
}