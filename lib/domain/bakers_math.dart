class Ingredient {
  final String name;
  final double percentage; // Relative to flour (100%)

  const Ingredient({required this.name, required this.percentage});

  double calculateGrams(double flourGrams) {
    return (flourGrams * percentage) / 100.0;
  }
}

class DoughFormula {
  final String name;
  final double flourGrams;
  final double waterPercent;
  final double saltPercent;
  final double yeastPercent;
  final double starterPercent;

  const DoughFormula({
    required this.name,
    required this.flourGrams,
    required this.waterPercent,
    required this.saltPercent,
    required this.yeastPercent,
    required this.starterPercent,
  });

  double get waterGrams => (flourGrams * waterPercent) / 100.0;
  double get saltGrams => (flourGrams * saltPercent) / 100.0;
  double get yeastGrams => (flourGrams * yeastPercent) / 100.0;
  double get starterGrams => (flourGrams * starterPercent) / 100.0;

  double get totalWeightGrams =>
      flourGrams + waterGrams + saltGrams + yeastGrams + starterGrams;
}
