class WalletCodeResponse {
  bool? success;
  dynamic? message;
  Data? data;

  WalletCodeResponse({this.success, this.message, this.data});

  WalletCodeResponse.fromJson(Map<String, dynamic> json) {
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
  int? walletBalance;
  String? referralDescription;

  Data({this.walletBalance,this.referralDescription});

  Data.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
    referralDescription = json['referral_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_balance'] = this.walletBalance;
    data['referral_description'] = this.referralDescription;
    return data;
  }
}