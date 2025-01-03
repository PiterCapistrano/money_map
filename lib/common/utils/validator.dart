class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
    if (value != null && value.isEmpty) {
      return "This field cannot be empty.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Invalid name.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(r"\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b");
    if (value != null && value.isEmpty) {
      return "This field cannot be empty.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Invalid E-mail.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value != null && value.isEmpty) {
      return "This field cannot be empty.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Invalid Password.";
    }
    return null;
  }

  static String? validateConfirmPassword(String? first, String? second) {
    if (first != null && first.isEmpty) {
      return "This field cannot be empty.";
    }
    if (first != second) {
      return "Different password";
    }
    return null;
  }
}
