class FaqsResponse {
  bool? success;
  dynamic? message;
  List<AllFaqs>? data;

  FaqsResponse({this.success, this.message, this.data});

  FaqsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllFaqs>[];
      json['data'].forEach((v) {
        data!.add(new AllFaqs.fromJson(v));
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

class AllFaqs {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Faqs>? faqs;

  AllFaqs({this.id, this.name, this.createdAt, this.updatedAt, this.faqs});

  AllFaqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  int? id;
  int? categoryId;
  String? question;
  String? answer;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Faqs(
      {this.id,
        this.categoryId,
        this.question,
        this.answer,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    question = json['question'];
    answer = json['answer'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}