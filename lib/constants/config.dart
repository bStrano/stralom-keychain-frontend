abstract class Config {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:5292',
  );
  static const String url = String.fromEnvironment(
    'URL',
    defaultValue: 'https://keychain.stralom.com',
  );
}
