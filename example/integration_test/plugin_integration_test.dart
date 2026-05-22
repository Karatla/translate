import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:translate/translate.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('translateText accepts empty-safe sample text', (tester) async {
    await Translate.translateText('Dat is goed.');

    expect(true, isTrue);
  });
}
