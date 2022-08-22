class TrainingOffersModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  TrainingOffersModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  TrainingOffersModel.fromJson(Map<String, dynamic> json) {
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
  List<Offers>? offers;

  Data({this.id, this.type, this.parentId, this.name, this.img, this.offers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    parentId = json['parent_id'];
    name = json['name'];
    img = json['img'];
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }
}

class Offers {
  int? id;
  String? parentId;
  int? sessionNum;
  int? price;

  Offers({this.id, this.parentId, this.sessionNum, this.price});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    sessionNum = json['session_num'];
    price = json['price'];
  }
}
