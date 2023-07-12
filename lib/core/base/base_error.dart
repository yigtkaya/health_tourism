

import 'package:health_tourism/core/base/response.dart';

class BaseErrorModel extends HTErrorModel {
  late bool isError;
  late String dioExceptionMessage;
  String? message;
  int? errorType;
  int? errorCode;
  String? title;
  String? detailMessage;
  int? responseType;

  BaseErrorModel(
      {this.message,
      this.errorCode,
      this.errorType,
      this.title,
      this.responseType,
      this.detailMessage,
      this.dioExceptionMessage = "",
      this.isError = false});

  BaseErrorModel.defaultError() {
    isError = true;
    dioExceptionMessage = "Dio Default Error";
    message = "Beklenmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyiniz!";
  }

  BaseErrorModel generateErrorModel(Map<String, dynamic> json) {
    errorType = json['ErrorType'];
    errorCode = json['ErrorCode'];
    detailMessage = json['DetailMessage'];
    responseType = json['ResponseType'];
    message = json['Message'];
    title = json['Title'];

    return this;
  }
}
