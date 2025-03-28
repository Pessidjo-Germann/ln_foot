/// Utility class for common input validation logic.
class Validators {
  /// Validates an email address.
  /// Returns an error message string if invalid, otherwise null.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre adresse mail';
    }
    // Basic email regex (consider using a more robust one or a package for production)
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez entrer une adresse mail valide';
    }
    return null;
  }

  /// Validates a password based on minimum length.
  /// Returns an error message string if invalid, otherwise null.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  /// Validates if the confirm password matches the original password.
  /// Requires the original password controller's text for comparison.
  /// Returns an error message string if invalid, otherwise null.
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != originalPassword) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  /// Generic validator for required fields.
  static String? validateRequired(String? value, String fieldName) {
      if (value == null || value.isEmpty) {
          return 'Veuillez entrer $fieldName';
      }
      return null;
  }

  /// Validates OTP code length.
  static String? validateOtp(String? value, {int length = 4}) {
    if (value == null || value.length != length) {
      return 'Veuillez entrer le code à $length chiffres';
    }
    // Add more specific OTP validation if needed (e.g., numeric only)
    return null;
  }
}
