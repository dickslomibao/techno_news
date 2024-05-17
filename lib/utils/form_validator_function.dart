import 'package:multi_image_picker_view/multi_image_picker_view.dart';
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

/// It return true if valid
bool validateLoginForm({
  required String email,
  required String password,
}) {
  if (email.isEmpty) {
    handleToastError('Email is required.');
    return false;
  }
  if (password.isEmpty) {
    handleToastError('Password is required.');
    return false;
  }

  return true;
}

/// It return true if valid
bool validateCreateNewsForm({
  required List<ImageFile> images,
  required List<String> categories,
  required String title,
  required String content,
}) {
  if (categories.isEmpty) {
    handleToastError('Category is required.');
    return false;
  }
  if (title.isEmpty) {
    handleToastError('Title is required.');
    return false;
  }
  if (content.isEmpty) {
    handleToastError('Content is required.');
    return false;
  }
  if (images.isEmpty) {
    handleToastError('Images is required.');
    return false;
  }
  return true;
}
