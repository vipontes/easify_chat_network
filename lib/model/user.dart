class User {
  int userId;
  String userName;
  String userPhone;
  String userPass;
  int userAccessGranted;
  String userCreatedAt;
  String userToken;
  String userRefreshToken;

  User(
      {this.userId,
      this.userName,
      this.userPhone,
      this.userPass,
      this.userAccessGranted,
      this.userCreatedAt,
      this.userToken,
      this.userRefreshToken});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    userPass = json['userPass'];
    userAccessGranted = json['userAccessGranted'];
    userCreatedAt = json['userCreatedAt'];
    userToken = json['userToken'];
    userRefreshToken = json['userRefreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userPhone'] = this.userPhone;
    data['userPass'] = this.userPass;
    data['userAccessGranted'] = this.userAccessGranted;
    data['userCreatedAt'] = this.userCreatedAt;
    data['userToken'] = this.userToken;
    data['userRefreshToken'] = this.userRefreshToken;
    return data;
  }
}
