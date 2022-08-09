

import '../helpers/db_helper.dart';

class Password {
  int? id;
  late String title;
  late String url;
  late String userName;
  late String password;

  Password({
    this.id,
    required this.title,
    required this.url,
    required this.userName,
    required this.password,
  });
  Password.fromJson(Map<String, dynamic> json) {
    id = json[DbHelper.passwordsIdColumnName];
    title = json[DbHelper.passwordsTitlColumnName];
    url = json[DbHelper.passwordsUrlColumnName];
    userName = json[DbHelper.passwordsUsernameColumnName];
    password = json[DbHelper.passwordColumnName];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data[DbHelper.passwordsUsernameColumnName] = userName;
    data['password'] = password;
    return data;
  }
}
