class RegisterSecret {
  final String username;
  final String password;
  final String title;
  final String? subtitle;
  final String? encryptionSecret;

  RegisterSecret(this.username, this.password, this.title, this.subtitle,
      this.encryptionSecret);

  Map<String, dynamic> toJson() => {
        'userName': username,
        'password': password,
        'title': title,
        'subtitle': subtitle,
        'encryptionSecret': encryptionSecret,
      };
}
