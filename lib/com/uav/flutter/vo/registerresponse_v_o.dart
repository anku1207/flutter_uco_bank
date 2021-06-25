/// MobileNo : "String"
/// Email : "String"
/// isError : "bool"
/// Message : "String"
/// oTP : "String"
/// customerId : "Int"
/// name : "String"
/// password : "String"

class RegisterResponseVO {
  String? _mobileNo;
  String? _email;
  bool? _isError;
  String? _message;
  String? _oTP;
  int? _customerId;
  String? _name;
  String? _password;

  String? get mobileNo => _mobileNo;
  String? get email => _email;
  bool? get isError => _isError;
  String? get message => _message;
  String? get oTP => _oTP;
  int? get customerId => _customerId;
  String? get name => _name;
  String? get password => _password;

  RegisterResponseVO({
      String? mobileNo, 
      String? email, 
      bool? isError,
      String? message, 
      String? oTP, 
      int? customerId,
      String? name, 
      String? password}){
    _mobileNo = mobileNo;
    _email = email;
    _isError = isError;
    _message = message;
    _oTP = oTP;
    _customerId = customerId;
    _name = name;
    _password = password;
}

  RegisterResponseVO.fromJson(dynamic json) {
    _mobileNo = json["MobileNo"];
    _email = json["Email"];
    _isError = json["isError"];
    _message = json["Message"];
    _oTP = json["oTP"];
    _customerId = json["customerId"];
    _name = json["name"];
    _password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MobileNo"] = _mobileNo;
    map["Email"] = _email;
    map["isError"] = _isError;
    map["Message"] = _message;
    map["oTP"] = _oTP;
    map["customerId"] = _customerId;
    map["name"] = _name;
    map["password"] = _password;
    return map;
  }

}