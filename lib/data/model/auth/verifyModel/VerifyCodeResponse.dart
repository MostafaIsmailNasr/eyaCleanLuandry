class VerifyCodeResponse {
  bool? success;
  dynamic? message;
  Data? data;

  VerifyCodeResponse({this.success, this.message, this.data});

  VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? mobile;
  int? code;
  int? status;
  String? token;
  String? name;
  String? email;
  String? role;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  String? androidToken;
  String? iosToken;
  String? referCode;
  int? walletBalance;
  String? confirmedAt;

  Data(
      {this.id,
        this.mobile,
        this.code,
        this.status,
        this.token,
        this.name,
        this.email,
        this.role,
        this.avatar,
        this.createdAt,
        this.updatedAt,
        this.androidToken,
        this.iosToken,
        this.referCode,
        this.walletBalance,
        this.confirmedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    code = json['code'];
    status = json['status'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    androidToken = json['android_token'];
    iosToken = json['ios_token'];
    referCode = json['refer_code'];
    walletBalance = json['wallet_balance'];
    confirmedAt = json['confirmed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['code'] = this.code;
    data['status'] = this.status;
    data['token'] = this.token;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['android_token'] = this.androidToken;
    data['ios_token'] = this.iosToken;
    data['refer_code'] = this.referCode;
    data['wallet_balance'] = this.walletBalance;
    data['confirmed_at'] = this.confirmedAt;
    return data;
  }
}