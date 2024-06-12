class SocialResponse {
  bool? success;
  dynamic? message;
  Data? data;

  SocialResponse({this.success, this.message, this.data});

  SocialResponse.fromJson(Map<String, dynamic> json) {
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
  ContactUs? contactUs;
  ContactUs? socialMediaLinks;

  Data({this.contactUs, this.socialMediaLinks});

  Data.fromJson(Map<String, dynamic> json) {
    contactUs = json['contact_us'] != null
        ? new ContactUs.fromJson(json['contact_us'])
        : null;
    socialMediaLinks = json['social_media_links'] != null
        ? new ContactUs.fromJson(json['social_media_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contactUs != null) {
      data['contact_us'] = this.contactUs!.toJson();
    }
    if (this.socialMediaLinks != null) {
      data['social_media_links'] = this.socialMediaLinks!.toJson();
    }
    return data;
  }
}

class ContactUs {
  int? id;
  String? label;
  String? key;
  String? type;
  List<Value>? value;
  String? category;

  ContactUs(
      {this.id, this.label, this.key, this.type, this.value, this.category});

  ContactUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    key = json['key'];
    type = json['type'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['key'] = this.key;
    data['type'] = this.type;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    return data;
  }
}

class Value {
  String? name;
  String? link;

  Value({this.name, this.link});

  Value.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}