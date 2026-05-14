import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'functional_client.dart';

part 'network_providers.g.dart';

@riverpod
http.Client httpClient(Ref ref) {
  final client = http.Client();
  // O Riverpod garante que o cliente será fechado quando não for mais usado
  ref.onDispose(client.close);
  return client;
}

@riverpod
FunctionalClient functionalClient(Ref ref) {
  final httpClient = ref.watch(httpClientProvider);
  return FunctionalClient(httpClient);
}
