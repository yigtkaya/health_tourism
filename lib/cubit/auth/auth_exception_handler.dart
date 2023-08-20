enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case "invalid-email":
        errorMessage = "Your email address is not valid. Please enter a valid email address.";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong. Please enter correct password.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist. Please enter valid email address.";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled. Please contact support.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Too many requests. Try again later. Please try again in a few minutes.";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled. Please contact support.";
        break;
      case "account-exists-with-different-credential":
        errorMessage = "There is already a account with this credentials but different email address. Please try again with different email address.";
        break;
      case "weak-password":
        errorMessage = "Your password is too weak and easy to guess. Please enter strong password.";
        break;
      case "email-already-in-use":
        errorMessage = "Email is already in use on different account or this account. Please try again with different email address.";
        break;
      case "invalid-credential":
        errorMessage = "Your email is invalid or expired. Please try again with different email.";
        break;
      default:
        errorMessage = "An Error happened.";
    }

    return errorMessage;
  }
}
