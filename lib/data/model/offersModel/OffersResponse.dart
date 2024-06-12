class OffersResponse {
  bool? success;
  dynamic? message;
  List<AllOffers>? data;

  OffersResponse({this.success, this.message, this.data});

  OffersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllOffers>[];
      json['data'].forEach((v) {
        data!.add(new AllOffers.fromJson(v));
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

class AllOffers {
  int? id;
  int? branchId;
  int? price;
  int? discount;
  String? name;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? image;

  AllOffers(
      {this.id,
        this.branchId,
        this.price,
        this.discount,
        this.name,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.image});

  AllOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    price = json['price'];
    discount = json['discount'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}