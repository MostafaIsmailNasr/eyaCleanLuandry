class PriceResponse {
  bool? success;
  dynamic? message;
  List<Data>? data;

  PriceResponse({this.success, this.message, this.data});

  PriceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  dynamic? parentId;
  String? name;
  int? isActive;
  int? branchId;
  String? createdAt;
  String? updatedAt;
  List<SubCategories>? subCategories;

  Data(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.branchId,
        this.createdAt,
        this.updatedAt,
        this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    branchId = json['branch_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['branch_id'] = this.branchId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  int? parentId;
  String? name;
  int? isActive;
  int? branchId;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;

  SubCategories(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.branchId,
        this.createdAt,
        this.updatedAt,
        this.products});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    branchId = json['branch_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['branch_id'] = this.branchId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? categoryId;
  int? branchId;
  String? name;
  int? regularPrice;
  int? urgentPrice;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.id,
        this.categoryId,
        this.branchId,
        this.name,
        this.regularPrice,
        this.urgentPrice,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    branchId = json['branch_id'];
    name = json['name'];
    regularPrice = json['regular_price'];
    urgentPrice = json['urgent_price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['regular_price'] = this.regularPrice;
    data['urgent_price'] = this.urgentPrice;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}