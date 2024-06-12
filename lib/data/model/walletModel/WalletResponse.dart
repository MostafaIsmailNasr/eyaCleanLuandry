class WalletResponse {
  bool? success;
  dynamic? message;
  Data? data;

  WalletResponse({this.success, this.message, this.data});

  WalletResponse.fromJson(Map<String, dynamic> json) {
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
  List<WalletTransactions>? walletTransactions;

  Data({this.walletBalance, this.walletTransactions});

  Data.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
    if (json['wallet_transactions'] != null) {
      walletTransactions = <WalletTransactions>[];
      json['wallet_transactions'].forEach((v) {
        walletTransactions!.add(new WalletTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_balance'] = this.walletBalance;
    if (this.walletTransactions != null) {
      data['wallet_transactions'] =
          this.walletTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactions {
  int? id;
  int? userId;
  int? increase;
  int? decrease;
  int? currentBalance;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? userName;

  WalletTransactions(
      {this.id,
        this.userId,
        this.increase,
        this.decrease,
        this.currentBalance,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.userName});

  WalletTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    increase = json['increase'];
    decrease = json['decrease'];
    currentBalance = json['current_balance'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['increase'] = this.increase;
    data['decrease'] = this.decrease;
    data['current_balance'] = this.currentBalance;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_name'] = this.userName;
    return data;
  }
}