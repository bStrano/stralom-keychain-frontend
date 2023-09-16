class SecretDetailed {
  String id;
  String title;
  String? description;
  String userName;
  String password;
  DateTime? lastPasswordChange;
  DateTime createdAt;
  DateTime? updatedAt;

  SecretDetailed(this.id, this.title, this.description, this.userName,
      this.password, this.lastPasswordChange, this.createdAt, this.updatedAt);

  SecretDetailed.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        userName = json['userName'],
        password = json['password'],
        lastPasswordChange = json['lastPasswordChange'] != null
            ? DateTime.parse(json['lastPasswordChange'])
            : null,
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null;
}
