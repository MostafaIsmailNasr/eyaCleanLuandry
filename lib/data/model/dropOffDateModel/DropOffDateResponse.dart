class DropOffDateResponse {
  bool? success;
  dynamic? message;
  List<DropOffDates>? data;

  DropOffDateResponse({this.success, this.message, this.data});

  DropOffDateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DropOffDates>[];
      json['data'].forEach((v) {
        data!.add(new DropOffDates.fromJson(v));
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

class DropOffDates {
  String? date;

  DropOffDates({this.date});

  DropOffDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}