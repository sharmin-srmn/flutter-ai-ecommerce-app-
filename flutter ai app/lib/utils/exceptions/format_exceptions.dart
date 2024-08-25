/// CUSTOM EXCEPTION CLASS TO HANDLE VARIOUS FARMAT_RELATED ERRORS
class TFormatException implements Exception {
  ///THE ASSOCIATED ERROR MESSAGE
  final String message;

  ///DEFUALT CONSTRUCTOR WITHA GENERIC ERROR MESSAGE
  const TFormatException(
      [this.message =
          'An unexpected format error occured. Please check the input.']);

  ///CREATE A FORMAT EXCEPTION FROM A SPECIFIC ERROR MESSAGE
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  ///Get the corresponding error message
  String get formattedMessage => message;

  /// CREATE A FORMAT EXCEPTION FROM A SPECIFIC ERROR CODE
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
            'The email address format is invalid. Please enter a valid emial.');
      case 'invalid-phone-number-format':
        return const TFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const TFormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const TFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const TFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const TFormatException(
            'The input should be valid numeric number.');
      default:
        return const TFormatException('Some other formatter error occured.');
    }
  }
}
