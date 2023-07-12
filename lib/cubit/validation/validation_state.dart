class ValidationState {
  bool validEmail = false;
  bool hasOneUpperCase = false;
  bool isPasswordLongEnough = false;
  bool hasOneNumber = false;
  bool validPassword = false;

 ValidationState({required this.validEmail, required this.validPassword, required this.hasOneUpperCase, required this.hasOneNumber, required this.isPasswordLongEnough});

  ValidationState copyWith({bool? validEmail, bool? validPassword, bool? hasOneUpperCase, bool? hasOneNumber, bool? isPasswordLongEnough}) {
      return ValidationState(
        validEmail: validEmail ?? this.validEmail,
        validPassword: validPassword ?? this.validPassword,
        hasOneUpperCase: hasOneUpperCase ?? this.hasOneUpperCase,
        hasOneNumber: hasOneNumber ?? this.hasOneNumber,
        isPasswordLongEnough: isPasswordLongEnough ?? this.isPasswordLongEnough,
      );
    }
}