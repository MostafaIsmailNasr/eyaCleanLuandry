class CreateOrderResponse {
  bool? success;
  String? message;
  Data? data;

  CreateOrderResponse({this.success, this.message, this.data});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? userName;
  int? addressId;
  dynamic? couponId;
  dynamic? offerId;
  dynamic? branchId;
  String? type;
  dynamic? total;
  String? status;
  String? notes;
  String? deliveryDate;
  String? receivedDate;
  String? payment;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.userName,
        this.addressId,
        this.couponId,
        this.offerId,
        this.branchId,
        this.type,
        this.total,
        this.status,
        this.notes,
        this.deliveryDate,
        this.receivedDate,
        this.payment,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    offerId = json['offer_id'];
    branchId = json['branch_id'];
    type = json['type'];
    total = json['total'];
    status = json['status'];
    notes = json['notes'];
    deliveryDate = json['delivery_date'];
    receivedDate = json['received_date'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['address_id'] = this.addressId;
    data['coupon_id'] = this.couponId;
    data['offer_id'] = this.offerId;
    data['branch_id'] = this.branchId;
    data['type'] = this.type;
    data['total'] = this.total;
    data['status'] = this.status;
    data['notes'] = this.notes;
    data['delivery_date'] = this.deliveryDate;
    data['received_date'] = this.receivedDate;
    data['payment'] = this.payment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}