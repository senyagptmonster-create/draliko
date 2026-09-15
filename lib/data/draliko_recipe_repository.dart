import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/bakers_math.dart';

class DralikoRecipeRepository extends ChangeNotifier {
  double _baseFlour = 1000.0;
  double _hydration = 72.0;
  double _salt = 2.0;
  double _starter = 20.0;
  double _yeast = 0.5;

  final List<DoughFormula> _savedFormulas = [
    const DoughFormula(
      name: 'Country Sourdough Boule',
      flourGrams: 1000.0,
      waterPercent: 75.0,
      saltPercent: 2.1,
      yeastPercent: 0.0,
      starterPercent: 20.0,
    ),
    const DoughFormula(
      name: 'Artisan Ciabatta Slab',
      flourGrams: 800.0,
      waterPercent: 82.0,
      saltPercent: 2.2,
      yeastPercent: 1.0,
      starterPercent: 0.0,
    ),
    const DoughFormula(
      name: 'Classic Neapolitan Pizza',
      flourGrams: 1000.0,
      waterPercent: 64.0,
      saltPercent: 2.8,
      yeastPercent: 0.2,
      starterPercent: 0.0,
    ),
    const DoughFormula(
      name: 'Brioche à Tête Rich Loaf',
      flourGrams: 500.0,
      waterPercent: 50.0,
      saltPercent: 2.0,
      yeastPercent: 1.8,
      starterPercent: 0.0,
    ),
  ];

  DralikoRecipeRepository() {
    _loadPrefs();
  }

  double get baseFlour => _baseFlour;
  double get hydration => _hydration;
  double get salt => _salt;
  double get starter => _starter;
  double get yeast => _yeast;
  List<DoughFormula> get savedFormulas => _savedFormulas;

  double get calculatedWaterGrams => (_baseFlour * _hydration) / 100.0;
  double get calculatedSaltGrams => (_baseFlour * _salt) / 100.0;
  double get calculatedStarterGrams => (_baseFlour * _starter) / 100.0;
  double get calculatedYeastGrams => (_baseFlour * _yeast) / 100.0;
  double get calculatedTotalWeight =>
      _baseFlour + calculatedWaterGrams + calculatedSaltGrams + calculatedStarterGrams + calculatedYeastGrams;

  void updateParameters({
    double? flour,
    double? hydration,
    double? salt,
    double? starter,
    double? yeast,
  }) {
    if (flour != null) _baseFlour = flour;
    if (hydration != null) _hydration = hydration;
    if (salt != null) _salt = salt;
    if (starter != null) _starter = starter;
    if (yeast != null) _yeast = yeast;
    _savePrefs();
    notifyListeners();
  }

  void addFormula(String name) {
    _savedFormulas.insert(
      0,
      DoughFormula(
        name: name,
        flourGrams: _baseFlour,
        waterPercent: _hydration,
        saltPercent: _salt,
        yeastPercent: _yeast,
        starterPercent: _starter,
      ),
    );
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _baseFlour = prefs.getDouble('draliko_flour') ?? 1000.0;
    _hydration = prefs.getDouble('draliko_hydration') ?? 72.0;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('draliko_flour', _baseFlour);
    await prefs.setDouble('draliko_hydration', _hydration);
  }
}
