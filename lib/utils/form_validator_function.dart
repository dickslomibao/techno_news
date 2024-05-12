import 'package:techno_news/utils/helper_function.dart';

/// It return true if valid
bool validateRegistrationForm({
  required String fullName,
  required String email,
  required String password,
  required String passwordConfirmation,
}) {
  if (fullName.isEmpty) {
    handleToastError('Full name is required.');
    return false;
  }
  if (email.isEmpty) {
    handleToastError('Email is required.');
    return false;
  }
  if (password.isEmpty) {
    handleToastError('Password is required.');
    return false;
  }
  if (passwordConfirmation.isEmpty) {
    handleToastError('Password Confirmation is required.');
    return false;
  }
  if (password != passwordConfirmation) {
    handleToastError('Password did not matched.');
    return false;
  }
  return true;
}
