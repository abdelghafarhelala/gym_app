class PackagesModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  PackagesModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  PackagesModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['error_message'] = this.errorMessage;
    data['error_message_en'] = this.errorMessageEn;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? type;
  String? parentId;
  String? name;
  String? img;
  int? price;
  int? trainCount;
  int? ratesCount;
  String? ratesAvgRate;
  List<Child>? child;
  List<Favorites>? favorites;

  Data(
      {this.id,
      this.type,
      this.parentId,
      this.name,
      this.img,
      this.price,
      this.trainCount,
      this.ratesCount,
      this.ratesAvgRate,
      this.child,
      this.favorites});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    parentId = json['parent_id'];
    name = json['name'];
    img = json['img'];
    price = json['price'];
    trainCount = json['spe_train_count'];
    ratesCount = json['rates_count'];
    ratesAvgRate = json['rates_avg_rate'];
    if (json['child'] != null) {
      child = <Child>[];
      json['child'].forEach((v) {
        child!.add(new Child.fromJson(v));
      });
    }
    if (json['favorites'] != null) {
      favorites = <Favorites>[];
      json['favorites'].forEach((v) {
        favorites!.add(new Favorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['img'] = this.img;
    data['price'] = this.price;
    data['spe_train_count'] = this.trainCount;
    data['rates_count'] = this.ratesCount;
    data['rates_avg_rate'] = this.ratesAvgRate;
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    if (this.favorites != null) {
      data['favorites'] = this.favorites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  String? parentId;
  int? trainingId;
  Trainings? trainings;

  Child({this.parentId, this.trainingId, this.trainings});

  Child.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    trainingId = json['training_id'];
    trainings = json['trainings'] != null
        ? new Trainings.fromJson(json['trainings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_id'] = this.parentId;
    data['training_id'] = this.trainingId;
    if (this.trainings != null) {
      data['trainings'] = this.trainings!.toJson();
    }
    return data;
  }
}

class Trainings {
  int? id;
  String? parentId;
  int? sessionNum;
  Parent? parent;

  Trainings({this.id, this.parentId, this.sessionNum, this.parent});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    sessionNum = json['session_num'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['session_num'] = this.sessionNum;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Parent {
  int? id;
  String? name;
  String? nameEn;
  String? img;

  Parent({this.id, this.name, this.nameEn, this.img});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['img'] = this.img;
    return data;
  }
}

class Favorites {
  int? id;
  String? type;
  int? userId;
  int? favoId;

  Favorites({this.id, this.type, this.userId, this.favoId});

  Favorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    favoId = json['favo_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['favo_id'] = this.favoId;
    return data;
  }
}
