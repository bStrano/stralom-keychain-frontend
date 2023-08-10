import '../enum/lifetime_enum.dart';

class RegisterShareableSecret {
  final String secret;
  final LifetimeEnum lifetime;
  final num maxViewCount;
  final String? secretPassword;
  final viewCount = 0;
  DateTime expirationDate = DateTime.now();

  RegisterShareableSecret(
      this.secret, this.lifetime, this.maxViewCount, this.secretPassword) {
    switch (lifetime) {
      case LifetimeEnum.oneDay:
        expirationDate = DateTime.now().add(const Duration(days: 1));
        break;
      case LifetimeEnum.twoDays:
        expirationDate = DateTime.now().add(const Duration(days: 2));
        break;
      case LifetimeEnum.threeDays:
        expirationDate = DateTime.now().add(const Duration(days: 3));
        break;
      case LifetimeEnum.oneWeek:
        expirationDate = DateTime.now().add(const Duration(days: 7));
        break;
      case LifetimeEnum.twoWeeks:
        expirationDate = DateTime.now().add(const Duration(days: 14));
        break;
      case LifetimeEnum.oneMonth:
        expirationDate = DateTime.now().add(const Duration(days: 30));
        break;
      case LifetimeEnum.threeMonths:
        expirationDate = DateTime.now().add(const Duration(days: 90));
        break;
      case LifetimeEnum.oneYear:
        expirationDate = DateTime.now().add(const Duration(days: 365));
        break;
    }
  }

  Map<String, dynamic> toJson() => {
        'secret': secret,
        'lifetime': lifetime.index + 1,
        'maxViewCount': maxViewCount,
        'password': secretPassword,
        'expirationDate': expirationDate.toIso8601String(),
      };
}
