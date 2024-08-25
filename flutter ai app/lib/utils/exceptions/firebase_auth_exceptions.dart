/// CUSTOM EXCEPTION CLASS TO HANDLE VARIOUS FIREBASE AUTHENTICATION - RELATED ERRORS
class TFirebaseAuthException implements Exception {
  ///THE ERROR CODE ASSOCIATED WITHTHEEXCEPTION
  final String code;

  ///CONSTRUCTOR THAT TAKES AN ERROR CODE.
  TFirebaseAuthException(this.code);

  ///GET THE CORRESPONDING ERROR MESSAGE BASED ON THE ERROR CODE
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'This email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a strong password.';
      case 'user-disabled':
        return 'this user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password ':
        return 'Incorrect password. please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request new a verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'This email address is already exists. Please use a different email.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.Contact suppoert for assistance.';
      case 'expired-action-code':
        return 'The action code has been expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has been expired and authentication is required. Please sign-in again.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign-in again.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email.';
      case 'missing-iframe-start':
        return 'The email template is missing the iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing the iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing the iframe src attribute.';
      case 'auth_domain_config_required':
        return 'The authDomain configuration is required for the action code verification link.';
      case 'missing-app_credential':
        return 'The app credential is missing. Please provide valid app credentials.';
      case 'invalid-app_credential':
        return 'The app credential is invalid. Please provide valid app credentials.';

      default:
        return 'Some error occured.';
    }
  }
}
