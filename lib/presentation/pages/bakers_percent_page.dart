import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/draliko_recipe_repository.dart';
import '../draliko_theme.dart';

class BakersPercentPage extends StatelessWidget {
  const BakersPercentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<DralikoRecipeRepository>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: DralikoTheme.borderCard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text('Base Flour (100% Reference)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Text('${repo.baseFlour.toStringAsFixed(0)} g',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: DralikoTheme.warmCrust, fontSize: 18)),
                  ],
                ),
                Slider(
                  value: repo.baseFlour,
                  min: 200,
                  max: 5000,
                  divisions: 96,
                  activeColor: DralikoTheme.warmCrust,
                  onChanged: (val) => repo.updateParameters(flour: val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _IngredientSlider(
            title: 'Water (Hydration)',
            percent: repo.hydration,
            grams: repo.calculatedWaterGrams,
            min: 50,
            max: 100,
            divisions: 50,
            onChanged: (v) => repo.updateParameters(hydration: v),
          ),
          const SizedBox(height: 12),
          _IngredientSlider(
            title: 'Levain / Sourdough Starter',
            percent: repo.starter,
            grams: repo.calculatedStarterGrams,
            min: 0,
            max: 40,
            divisions: 40,
            onChanged: (v) => repo.updateParameters(starter: v),
          ),
          const SizedBox(height: 12),
          _IngredientSlider(
            title: 'Fine Sea Salt',
            percent: repo.salt,
            grams: repo.calculatedSaltGrams,
            min: 1.0,
            max: 3.5,
            divisions: 25,
            onChanged: (v) => repo.updateParameters(salt: v),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: DralikoTheme.goldenWheat.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: DralikoTheme.goldenWheat),
            ),
            child: Row(
              children: [
                const Icon(Icons.bakery_dining, color: DralikoTheme.warmCrust, size: 36),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Batch Dough Weight',
                          style: TextStyle(fontSize: 12, color: Colors.black54)),
                      Text('${repo.calculatedTotalWeight.toStringAsFixed(1)} g',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: DralikoTheme.warmCrust,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientSlider extends StatelessWidget {
  final String title;
  final double percent;
  final double grams;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  const _IngredientSlider({
    required this.title,
    required this.percent,
    required this.grams,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DralikoTheme.borderCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ),
              Text('${percent.toStringAsFixed(1)}%  (${grams.toStringAsFixed(1)} g)',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: DralikoTheme.darkCharcoal)),
            ],
          ),
          Slider(
            value: percent,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: DralikoTheme.goldenWheat,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
