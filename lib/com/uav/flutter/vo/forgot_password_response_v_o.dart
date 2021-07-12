/// MobileNo : ""
/// isError : true
/// Message : ""
/// OTP : ""

class ForgotPasswordResponseVO {
  String? _mobileNo;
  bool? _isError;
  String? _message;
  String? _otp;

  String? get mobileNo => _mobileNo;
  bool? get isError => _isError;
  String? get message => _message;
  String? get otp => _otp;

  ForgotPasswordResponseVO({
      String? mobileNo, 
      bool? isError, 
      String? message, 
      String? otp}){
    _mobileNo = mobileNo;
    _isError = isError;
    _message = message;
    _otp = otp;
}

  ForgotPasswordResponseVO.fromJson(dynamic json) {
    _mobileNo = json["MobileNo"];
    _isError = json["isError"];
    _message = json["Message"];
    _otp = json["OTP"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MobileNo"] = _mobileNo;
    map["isError"] = _isError;
    map["Message"] = _message;
    map["OTP"] = _otp;
    return map;
  }

}