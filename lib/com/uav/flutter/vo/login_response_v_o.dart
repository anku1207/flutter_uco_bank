/// MobileNo : "String"
/// isFirstLogin : "String"
/// customerId : "String"
/// Password : "String"
/// Message : "String"
/// isError : "String"

class LoginResponseVO {
  String? _mobileNo;
  bool? _isFirstLogin;
  int? _customerId;
  String? _password;
  String? _message;
  bool? _isError;

  String? get mobileNo => _mobileNo;
  bool? get isFirstLogin => _isFirstLogin;
  int? get customerId => _customerId;
  String? get password => _password;
  String? get message => _message;
  bool? get isError => _isError;

  LoginResponseVO({
      String? mobileNo, 
      bool? isFirstLogin,
      int? customerId,
      String? password, 
      String? message, 
      bool? isError}){
    _mobileNo = mobileNo;
    _isFirstLogin = isFirstLogin;
    _customerId = customerId;
    _password = password;
    _message = message;
    _isError = isError;
}

  LoginResponseVO.fromJson(dynamic json) {
    _mobileNo = json["MobileNo"];
    _isFirstLogin = json["isFirstLogin"];
    _customerId = json["customerId"];
    _password = json["Password"];
    _message = json["Message"];
    _isError = json["isError"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MobileNo"] = _mobileNo;
    map["isFirstLogin"] = _isFirstLogin;
    map["customerId"] = _customerId;
    map["Password"] = _password;
    map["Message"] = _message;
    map["isError"] = _isError;
    return map..removeWhere((key, value) => value == null);
  }

}