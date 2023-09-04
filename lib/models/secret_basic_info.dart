class SecretBasicInfo {
  String id;
  String title;
  String? description;
  String userName;
  DateTime? lastPasswordChange;
  DateTime createdAt;
  DateTime? updatedAt;

  SecretBasicInfo(this.id, this.title, this.description, this.userName,
      this.lastPasswordChange, this.createdAt, this.updatedAt);

  SecretBasicInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        userName = json['userName'],
        lastPasswordChange = json['lastPasswordChange'] != null
            ? DateTime.parse(json['lastPasswordChange'])
            : null,
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null;
}
