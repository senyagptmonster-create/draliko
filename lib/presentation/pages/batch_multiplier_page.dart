import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/draliko_recipe_repository.dart';
import '../draliko_theme.dart';

class BatchMultiplierPage extends StatefulWidget {
  const BatchMultiplierPage({super.key});

  @override
  State<BatchMultiplierPage> createState() => _BatchMultiplierPageState();
}

class _BatchMultiplierPageState extends State<BatchMultiplierPage> {
  int _loavesCount = 4;
  double _targetLoafWeight = 750; // grams per loaf

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<DralikoRecipeRepository>();
    final totalTargetDough = _loavesCount * _targetLoafWeight;
    final totalPercent = 100.0 + repo.hydration + repo.starter + repo.salt + repo.yeast;
    final neededFlour = (totalTargetDough / totalPercent) * 100.0;
    final neededWater = (neededFlour * repo.hydration) / 100.0;
    final neededStarter = (neededFlour * repo.starter) / 100.0;
    final neededSalt = (neededFlour * repo.salt) / 100.0;

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
                const Text('Commercial Batch Production Target',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(child: Text('Number of Units / Loaves')),
                    IconButton(
                      onPressed: _loavesCount > 1 ? () => setState(() => _loavesCount--) : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$_loavesCount', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      onPressed: _loavesCount < 100 ? () => setState(() => _loavesCount++) : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Target Loaf Mass (g)')),
                    DropdownButton<double>(
                      value: _targetLoafWeight,
                      items: const [
                        DropdownMenuItem(value: 500, child: Text('500 g (Baguette/Batard)')),
                        DropdownMenuItem(value: 750, child: Text('750 g (Standard Boule)')),
                        DropdownMenuItem(value: 900, child: Text('900 g (Large Miche)')),
                        DropdownMenuItem(value: 1200, child: Text('1200 g (Family Pan Loaf)')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _targetLoafWeight = val);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Batch Scale Sheet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _BatchRow(label: 'Total Required Flour', value: '${neededFlour.toStringAsFixed(0)} g', icon: Icons.grass),
          _BatchRow(label: 'Total Required Water', value: '${neededWater.toStringAsFixed(0)} g', icon: Icons.water_drop),
          _BatchRow(label: 'Total Required Starter', value: '${neededStarter.toStringAsFixed(0)} g', icon: Icons.bubble_chart),
          _BatchRow(label: 'Total Required Salt', value: '${neededSalt.toStringAsFixed(1)} g', icon: Icons.grain),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: DralikoTheme.warmCrust,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Total Mixed Mass', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Text('${totalTargetDough.toStringAsFixed(0)} g',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BatchRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _BatchRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: DralikoTheme.borderCard),
      ),
      child: ListTile(
        leading: Icon(icon, color: DralikoTheme.warmCrust),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
