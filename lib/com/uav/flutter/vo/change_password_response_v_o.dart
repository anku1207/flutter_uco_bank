/// MobileNo : "String"
/// Message : "String"
/// customerId : "String"
/// Password : "String"
/// ConfirmPassword : "String"
/// isError : "String"

class ChangePasswordResponseVO {
  String? _mobileNo;
  String? _message;
  int? _customerId;
  String? _password;
  String? _confirmPassword;
  bool? _isError;

  String? get mobileNo => _mobileNo;
  String? get message => _message;
  int? get customerId => _customerId;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
  bool? get isError => _isError;

  ChangePasswordResponseVO({
      String? mobileNo, 
      String? message, 
      int? customerId,
      String? password, 
      String? confirmPassword, 
      bool? isError}){
    _mobileNo = mobileNo;
    _message = message;
    _customerId = customerId;
    _password = password;
    _confirmPassword = confirmPassword;
    _isError = isError;
}

  ChangePasswordResponseVO.fromJson(dynamic json) {
    _mobileNo = json["MobileNo"];
    _message = json["Message"];
    _customerId = json["customerId"];
    _password = json["Password"];
    _confirmPassword = json["ConfirmPassword"];
    _isError = json["isError"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MobileNo"] = _mobileNo;
    map["Message"] = _message;
    map["customerId"] = _customerId;
    map["Password"] = _password;
    map["ConfirmPassword"] = _confirmPassword;
    map["isError"] = _isError;
    return map;
  }

}