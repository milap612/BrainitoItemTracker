import '../utils/app_strings.dart';

mixin Validator {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameValidation;
    }
    return null;
  }

  String? validateDescription(String? value) {
    return null;
  }
}
