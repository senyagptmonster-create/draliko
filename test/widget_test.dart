import 'package:flutter_test/flutter_test.dart';
import 'package:draliko/presentation/draliko_app.dart';

void main() {
  testWidgets('DralikoApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DralikoApp());
    await tester.pump();
    expect(find.text("Baker's % Scale"), findsWidgets);
  });
}
