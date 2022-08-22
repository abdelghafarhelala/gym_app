class ProfileModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  ProfileModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? email;
  int? length;
  int? weight;
  String? illnesses;
  String? notes;
  String? sex;
  String? profilePhotoPath;
  String? profilePhotoUrl;
  List<Training>? training;
  List<Packages>? packages;
  SubscribeStatus? subscribeStatus;
  List<FoodPlane>? foodPlane;
  List<TrainingPlane>? trainingPlane;

  Data(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.length,
      this.weight,
      this.illnesses,
      this.notes,
      this.sex,
      this.profilePhotoPath,
      this.profilePhotoUrl,
      this.training,
      this.packages,
      this.subscribeStatus,
      this.foodPlane,
      this.trainingPlane});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    length = json['length'];
    weight = json['weight'];
    illnesses = json['illnesses'];
    notes = json['notes'];
    sex = json['sex'];
    profilePhotoPath = json['profile_photo_path'];
    profilePhotoUrl = json['profile_photo_url'];
    if (json['training'] != null) {
      training = <Training>[];
      json['training'].forEach((v) {
        training!.add(new Training.fromJson(v));
      });
    }
    if (json['package'] != null) {
      packages = <Packages>[];
      json['package'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
    subscribeStatus = json['subscribe_status'] != null
        ? new SubscribeStatus.fromJson(json['subscribe_status'])
        : null;
    if (json['food_plane'] != null) {
      foodPlane = <FoodPlane>[];
      json['food_plane'].forEach((v) {
        foodPlane!.add(new FoodPlane.fromJson(v));
      });
    }
    if (json['training_plane'] != null) {
      trainingPlane = <TrainingPlane>[];
      json['training_plane'].forEach((v) {
        trainingPlane!.add(new TrainingPlane.fromJson(v));
      });
    }
  }
}

class Training {
  int? id;
  int? userId;
  int? trainingId;
  String? startDate;
  String? endDate;
  Trainings? trainings;

  Training(
      {this.id,
      this.userId,
      this.trainingId,
      this.startDate,
      this.endDate,
      this.trainings});

  Training.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    trainingId = json['training_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    trainings = json['trainings'] != null
        ? new Trainings.fromJson(json['trainings'])
        : null;
  }
}

class Trainings {
  int? id;
  String? name;
  String? nameEn;
  String? image;

  Trainings({this.id, this.name, this.nameEn, this.image});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    image = json['img'];
  }
}

class Packages {
  int? id;
  int? userId;
  int? packageId;
  String? startDate;
  String? endDate;
  Package? package;

  Packages(
      {this.id,
      this.userId,
      this.packageId,
      this.startDate,
      this.endDate,
      this.package});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
  }
}

class Package {
  int? id;
  int? trainingId;
  String? name;
  String? nameEn;
  String? image;

  Package({this.id, this.trainingId, this.name, this.nameEn, this.image});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainingId = json['training_id'];
    name = json['name'];
    nameEn = json['name_en'];
    image = json['img'];
  }
}

class SubscribeStatus {
  int? id;
  int? userId;
  int? payed;
  int? remaining;
  int? monthNum;
  String? startDate;
  String? endDate;
  String? deletedAt;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  SubscribeStatus(
      {this.id,
      this.userId,
      this.payed,
      this.remaining,
      this.monthNum,
      this.startDate,
      this.endDate,
      this.deletedAt,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  SubscribeStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    payed = json['payed'];
    remaining = json['remaining'];
    monthNum = json['month_num'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    deletedAt = json['deleted_at'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class FoodPlane {
  int? id;
  String? type;
  int? userId;
  int? planId;
  String? startDate;
  String? endDate;
  PlaneFo? plane;

  FoodPlane(
      {this.id,
      this.type,
      this.userId,
      this.planId,
      this.startDate,
      this.endDate,
      this.plane});

  FoodPlane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    plane = json['plane'] != null ? PlaneFo.fromJson(json['plane']) : null;
  }
}

class TrainingPlane {
  int? id;
  String? type;
  int? userId;
  int? planId;
  String? startDate;
  String? endDate;
  Plane? plane;

  TrainingPlane(
      {this.id,
      this.type,
      this.userId,
      this.planId,
      this.startDate,
      this.endDate,
      this.plane});

  TrainingPlane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    plane = json['plane'] != null ? new Plane.fromJson(json['plane']) : null;
  }
}

class Plane {
  int? id;
  String? type;
  String? name;
  String? nameEn;
  String? img;
  String? details;
  String? detailsEn;

  Plane(
      {this.id,
      this.type,
      this.name,
      this.nameEn,
      this.img,
      this.details,
      this.detailsEn});

  Plane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
    details = json['details'];
    detailsEn = json['details_en'];
  }
}

class PlaneFo {
  int? id;
  String? type;
  String? name;
  String? nameEn;
  String? img;
  String? details;
  String? detailsEn;

  PlaneFo(
      {this.id,
      this.type,
      this.name,
      this.nameEn,
      this.img,
      this.details,
      this.detailsEn});

  PlaneFo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
    details = json['details'];
    detailsEn = json['details_en'];
  }
}
