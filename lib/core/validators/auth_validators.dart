mixin AuthValidators {
  String? emailValidator(value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Enter an email *';
    } else if (!regExp.hasMatch(
      value.toString().trim(),
    )) {
      return 'Email is not valid *';
    } else {
      return null;
    }
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return "This field is required *";
    } else {
      return null;
    }
  }

  String? passwordValidator(value) {
    validator(value);

    if (value!.isEmpty) {
      return 'Enter password *';
    } else if (value.length < 6) {
      return 'Password must be of length 6 *';
    } else {
      return null;
    }
  }
}
