import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'draliko_store.dart';

class BakersCalcScreen extends StatelessWidget {
  const BakersCalcScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Flour: 100%\nWater: 75%', style: AppTheme.display(cAccent)),
    );
  }
}

class BatchScreen extends StatelessWidget {
  const BatchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Multiplier: x3', style: AppTheme.display(cAccent2)),
    );
  }
}

class HydrationScreen extends StatelessWidget {
  const HydrationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Optimal Hydration: 75-80%', style: AppTheme.text(cInk)),
    );
  }
}

class FormulationsScreen extends StatelessWidget {
  const FormulationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<DralikoStore>();
    return ListView.builder(
      itemCount: store.forms.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(store.forms[index]['name'], style: AppTheme.text(cInk)),
          subtitle: Text('${store.forms[index]['hydration']}% Hydration', style: AppTheme.text(cEdge)),
        );
      },
    );
  }
}
