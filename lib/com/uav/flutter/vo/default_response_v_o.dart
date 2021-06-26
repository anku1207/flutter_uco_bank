/// Message : "String"
/// isError : "bool"

class DefaultResponseVO {
  String? _message;
  bool? _isError;

  String? get message => _message;
  bool? get isError => _isError;

  DefaultResponseVO({
      String? message,
    bool? isError}){
    _message = message;
    _isError = isError;
}

  DefaultResponseVO.fromJson(dynamic json) {
    _message = json["Message"];
    _isError = json["isError"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Message"] = _message;
    map["isError"] = _isError;
    return map;
  }

}