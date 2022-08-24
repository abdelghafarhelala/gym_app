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
  String? qrCode;
  String? profilePhotoUrl;
  List<Training>? training;
  List<Package>? package;
  List<TrainingHistory>? trainingHistory;
  List<PackageHistory>? packageHistory;
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
      this.qrCode,
      this.profilePhotoUrl,
      this.training,
      this.package,
      this.trainingHistory,
      this.packageHistory,
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
    qrCode = json['qr_code'];
    profilePhotoUrl = json['profile_photo_url'];
    if (json['training'] != null) {
      training = <Training>[];
      json['training'].forEach((v) {
        training!.add(Training.fromJson(v));
      });
    }
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(Package.fromJson(v));
      });
    }
    if (json['training_history'] != null) {
      trainingHistory = <TrainingHistory>[];
      json['training_history'].forEach((v) {
        trainingHistory!.add(TrainingHistory.fromJson(v));
      });
    }
    if (json['package_history'] != null) {
      packageHistory = <PackageHistory>[];
      json['package_history'].forEach((v) {
        packageHistory!.add(PackageHistory.fromJson(v));
      });
    }
    subscribeStatus = json['subscribe_status'] != null
        ? SubscribeStatus.fromJson(json['subscribe_status'])
        : null;
    if (json['food_plane'] != null) {
      foodPlane = <FoodPlane>[];
      json['food_plane'].forEach((v) {
        foodPlane!.add(FoodPlane.fromJson(v));
      });
    }
    if (json['training_plane'] != null) {
      trainingPlane = <TrainingPlane>[];
      json['training_plane'].forEach((v) {
        trainingPlane!.add(TrainingPlane.fromJson(v));
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
        ? Trainings.fromJson(json['trainings'])
        : null;
  }
}

class Trainings {
  int? id;
  String? name;
  String? nameEn;
  String? img;

  Trainings({this.id, this.name, this.nameEn, this.img});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
  }
}

class Package {
  int? id;
  int? userId;
  int? packageId;
  String? startDate;
  String? endDate;
  PackageData? packageData;

  Package(
      {this.id,
      this.userId,
      this.packageId,
      this.startDate,
      this.endDate,
      this.packageData});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    packageData =
        json['package'] != null ? PackageData.fromJson(json['package']) : null;
  }
}

class PackageData {
  int? id;
  int? trainingId;
  String? name;
  String? nameEn;
  String? img;

  PackageData({this.id, this.trainingId, this.name, this.nameEn, this.img});

  PackageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainingId = json['training_id'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
  }
}

class TrainingHistory {
  int? id;
  int? userId;
  int? trainingId;
  String? startDate;
  String? endDate;
  Trainings? trainingHistoryData;

  TrainingHistory(
      {this.id,
      this.userId,
      this.trainingId,
      this.startDate,
      this.endDate,
      this.trainingHistoryData});

  TrainingHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    trainingId = json['training_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    trainingHistoryData = json['trainings'] != null
        ? Trainings.fromJson(json['trainings'])
        : null;
  }
}

class PackageHistory {
  int? id;
  int? userId;
  int? packageId;
  String? startDate;
  String? endDate;
  PackageData? packageHistoryData;

  PackageHistory(
      {this.id,
      this.userId,
      this.packageId,
      this.startDate,
      this.endDate,
      this.packageHistoryData});

  PackageHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    packageHistoryData =
        json['package'] != null ? PackageData.fromJson(json['package']) : null;
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
  FoodPlaneData? foodPlaneData;

  FoodPlane(
      {this.id,
      this.type,
      this.userId,
      this.planId,
      this.startDate,
      this.endDate,
      this.foodPlaneData});

  FoodPlane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    foodPlaneData =
        json['plane'] != null ? FoodPlaneData.fromJson(json['plane']) : null;
  }
}

class FoodPlaneData {
  int? id;
  String? type;
  String? name;
  String? nameEn;
  String? img;
  String? details;
  String? detailsEn;

  FoodPlaneData(
      {this.id,
      this.type,
      this.name,
      this.nameEn,
      this.img,
      this.details,
      this.detailsEn});

  FoodPlaneData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    nameEn = json['name_en'];
    img = json['img'];
    details = json['details'];
    detailsEn = json['details_en'];
  }
}

class TrainingPlane {
  int? id;
  String? type;
  int? userId;
  int? planId;
  String? startDate;
  String? endDate;
  FoodPlaneData? traininPlaneData;

  TrainingPlane(
      {this.id,
      this.type,
      this.userId,
      this.planId,
      this.startDate,
      this.endDate,
      this.traininPlaneData});

  TrainingPlane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    planId = json['plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    traininPlaneData =
        json['plane'] != null ? FoodPlaneData.fromJson(json['plane']) : null;
  }
}
