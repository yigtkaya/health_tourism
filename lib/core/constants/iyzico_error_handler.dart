
import 'package:health_tourism/product/models/iyzico_error.dart';

class ErrorHandler {
  static final List<IyzicoError> _errorList = [
    IyzicoError(
      errorCode: 10051,
      errorMessage: 'Insufficient card limit, insufficient balance',
      errorGroup: 'NOT_SUFFICIENT_FUNDS',
    ),
    IyzicoError(
      errorCode: 10005,
      errorMessage: 'Transaction not approved',
      errorGroup: 'DO_NOT_HONOR',
    ),
    IyzicoError(
      errorCode: 10012,
      errorMessage: 'Invalid transaction',
      errorGroup: 'INVALID_TRANSACTION',
    ),
    IyzicoError(
      errorCode: 10041,
      errorMessage: 'Lost card, seize the card',
      errorGroup: 'LOST_CARD',
    ),
    IyzicoError(
      errorCode: 10043,
      errorMessage: 'Stolen card, seize the card',
      errorGroup: 'STOLEN_CARD',
    ),
    IyzicoError(
      errorCode: 10054,
      errorMessage: 'Expired card',
      errorGroup: 'EXPIRED_CARD',
    ),
    IyzicoError(
      errorCode: 10084,
      errorMessage: 'Invalid CVC2 information',
      errorGroup: 'INVALID_CVC2',
    ),
    IyzicoError(
      errorCode: 10057,
      errorMessage: "Cardholder can't perform this transaction",
      errorGroup: 'NOT_PERMITTED_TO_CARDHOLDER',
    ),
    IyzicoError(
      errorCode: 10058,
      errorMessage: "Terminal is not authorized to perform this transaction",
      errorGroup: 'NOT_PERMITTED_TO_TERMINAL',
    ),
    IyzicoError(
      errorCode: 10034,
      errorMessage: 'Fraud suspicion',
      errorGroup: 'FRAUD_SUSPECT',
    ),
    IyzicoError(
      errorCode: 10093,
      errorMessage: 'Your card is restricted from e-commerce transactions. Please contact your bank.',
      errorGroup: 'RESTRICTED_BY_LAW',
    ),
    IyzicoError(
      errorCode: 10201,
      errorMessage: 'Card did not permit the transaction',
      errorGroup: 'CARD_NOT_PERMITTED',
    ),
    IyzicoError(
      errorCode: 10204,
      errorMessage: 'General error occurred during the payment process',
      errorGroup: 'UNKNOWN',
    ),
    IyzicoError(
      errorCode: 10206,
      errorMessage: 'Invalid CVC2 length',
      errorGroup: 'INVALID_CVC2_LENGTH',
    ),
    IyzicoError(
      errorCode: 10207,
      errorMessage: 'Please get approval from your bank',
      errorGroup: 'REFER_TO_CARD_ISSUER',
    ),
    IyzicoError(
      errorCode: 10208,
      errorMessage: 'Invalid merchant or service provider',
      errorGroup: 'INVALID_MERCHANT_OR_SP',
    ),
    IyzicoError(
      errorCode: 10209,
      errorMessage: 'Blocked card',
      errorGroup: 'BLOCKED_CARD',
    ),
    IyzicoError(
      errorCode: 10210,
      errorMessage: 'Invalid CAVV information',
      errorGroup: 'INVALID_CAVV',
    ),
    IyzicoError(
      errorCode: 10211,
      errorMessage: 'Invalid ECI information',
      errorGroup: 'INVALID_ECI',
    ),
    IyzicoError(
      errorCode: 10213,
      errorMessage: 'BIN not found',
      errorGroup: 'BIN_NOT_FOUND',
    ),
    IyzicoError(
      errorCode: 10214,
      errorMessage: 'Communication or system error',
      errorGroup: 'COMMUNICATION_OR_SYSTEM_ERROR',
    ),
    IyzicoError(
      errorCode: 10215,
      errorMessage: 'Invalid card number',
      errorGroup: 'INVALID_CARD_NUMBER',
    ),
    IyzicoError(
      errorCode: 10216,
      errorMessage: 'Issuer not found',
      errorGroup: 'NO_SUCH_ISSUER',
    ),
    IyzicoError(
      errorCode: 10217,
      errorMessage: 'Bank cards can only be used for 3D Secure transactions',
      errorGroup: 'DEBIT_CARDS_REQUIRES_3DS',
    ),
    IyzicoError(
      errorCode: 10219,
      errorMessage: 'Request sent to the bank timed out',
      errorGroup: 'REQUEST_TIMEOUT',
    ),
    IyzicoError(
      errorCode: 10222,
      errorMessage: 'Terminal is not authorized for installment transactions',
      errorGroup: 'NOT_PERMITTED_TO_INSTALLMENT',
    ),
    IyzicoError(
      errorCode: 10223,
      errorMessage: 'Day-end required',
      errorGroup: 'REQUIRES_DAY_END',
    ),
    IyzicoError(
      errorCode: 10225,
      errorMessage: 'Restricted card',
      errorGroup: 'RESTRICTED_CARD',
    ),
    IyzicoError(
      errorCode: 10226,
      errorMessage: 'Exceeded allowable PIN tries',
      errorGroup: 'EXCEEDS_ALLOWABLE_PIN_TRIES',
    ),
    IyzicoError(
      errorCode: 10227,
      errorMessage: 'Invalid PIN',
      errorGroup: 'INVALID_PIN',
    ),
    IyzicoError(
      errorCode: 10228,
      errorMessage: 'Issuer or switch inoperative, unable to process the transaction',
      errorGroup: 'ISSUER_OR_SWITCH_INOPERATIVE',
    ),
    IyzicoError(
      errorCode: 10229,
      errorMessage: 'Invalid expiration year or month',
      errorGroup: 'INVALID_EXPIRE_YEAR_MONTH',
    ),
    IyzicoError(
      errorCode: 10232,
      errorMessage: 'Invalid amount',
      errorGroup: 'INVALID_AMOUNT',
    ),
  ];

  static IyzicoError? getErrorByErrorCode(int errorCode) {
    return _errorList.firstWhere((error) => error.errorCode == errorCode);
  }
}
