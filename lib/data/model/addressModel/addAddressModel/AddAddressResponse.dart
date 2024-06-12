class AddAddressResponse {
  bool? success;
  String? message;
  Data? data;

  AddAddressResponse({this.success, this.message, this.data});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
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
  String? streetName;
  String? lat;
  String? lng;
  String? type;
  int? userId;
  int? isDefault;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.streetName,
        this.lat,
        this.lng,
        this.type,
        this.userId,
        this.isDefault,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    streetName = json['street_name'];
    lat = json['lat'];
    lng = json['lng'];
    type = json['type'];
    userId = json['user_id'];
    isDefault = json['is_default'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street_name'] = this.streetName;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['is_default'] = this.isDefault;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}