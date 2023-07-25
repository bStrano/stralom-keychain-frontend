import '../enum/lifetime_enum.dart';

class RegisterShareableSecret {
  final String secret;
  final LifetimeEnum lifetime;
  final num maxViewCount;
  final String? secretPassword;

  RegisterShareableSecret(
      this.secret, this.lifetime, this.maxViewCount, this.secretPassword);

  RegisterShareableSecret.fromJson(Map<String, dynamic> json)
      : secret = json['name'],
        lifetime = json['email'],
        maxViewCount = json['maxViewCount'],
        secretPassword = json['secretPassword'];

  Map<String, dynamic> toJson() => {
        'secret': secret,
        'lifetime': lifetime,
        'maxViewCount': maxViewCount,
        'secretPassword': secretPassword,
      };
}
