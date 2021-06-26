/// error : "String"
/// message : "String"

class DefaultResponseVO {
  bool? _error;
  String? _message;

  bool? get error => _error;
  String? get message => _message;

  DefaultResponseVO({
    bool? error,
      String? message}){
    _error = error;
    _message = message;
}

  DefaultResponseVO.fromJson(dynamic json) {
    _error = json["error"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = _error;
    map["message"] = _message;
    return map;
  }

}