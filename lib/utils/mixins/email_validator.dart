mixin EmailValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!isValidEmail(email)) {
      return 'Invalid email address';
    }
    return null; // Indicates valid email
  }
}
