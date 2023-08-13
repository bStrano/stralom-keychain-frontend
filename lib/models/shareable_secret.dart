class ShareableSecret {
  String id;
  String secret;
  DateTime expirationDate;
  int maxViewCount;
  String? password;
  int viewCount = 0;

  ShareableSecret(this.id, this.secret, this.expirationDate, this.maxViewCount,
      this.password, this.viewCount);

  ShareableSecret.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        expirationDate = DateTime.parse(json['expirationDate']),
        maxViewCount = json['maxViewCount'],
        secret = json['secret'],
        viewCount = 0;
}
