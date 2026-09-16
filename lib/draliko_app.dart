import 'package:flutter/material.dart';
import 'theme/draliko_theme.dart';
import 'painters/bakers_hydration_painter.dart';

class DralikoApp extends StatelessWidget {
  const DralikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draliko Bakery Calculator',
      debugShowCheckedModeBanner: false,
      theme: DralikoTheme.themeData,
      home: const DralikoShell(),
    );
  }
}

class DralikoShell extends StatefulWidget {
  const DralikoShell({super.key});

  @override
  State<DralikoShell> createState() => _DralikoShellState();
}

class _DralikoShellState extends State<DralikoShell> {
  double _flourG = 1000.0;
  double _hydrationPct = 70.0;
  final double _saltPct = 2.0;
  final double _yeastPct = 1.2;
  final double _starterPct = 20.0;
  int _loafCount = 2;

  final List<Map<String, dynamic>> _flours = [
    {
      'name': 'Bread Flour (T65)',
      'protein': '12.8%',
      'absorption': '68 - 75%',
      'notes': 'High gluten strength, ideal for open-crumb artisanal boules.',
    },
    {
      'name': 'Whole Wheat (T150)',
      'protein': '14.0%',
      'absorption': '75 - 85%',
      'notes': 'High bran content, absorbs significant water quickly.',
    },
    {
      'name': 'Rye Flour (Type 997)',
      'protein': '9.5%',
      'absorption': '70 - 80%',
      'notes': 'Low gluten tenacity, high enzymatic activity.',
    },
    {
      'name': 'All-Purpose / T55',
      'protein': '10.5%',
      'absorption': '60 - 65%',
      'notes': 'Balanced elasticity, great for sandwich pan loaves.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'DRALIKO BAKERY %',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: DralikoTheme.ink,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: DralikoTheme.accent,
            unselectedLabelColor: DralikoTheme.muted,
            indicatorColor: DralikoTheme.accent,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: [
              Tab(text: "Baker's % Scaler"),
              Tab(text: "Batch Yield"),
              Tab(text: "Hydration Matrix"),
              Tab(text: "Flour Guide"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildScalerTab(),
            _buildBatchYieldTab(),
            _buildHydrationMatrixTab(),
            _buildFlourGuideTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildScalerTab() {
    final waterG = _flourG * (_hydrationPct / 100);
    final saltG = _flourG * (_saltPct / 100);
    final yeastG = _flourG * (_yeastPct / 100);
    final starterG = _flourG * (_starterPct / 100);
    final totalDoughG = _flourG + waterG + saltG + yeastG + starterG;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Visual Hydration Painter Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hydration Dynamics',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: DralikoTheme.ink),
                      ),
                      Text(
                        '${_hydrationPct.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: DralikoTheme.accent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: CustomPaint(
                      painter: BakersHydrationPainter(
                        hydrationPct: _hydrationPct,
                        totalFlourG: _flourG,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Batch: ${totalDoughG.toStringAsFixed(0)} g',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: DralikoTheme.ink,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Water: ${waterG.toStringAsFixed(0)} g | Flour: ${_flourG.toStringAsFixed(0)} g',
                              style: const TextStyle(
                                fontSize: 12,
                                color: DralikoTheme.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Flour base slider
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Base Flour (100%)', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${_flourG.toStringAsFixed(0)} g', style: const TextStyle(fontWeight: FontWeight.bold, color: DralikoTheme.accent)),
                    ],
                  ),
                  Slider(
                    value: _flourG,
                    min: 200,
                    max: 5000,
                    divisions: 48,
                    activeColor: DralikoTheme.accent,
                    inactiveColor: DralikoTheme.edge,
                    onChanged: (v) => setState(() => _flourG = v),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Hydration %', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${_hydrationPct.toStringAsFixed(1)} %', style: const TextStyle(fontWeight: FontWeight.bold, color: DralikoTheme.accent)),
                    ],
                  ),
                  Slider(
                    value: _hydrationPct,
                    min: 50,
                    max: 95,
                    divisions: 90,
                    activeColor: DralikoTheme.accent,
                    inactiveColor: DralikoTheme.edge,
                    onChanged: (v) => setState(() => _hydrationPct = v),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Formula breakdown
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Formula Scaler Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Divider(height: 20, color: DralikoTheme.edge),
                  _buildIngredientRow('Flour (Base)', '100.0%', '${_flourG.toStringAsFixed(0)} g'),
                  _buildIngredientRow('Water', '${_hydrationPct.toStringAsFixed(1)}%', '${waterG.toStringAsFixed(1)} g'),
                  _buildIngredientRow('Levain / Starter', '${_starterPct.toStringAsFixed(1)}%', '${starterG.toStringAsFixed(1)} g'),
                  _buildIngredientRow('Fine Sea Salt', '${_saltPct.toStringAsFixed(1)}%', '${saltG.toStringAsFixed(1)} g'),
                  _buildIngredientRow('Instant Yeast', '${_yeastPct.toStringAsFixed(1)}%', '${yeastG.toStringAsFixed(1)} g'),
                  const Divider(height: 20, color: DralikoTheme.edge),
                  _buildIngredientRow('Total Dough Mass', '', '${totalDoughG.toStringAsFixed(0)} g', isBold: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientRow(String name, String pct, String weight, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold ? DralikoTheme.accent : DralikoTheme.ink,
              ),
            ),
          ),
          if (pct.isNotEmpty)
            Expanded(
              child: Text(
                pct,
                style: const TextStyle(color: DralikoTheme.muted, fontSize: 13),
              ),
            ),
          Text(
            weight,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isBold ? DralikoTheme.accent : DralikoTheme.ink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchYieldTab() {
    final waterG = _flourG * (_hydrationPct / 100);
    final saltG = _flourG * (_saltPct / 100);
    final starterG = _flourG * (_starterPct / 100);
    final totalDoughG = _flourG + waterG + saltG + starterG;
    final loafWeight = totalDoughG / _loafCount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dough Portioning & Loaf Units', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of Loaves:'),
                      Text('$_loafCount loaves', style: const TextStyle(fontWeight: FontWeight.bold, color: DralikoTheme.accent)),
                    ],
                  ),
                  Slider(
                    value: _loafCount.toDouble(),
                    min: 1,
                    max: 12,
                    divisions: 11,
                    activeColor: DralikoTheme.accent,
                    inactiveColor: DralikoTheme.edge,
                    onChanged: (v) => setState(() => _loafCount = v.round()),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricColumn('Raw Loaf Weight', '${loafWeight.toStringAsFixed(0)} g'),
                      _buildMetricColumn('Baked Estimate (-15%)', '${(loafWeight * 0.85).toStringAsFixed(0)} g'),
                    ],
                  ),
                  const Divider(height: 24, color: DralikoTheme.edge),
                  Text(
                    loafWeight < 400
                        ? 'Suitable for: Demi-baguettes & sandwich buns'
                        : loafWeight < 750
                            ? 'Suitable for: Standard batards & sandwich tins'
                            : 'Suitable for: Large country boules & miche',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, color: DralikoTheme.muted, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: DralikoTheme.accent)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: DralikoTheme.muted)),
      ],
    );
  }

  Widget _buildHydrationMatrixTab() {
    final matrix = [
      {'pct': '60%', 'style': 'Ciabatta / Pizza Napoletana', 'handling': 'Firm, low stickiness, easy to shape'},
      {'pct': '68%', 'style': 'Standard Sourdough Batard', 'handling': 'Moderate tension, holds scoring well'},
      {'pct': '75%', 'style': 'Artisanal Open Crumb Sourdough', 'handling': 'Tacky, requires coil folds & gluten development'},
      {'pct': '82%', 'style': 'Pan de Cristal / High Hydration', 'handling': 'Liquid-like, pan-bake or heavy coil folding'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: matrix.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final item = matrix[i];
        final isCurrent = (_hydrationPct - double.parse(item['pct']!.replaceAll('%', ''))).abs() < 5;
        return Card(
          color: isCurrent ? DralikoTheme.edge.withValues(alpha: 0.3) : DralikoTheme.surface,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: DralikoTheme.accent,
              foregroundColor: Colors.white,
              child: Text(item['pct']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            title: Text(item['style']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['handling']!, style: const TextStyle(fontSize: 12, color: DralikoTheme.muted)),
          ),
        );
      },
    );
  }

  Widget _buildFlourGuideTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _flours.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final f = _flours[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(f['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: DralikoTheme.edge,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Protein: ${f['protein']}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: DralikoTheme.ink),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Absorption Range: ${f['absorption']}', style: const TextStyle(fontSize: 13, color: DralikoTheme.accent, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(f['notes'] as String, style: const TextStyle(fontSize: 12, color: DralikoTheme.muted)),
              ],
            ),
          ),
        );
      },
    );
  }
}
