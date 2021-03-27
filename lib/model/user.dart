class User {
  int userId;
  String userName;
  String userPhone;
  String userPass;
  int userAccessGranted;
  String userCreatedAt;
  String userImage;
  String userToken;
  String userRefreshToken;

  User({this.userId,
    this.userName,
    this.userPhone,
    this.userPass,
    this.userAccessGranted,
    this.userCreatedAt,
    this.userImage,
    this.userToken,
    this.userRefreshToken});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    userPass = json['userPass'];
    userAccessGranted = json['userAccessGranted'];
    userCreatedAt = json['userCreatedAt'];
    userImage = json['userImage'];
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
    data['userImage'] = this.userImage;
    data['userToken'] = this.userToken;
    data['userRefreshToken'] = this.userRefreshToken;
    return data;
  }

  static Map<int, dynamic> jsonFromList(List<User> list) {
    Map<int, dynamic> data = Map<int, dynamic>();

    int i = 0;
    for (final item in list) {
      data[i] = item.toJson();
      i++;
    }

    return data;
  }

  static List<User> listFromJson(List<dynamic> json) {
    List<User> data = List();

    for (final item in json) {
      User element = User(
          userId: item["userId"],
          userName: item["userName"],
          userPhone: item["userPhone"],
          userPass: item["userPass"],
          userAccessGranted: item["userAccessGranted"],
          userCreatedAt: item["userCreatedAt"],
          userImage: item["userImage"],
          userToken: item["userToken"],
          userRefreshToken: item["userRefreshToken"]);

      data.add(element);
    }

    return data;
  }
}