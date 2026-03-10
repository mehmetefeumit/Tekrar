import 'package:flutter_test/flutter_test.dart';

import 'package:tekrar/app.dart';
import 'package:tekrar/injection/injection.dart';

void main() {
  setUpAll(configureDependencies);

  testWidgets('App renders home page with title', (tester) async {
    await tester.pumpWidget(const TekrarApp());

    expect(find.text('Tekrar'), findsOneWidget);
    expect(find.text('Welcome to Tekrar'), findsOneWidget);
  });
}
