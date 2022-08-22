class FoodPlanModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  FoodPlanModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  FoodPlanModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? type;
  String? name;
  String? img;
  String? details;

  Data({this.id, this.type, this.name, this.img, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    img = json['img'];
    details = json['details'];
  }
}
