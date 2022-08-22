class UserModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Success? success;
  Data? data;

  UserModel(
      {this.result,
      this.errorMessage,
      this.errorMessageEn,
      this.success,
      this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['error_message'] = this.errorMessage;
    data['error_message_en'] = this.errorMessageEn;
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Success {
  String? token;

  Success({this.token});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? mobile;

  Data({this.id, this.name, this.email, this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}
