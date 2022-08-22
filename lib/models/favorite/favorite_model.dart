class FavoriteModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;

  FavoriteModel({
    this.result,
    this.errorMessage,
    this.errorMessageEn,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
  }
}
