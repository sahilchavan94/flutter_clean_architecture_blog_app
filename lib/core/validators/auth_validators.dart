mixin AuthValidators {
  String? emailValidator(value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Enter an email';
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
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{6,}$';
    final regExp = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Enter password';
    } else if (!regExp.hasMatch(value)) {
      return 'Password must be of length 6 \nwith at least 1 uppercase letter\nwith at least 1 lowercase letter\nwith at least 1 number\nand at least 1 special character *';
    } else {
      return null;
    }
  }
}
