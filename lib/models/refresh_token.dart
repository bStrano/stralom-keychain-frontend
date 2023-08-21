class RefreshToken {
  num id;
  String code;
  num platform;
  DateTime expiryAt;

  RefreshToken(this.id, this.code, this.platform, this.expiryAt);
}
