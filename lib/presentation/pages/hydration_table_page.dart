import 'package:flutter/material.dart';
import '../draliko_theme.dart';

class HydrationTablePage extends StatelessWidget {
  const HydrationTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = [
      {'style': 'Bagel & Pretzel Dough', 'range': '50% - 55%', 'desc': 'Extremely stiff, chewy texture, minimal crumb openness.'},
      {'style': 'Standard Sandwich Bread', 'range': '60% - 65%', 'desc': 'Easy to shape, uniform crumb structure, soft pillowy slice.'},
      {'style': 'Neapolitan Pizza Base', 'range': '62% - 68%', 'desc': 'Extensible, high heat blistering, crispy leopard crust.'},
      {'style': 'Artisan Country Sourdough', 'range': '72% - 80%', 'desc': 'Custardy open crumb, blistered crispy ear, requires coil folds.'},
      {'style': 'Ciabatta & Pan de Cristal', 'range': '82% - 100%', 'desc': 'Liquid batter-like dough, honeycomb translucent crumb holes.'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: styles.length,
      itemBuilder: (context, idx) {
        final s = styles[idx];
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
                Row(
                  children: [
                    Expanded(
                      child: Text(s['style']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: DralikoTheme.goldenWheat.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(s['range']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: DralikoTheme.warmCrust)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(s['desc']!, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
              ],
            ),
          ),
        );
      },
    );
  }
}
