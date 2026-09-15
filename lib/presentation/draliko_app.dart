import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/draliko_recipe_repository.dart';
import 'draliko_theme.dart';
import 'pages/bakers_percent_page.dart';
import 'pages/batch_multiplier_page.dart';
import 'pages/hydration_table_page.dart';
import 'pages/recipe_vault_page.dart';

class DralikoApp extends StatelessWidget {
  const DralikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DralikoRecipeRepository(),
      child: MaterialApp(
        title: 'Draliko Baker Formula',
        theme: DralikoTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const DralikoHomeScaffold(),
      ),
    );
  }
}

class DralikoHomeScaffold extends StatefulWidget {
  const DralikoHomeScaffold({super.key});

  @override
  State<DralikoHomeScaffold> createState() => _DralikoHomeScaffoldState();
}

class _DralikoHomeScaffoldState extends State<DralikoHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ["Baker's % Scale", 'Batch Multiplier', 'Hydration Table', 'Recipe Vault'];
  final _pages = const [
    BakersPercentPage(),
    BatchMultiplierPage(),
    HydrationTablePage(),
    RecipeVaultPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.calculate_outlined), selectedIcon: Icon(Icons.calculate), label: "Baker's %"),
          NavigationDestination(icon: Icon(Icons.layers_outlined), selectedIcon: Icon(Icons.layers), label: 'Batch'),
          NavigationDestination(icon: Icon(Icons.water_outlined), selectedIcon: Icon(Icons.water), label: 'Hydration'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Vault'),
        ],
      ),
    );
  }
}
