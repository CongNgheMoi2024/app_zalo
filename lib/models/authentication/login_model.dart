class LoginModel {
  // ignore: non_constant_identifier_names
  String? phone_number;
  // ignore: non_constant_identifier_names
  String? access_token;
  // ignore: non_constant_identifier_names
  String? refresh_token;

  // ignore: non_constant_identifier_names
  LoginModel({this.phone_number, this.access_token, this.refresh_token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    phone_number = json['phone_number'];
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
  }

  Map<String, dynamic> toJson() => {
        'phone_number': phone_number,
        'access_token': access_token,
        'refresh_token': refresh_token,
      };
}
