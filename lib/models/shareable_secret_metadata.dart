class ShareableSecretMetadata {
  String id;
  DateTime expirationDate;
  int maxViewCount;
  int remainingViews;
  bool? hasPassword;

  ShareableSecretMetadata(this.id, this.expirationDate, this.maxViewCount,
      this.remainingViews, this.hasPassword);

  ShareableSecretMetadata.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        expirationDate = DateTime.parse(json['expirationDate']),
        maxViewCount = json['maxViewCount'],
        remainingViews = json['remainingViews'],
        hasPassword = json['hasPassword'];
}
