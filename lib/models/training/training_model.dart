class TrainingModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  TrainingModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? type;
  String? parentId;
  String? name;
  String? img;

  Data({this.id, this.type, this.parentId, this.name, this.img});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    parentId = json['parent_id'];
    name = json['name'];
    img = json['img'];
  }
}
