class RefreshToken {
  num id;
  String code;
  num platform;
  DateTime expiryAt;

  RefreshToken(this.id, this.code, this.platform, this.expiryAt);

  RefreshToken.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        platform = json['platform'],
        expiryAt = DateTime.parse(json['expiryAt']);
}
