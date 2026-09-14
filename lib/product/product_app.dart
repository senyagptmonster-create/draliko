import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../app/brand.dart';
import '../app/theme.dart';
import 'draliko_store.dart';
import 'screens.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});
  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  final store = DralikoStore();
  int _idx = 0;
  final _screens = const [BakersCalcScreen(), BatchScreen(), HydrationScreen(), FormulationsScreen()];
  
  @override
  void initState() {
    super.initState();
    _init();
  }
  
  Future<void> _init() async {
    try {
      final content = await rootBundle.loadString('packages/draliko/product/content.json');
      await store.load(content);
    } catch (e) {
      await store.load('{"forms":[]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: cBg,
          appBar: AppBar(title: Text('Draliko Baker', style: AppTheme.display(cSurface)), backgroundColor: cBg),
          body: _screens[_idx],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _idx,
            selectedItemColor: cAccent,
            unselectedItemColor: cEdge,
            onTap: (i) => setState(() => _idx = i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calc'),
              BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Batch'),
              BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Hydration'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Forms'),
            ],
          ),
        ),
      ),
    );
  }
}
