import 'package:filmeno/app/shared/store/store.dart';
import 'package:flutter_test/flutter_test.dart';

final class StoreTest extends Store<String> {
  StoreTest() : super('initial');
}

void main() {
  test('store - diponse', () {
    final store = StoreTest();
    expect(store.isDisposed, isFalse);
    store.dispose();
    expect(store.isDisposed, isTrue);
  });
}
