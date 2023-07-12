
import 'base_error.dart';

abstract class HTResponseModel<T> {
  T? data;
  BaseErrorModel? error;
}

abstract class HTErrorModel<T> {
  void statusCode() {}
}

class BaseResponseModel<T> extends HTResponseModel<T> {
  @override
  final T? data;
  @override
  final BaseErrorModel? error;

  BaseResponseModel({this.data, this.error});
}