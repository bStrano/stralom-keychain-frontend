class RegisterSecret {
  final String username;
  final String password;
  final String title;
  final String? subtitle;

  RegisterSecret(this.username, this.password, this.title, this.subtitle) {}

  Map<String, dynamic> toJson() => {
        'userName': username,
        'password': password,
        'title': title,
        'subtitle': subtitle,
      };
}
