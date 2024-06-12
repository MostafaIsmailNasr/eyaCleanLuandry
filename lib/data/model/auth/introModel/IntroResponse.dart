class IntroResponse {
  bool? success;
  Null? message;
  List<Intro>? data;

  IntroResponse({this.success, this.message, this.data});

  IntroResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Intro>[];
      json['data'].forEach((v) {
        data!.add(new Intro.fromJson(v));
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

class Intro {
  int? id;
  String? title;
  String? content;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? image;

  Intro(
      {this.id,
        this.title,
        this.content,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.image});

  Intro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}