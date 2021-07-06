/// isError : true
/// Message : ""

class AppointmentVO {
  bool? _isError;
  String? _message;

  bool? get isError => _isError;
  String? get message => _message;

  AppointmentVO({
      bool? isError, 
      String? message}){
    _isError = isError;
    _message = message;
}

  AppointmentVO.fromJson(dynamic json) {
    _isError = json["isError"];
    _message = json["Message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isError"] = _isError;
    map["Message"] = _message;
    return map;
  }

}