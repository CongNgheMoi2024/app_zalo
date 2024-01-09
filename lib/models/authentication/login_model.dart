class LoginModel {
  String? phone_number;
  String? access_token;
  String? refresh_token;

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
