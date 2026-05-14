final class ApiConfig {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String baseImageUrl = String.fromEnvironment('BASE_IMAGE_URL');
  static const String accessToken = String.fromEnvironment('ACCESS_TOKEN');

  static Map<String, String> get headers => {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
}
