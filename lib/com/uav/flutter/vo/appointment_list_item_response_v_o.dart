import 'appointment_list_item_v_o.dart';

/// isError : "String"
/// Message : "String"
/// appointmentList : "String"

class AppointmentListItemResponseVO {
  bool? _isError;
  String? _message;
  List<AppointmentListItemVO>? _appointmentList;

  bool? get isError => _isError;
  String? get message => _message;
  List<AppointmentListItemVO>? get appointmentList => _appointmentList;

  AppointmentListItemResponseVO({
    bool? isError,
      String? message,
      List<AppointmentListItemVO>? appointmentList}){
    _isError = isError;
    _message = message;
    _appointmentList = appointmentList;
}

  AppointmentListItemResponseVO.fromJson(dynamic json) {
    _isError = json["isError"];
    _message = json["Message"];
    _appointmentList = json["appointmentList"] != null ? List<AppointmentListItemVO>.from(json['appointmentList']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isError"] = _isError;
    map["Message"] = _message;
    map["appointmentList"] = _appointmentList;
    return map;
  }

}