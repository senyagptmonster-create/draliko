import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/draliko_recipe_repository.dart';
import '../draliko_theme.dart';

class RecipeVaultPage extends StatelessWidget {
  const RecipeVaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<DralikoRecipeRepository>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: repo.savedFormulas.length,
      itemBuilder: (context, idx) {
        final f = repo.savedFormulas[idx];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: DralikoTheme.borderCard),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    Text('Hydration: ${f.waterPercent.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12, color: DralikoTheme.warmCrust, fontWeight: FontWeight.w600)),
                    Text('Salt: ${f.saltPercent}%', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('Flour: ${f.flourGrams.toStringAsFixed(0)}g', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('Starter: ${f.starterPercent}%', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
