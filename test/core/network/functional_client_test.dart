import 'package:filmeno/core/network/functional_client.dart';
import 'package:filmeno/shared/exceptions/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

final class _MockHttpClient extends Mock implements http.Client {}

void main() {
  late _MockHttpClient mockHttp;
  late FunctionalClient client;

  setUp(() {
    mockHttp = _MockHttpClient();
    client = FunctionalClient(mockHttp);
    registerFallbackValue(Uri());
  });

  test('Deve retornar Right quando a chamada HTTP for 200', () async {
    // Arrange
    when(() => mockHttp.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('{"id": 1}', 200));

    // Act
    final result = await client.get('/test').run();

    // Assert
    expect(result.isRight(), true);
    result.match((_) => null, (data) => expect(data['id'], 1));
  });

  test('Deve retornar Left(FalhaServidor) quando a chamada HTTP for 500', () async {
    // Arrange
    when(() => mockHttp.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Erro', 500));

    // Act
    final result = await client.get('/test').run();

    // Assert
    expect(result.isLeft(), true);
    result.match(
      (falha) => expect(falha, isA<FalhaServidor>()),
      (_) => fail('Deveria ser um erro'),
    );
  });
}
