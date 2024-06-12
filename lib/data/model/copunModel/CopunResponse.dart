class copunResponse {
  bool? success;
  dynamic? message;
  Data? data;

  copunResponse({this.success, this.message, this.data});

  copunResponse.fromJson(Map<String, dynamic> json) {
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
  Null? branchId;
  String? name;
  String? code;
  String? type;
  int? isActive;
  String? startDate;
  String? endDate;
  int? value;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? usesPerUser;
  Null? branch;

  Data(
      {this.id,
        this.branchId,
        this.name,
        this.code,
        this.type,
        this.isActive,
        this.startDate,
        this.endDate,
        this.value,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.usesPerUser,
        this.branch});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    usesPerUser = json['uses_per_user'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    data['is_active'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['uses_per_user'] = this.usesPerUser;
    data['branch'] = this.branch;
    return data;
  }
}