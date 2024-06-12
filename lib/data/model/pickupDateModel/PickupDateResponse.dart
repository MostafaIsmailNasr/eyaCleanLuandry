class PickupDateResponse {
  bool? success;
  dynamic? message;
  List<PickUpDate>? data;

  PickupDateResponse({this.success, this.message, this.data});

  PickupDateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PickUpDate>[];
      json['data'].forEach((v) {
        data!.add(new PickUpDate.fromJson(v));
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

class PickUpDate {
  String? date;

  PickUpDate({this.date});

  PickUpDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}