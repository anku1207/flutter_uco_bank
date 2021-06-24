/// isError : "Boolean"
/// Message : "String"
/// mobileno : "String"

class DuplicateVO {
  bool? _isError;
  String? _message;
  String? _mobileno;

  bool? get isError => _isError;
  String? get message => _message;
  String? get mobileno => _mobileno;

  DuplicateVO({
      bool? isError,
      String? message, 
      String? mobileno}){
    _isError = isError;
    _message = message;
    _mobileno = mobileno;
}

  DuplicateVO.fromJson(dynamic json) {
    _isError = json["isError"];
    _message = json["Message"];
    _mobileno = json["mobileno"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isError"] = _isError;
    map["Message"] = _message;
    map["mobileno"] = _mobileno;
    return map;
  }

}