class Validator {
  static String? validateSchool({required String? str}) {
    if (str == null) {
      return null;
    }
    if (str.isEmpty) {
      return 'School can\'t be empty';
    }
    return null;
  }
}
