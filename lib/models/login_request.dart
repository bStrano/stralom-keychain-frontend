class LoginRequest {
  String email;
  String password;
  num platform = 2;

  LoginRequest(this.email, this.password);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['platform'] = platform;
    return data;
  }
}
