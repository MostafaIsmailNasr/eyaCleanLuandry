class HoursResponse {
  bool? success;
  dynamic? message;
  List<Hours>? data;

  HoursResponse({this.success, this.message, this.data});

  HoursResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Hours>[];
      json['data'].forEach((v) {
        data!.add(new Hours.fromJson(v));
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

class Hours {
  String? time;
  bool? isAvailable;

  Hours({this.time, this.isAvailable});

  Hours.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['is_available'] = this.isAvailable;
    return data;
  }
}