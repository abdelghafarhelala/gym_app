class RequestModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  RequestModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  RequestModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? userId;
  String? trainPacId;
  String? type;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
      this.trainPacId,
      this.type,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    trainPacId = json['train_pac_id'];
    type = json['type'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
