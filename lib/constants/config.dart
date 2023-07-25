abstract class Config {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'localhost:5000',
  );
}
