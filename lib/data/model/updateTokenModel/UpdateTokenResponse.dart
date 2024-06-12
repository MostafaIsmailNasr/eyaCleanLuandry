class UpdateTokenResponse {
  bool? success;
  String? message;
  List<Null>? data;

  UpdateTokenResponse({this.success, this.message, this.data});

  UpdateTokenResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    // if (json['data'] != null) {
    //   data = <Null>[];
    //   json['data'].forEach((v) {
    //     data!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}