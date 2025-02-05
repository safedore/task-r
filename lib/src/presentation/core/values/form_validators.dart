class TextFieldValidation {
  static bool emptyValidate(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }
}
