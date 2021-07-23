import 'appointment_list_item_v_o.dart';

/// cancelledAppointment : "Int?"
/// upcomingAppointment : "Int?"
/// AllAppointment : "Int?"
/// TodayAppointment : "Int?"
/// appointmentList : "List<AppointmentListItem>?"
/// Message : "String?"
/// CompletedAppointment : "Int?"
/// isError : "Boolean?"
/// Name : "String?"
/// Email : "String?"

class DashboardResponseVO {
  int? _cancelledAppointment;
  int? _upcomingAppointment;
  int? _allAppointment;
  int? _todayAppointment;
  List<AppointmentListItemVO>? _appointmentList;
  String? _message;
  int? _completedAppointment;
  bool? _isError;
  String? _name;
  String? _email;

  int? get cancelledAppointment => _cancelledAppointment;
  int? get upcomingAppointment => _upcomingAppointment;
  int? get allAppointment => _allAppointment;
  int? get todayAppointment => _todayAppointment;
  List<AppointmentListItemVO>? get appointmentList => _appointmentList;
  String? get message => _message;
  int? get completedAppointment => _completedAppointment;
  bool? get isError => _isError;
  String? get name => _name;
  String? get email => _email;

  DashboardResponseVO(
      {int? cancelledAppointment,
      int? upcomingAppointment,
      int? allAppointment,
      int? todayAppointment,
      List<AppointmentListItemVO>? appointmentList,
      String? message,
      int? completedAppointment,
      bool? isError,
      String? name,
      String? email}) {
    _cancelledAppointment = cancelledAppointment;
    _upcomingAppointment = upcomingAppointment;
    _allAppointment = allAppointment;
    _todayAppointment = todayAppointment;
    _appointmentList = appointmentList;
    _message = message;
    _completedAppointment = completedAppointment;
    _isError = isError;
    _name = name;
    _email = email;
  }

  DashboardResponseVO.fromJson(dynamic json) {
    _cancelledAppointment = json["cancelledAppointment"];
    _upcomingAppointment = json["upcomingAppointment"];
    _allAppointment = json["AllAppointment"];
    _todayAppointment = json["TodayAppointment"];
    if (json["appointmentList"] != null) {
      _appointmentList = [];
      json["appointmentList"].forEach((v) {
        _appointmentList?.add(AppointmentListItemVO.fromJson(v));
      });
    }
    _message = json["Message"];
    _completedAppointment = json["CompletedAppointment"];
    _isError = json["isError"];
    _name = json["Name"];
    _email = json["Email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cancelledAppointment"] = _cancelledAppointment;
    map["upcomingAppointment"] = _upcomingAppointment;
    map["AllAppointment"] = _allAppointment;
    map["TodayAppointment"] = _todayAppointment;
    if (_appointmentList != null) {
      map["branchList"] = _appointmentList?.map((v) => v.toJson()).toList();
    }
    map["Message"] = _message;
    map["CompletedAppointment"] = _completedAppointment;
    map["isError"] = _isError;
    map["Name"] = _name;
    map["Email"] = _email;
    return map..removeWhere((key, value) => value == null);
  }
}
