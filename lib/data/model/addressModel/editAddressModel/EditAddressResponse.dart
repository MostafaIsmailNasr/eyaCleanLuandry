class EditAddressResponse {
  bool? success;
  String? message;
  Data? data;

  EditAddressResponse({this.success, this.message, this.data});

  EditAddressResponse.fromJson(Map<String, dynamic> json) {
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
  String? streetName;
  String? lat;
  String? lng;
  String? type;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.streetName,
        this.lat,
        this.lng,
        this.type,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    streetName = json['street_name'];
    lat = json['lat'];
    lng = json['lng'];
    type = json['type'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['street_name'] = this.streetName;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}