class DaySettingResponse {
  bool? success;
  dynamic? message;
  Data? data;

  DaySettingResponse({this.success, this.message, this.data});

  DaySettingResponse.fromJson(Map<String, dynamic> json) {
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
  NormalAfterDays? normalAfterDays;
  NormalAfterDays? urgentAfterDays;

  Data({this.normalAfterDays, this.urgentAfterDays});

  Data.fromJson(Map<String, dynamic> json) {
    normalAfterDays = json['normal_after_days'] != null
        ? new NormalAfterDays.fromJson(json['normal_after_days'])
        : null;
    urgentAfterDays = json['urgent_after_days'] != null
        ? new NormalAfterDays.fromJson(json['urgent_after_days'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.normalAfterDays != null) {
      data['normal_after_days'] = this.normalAfterDays!.toJson();
    }
    if (this.urgentAfterDays != null) {
      data['urgent_after_days'] = this.urgentAfterDays!.toJson();
    }
    return data;
  }
}

class NormalAfterDays {
  int? id;
  String? label;
  String? key;
  String? type;
  String? value;
  String? category;

  NormalAfterDays(
      {this.id, this.label, this.key, this.type, this.value, this.category});

  NormalAfterDays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    key = json['key'];
    type = json['type'];
    value = json['value'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['key'] = this.key;
    data['type'] = this.type;
    data['value'] = this.value;
    data['category'] = this.category;
    return data;
  }
}