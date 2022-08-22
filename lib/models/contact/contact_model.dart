class ContactModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;

  ContactModel({this.result, this.errorMessage, this.errorMessageEn});

  ContactModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
  }
}
