import 'HTBaseResponseModel.dart';

class LoginResponseModel extends HTBaseResponseModel {
  bool? isAuth;
  List<String>? authorities; // herkes farklı menuler görsün diye
  String? token;
  String? refreshToken;

  LoginResponseModel({this.isAuth, this.authorities, this.token, this.refreshToken});

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    isAuth = json['isAuth'];
    if (json['authorities'] != null) {
      authorities = json['authorities'].cast<String>();
    }
    token = json['token'];
    refreshToken = json['refreshToken'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAuth'] = isAuth;
    data['authorities'] = authorities;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }

  bool get safeIsAuth => isAuth ?? false;
}
