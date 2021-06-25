String? validateMobileNumber(String value){
 // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String pattern = r'(^[6-9][0-9]{9}$)';
  RegExp regExp = new RegExp(pattern);
  if (value == "") {
    return 'mobile number is required';
  } else if (!regExp.hasMatch(value)) {
    return 'Mobile No. accepts only  numbers and length should be 10 (first number to start with [6-9]';
  }
  return null;
}

String? validateRequiredField(String? value){
  if (value == "") {
    return 'this field is required';
  }
  return null;
}
