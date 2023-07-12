// create cubit for login screen

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';

import 'validation_state.dart';


class ValidationCubit extends Cubit<ValidationState> {

  ValidationCubit() : super(ValidationState(validEmail: false, validPassword: false, hasOneUpperCase: false, hasOneNumber: false, isPasswordLongEnough: false));

  void validateEmail(String email) {
    if (EmailValidator.validate(email)) {
      emit(state.copyWith(validEmail: true, validPassword: state.validPassword));
    } else {
      emit(state.copyWith(validEmail: false, validPassword: state.validPassword));
    }
  }

  void validatePassword(String password) {

    final number = RegExp(r'(?=.*\d)');
    final upperCase = RegExp(r'(?=.*[A-Z])');
    bool isLongEnough = false;
    bool hasOneNumber = false;
    bool hasOneUpperCase = false;
    bool isValid = false;

    if (password.length >= 8) {
      isLongEnough = true;
    } else {
      isLongEnough = false;
    }

    if (number.hasMatch(password)) {
      hasOneNumber = true;
    } else {
      hasOneNumber = false;
    }
    if (upperCase.hasMatch(password)) {
      hasOneUpperCase = true;
    } else {
      hasOneUpperCase = false;
    }

    if (isLongEnough && hasOneNumber && hasOneUpperCase) {
      isValid = true;
    } else {
      isValid = false;
    }

    emit(state.copyWith(
        validPassword: isValid,
        validEmail: state.validEmail,
        hasOneUpperCase: hasOneUpperCase,
        hasOneNumber: hasOneNumber,
        isPasswordLongEnough: isLongEnough,));
  }
}