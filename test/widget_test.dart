import 'package:flutter_test/flutter_test.dart';
import 'package:draliko/draliko_app.dart';

void main() {
  testWidgets('DralikoApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DralikoApp());
    expect(find.text('DRALIKO BAKERY %'), findsOneWidget);
    expect(find.text("Baker's % Scaler"), findsOneWidget);
  });
}
