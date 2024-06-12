class HomeResponse {
  bool? success;
  dynamic? message;
  Data? data;

  HomeResponse({this.success, this.message, this.data});

  HomeResponse.fromJson(Map<String, dynamic> json) {
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
  int? ordersCount;
  List<Sliders>? sliders;
  List<Offers>? offers;

  Data({this.ordersCount, this.sliders, this.offers});

  Data.fromJson(Map<String, dynamic> json) {
    ordersCount = json['orders_count'];
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Sliders.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_count'] = this.ordersCount;
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  int? id;
  int? branchId;
  String? name;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? image;

  Sliders(
      {this.id,
        this.branchId,
        this.name,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}

class Offers {
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

  Offers(
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

  Offers.fromJson(Map<String, dynamic> json) {
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