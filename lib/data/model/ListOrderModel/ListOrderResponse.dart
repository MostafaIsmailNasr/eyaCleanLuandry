class ListOrderResponse {
  bool? success;
  dynamic? message;
  List<OrdersList>? data;

  ListOrderResponse({this.success, this.message, this.data});

  ListOrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrdersList>[];
      json['data'].forEach((v) {
        data!.add(new OrdersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersList {
  int? id;
  int? userId;
  String? userName;
  int? addressId;
  String? addressName;
  int? couponId;
  String? couponCode;
  int? offerId;
  int? branchId;
  String? type;
  dynamic bagNumber;
  dynamic orderCode;
  dynamic total;
  dynamic deliveryCost;
  dynamic totalAmount;
  dynamic typeLang;
  dynamic discount;
  dynamic orderRating;
  dynamic driverRating;
  String? status;
  String? statusLang;
  String? notes;
  String? deliveryDate;
  String? receivedDate;
  String? payment;
  String? createdAt;
  String? updatedAt;
  List<OrderItems>? orderItems;

  OrdersList(
      {this.id,
        this.userId,
        this.userName,
        this.addressId,
        this.addressName,
        this.couponId,
        this.couponCode,
        this.offerId,
        this.branchId,
        this.type,
        this.bagNumber,
        this.orderCode,
        this.total,
        this.deliveryCost,
        this.totalAmount,
        this.typeLang,
        this.discount,
        this.orderRating,
        this.driverRating,
        this.status,
        this.statusLang,
        this.notes,
        this.deliveryDate,
        this.receivedDate,
        this.payment,
        this.createdAt,
        this.updatedAt,
        this.orderItems});

  OrdersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    addressId = json['address_id'];
    addressName = json['address_name'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    offerId = json['offer_id'];
    branchId = json['branch_id'];
    type = json['type'];
    bagNumber = json['bag_number'];
    orderCode = json['order_code'];
    total = json['total'];
    deliveryCost = json['delivery_cost'];
    totalAmount = json['total_amount'];
    typeLang = json['type_lang'];
    discount = json['discount'];
    orderRating = json['order_rating'];
    driverRating = json['driver_rating'];
    status = json['status'];
    statusLang = json['status_lang'];
    notes = json['notes'];
    deliveryDate = json['delivery_date'];
    receivedDate = json['received_date'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['address_id'] = this.addressId;
    data['address_name'] = this.addressName;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['offer_id'] = this.offerId;
    data['branch_id'] = this.branchId;
    data['type'] = this.type;
    data['bag_number'] = this.bagNumber;
    data['order_code'] = this.orderCode;
    data['total'] = this.total;
    data['delivery_cost'] = this.deliveryCost;
    data['total_amount'] = this.totalAmount;
    data['type_lang'] = this.typeLang;
    data['discount'] = this.discount;
    data['order_rating'] = this.orderRating;
    data['driver_rating'] = this.driverRating;
    data['status'] = this.status;
    data['status_lang'] = this.statusLang;
    data['notes'] = this.notes;
    data['delivery_date'] = this.deliveryDate;
    data['received_date'] = this.receivedDate;
    data['payment'] = this.payment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  String? productImage;
  dynamic? price;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  OrderItems(
      {this.id,
        this.orderId,
        this.productId,
        this.productName,
        this.productImage,
        this.price,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    price = json['price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}