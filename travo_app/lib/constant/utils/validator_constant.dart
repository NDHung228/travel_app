class ValidatorConstant {
  
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Invalid email';
    }
    return null;
  }

  static String? validatePass(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please enter name';
    }
    return null;
  }

  static String? validateCountry(String? country) {
    if (country == null || country.isEmpty) {
      return 'Please enter country';
    }
    return null;
  }

  static String? validatePhone(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter phone number';
    }
    else if(phoneNumber.length < 8) {
      return 'Please enter the full number';
    }
    return null;
  }
}
