mixin PasswordValidator {
  bool isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (!isValidPassword(password)) {
      return 'Password must be at least 8 characters long, include a letter, '
          'a number, and a special character.';
    }
    return null; // Indicates valid password
  }
}
