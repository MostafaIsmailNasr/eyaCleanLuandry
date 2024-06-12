class ProductCartResponse {
  bool? success;
  Null? message;
  Data? data;

  ProductCartResponse({this.success, this.message, this.data});

  ProductCartResponse.fromJson(Map<String, dynamic> json) {
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
  int? deliveryCost;
  List<Products>? products;

  Data({this.deliveryCost, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryCost = json['delivery_cost'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_cost'] = this.deliveryCost;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? categoryId;
  dynamic? branchId;
  String? name;
  int? regularPrice;
  int? quantity;
  int? urgentPrice;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? image;

  Products(
      {this.id,
        this.categoryId,
        this.branchId,
        this.name,
        this.regularPrice,
        this.quantity,
        this.urgentPrice,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    branchId = json['branch_id'];
    name = json['name'];
    regularPrice = json['regular_price'];
    quantity = json['quantity'];
    urgentPrice = json['urgent_price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['regular_price'] = this.regularPrice;
    data['quantity'] = this.quantity;
    data['urgent_price'] = this.urgentPrice;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}