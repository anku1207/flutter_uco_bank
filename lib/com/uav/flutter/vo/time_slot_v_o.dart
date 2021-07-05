/// isError : true
/// Message : ""
/// BranchId : 1
/// AppointmentDate : ""
/// Slot : [""]

class TimeSlotVO {
  bool? _isError;
  String? _message;
  int? _branchId;
  String? _appointmentDate;
  List<String>? _slot;

  bool? get isError => _isError;
  String? get message => _message;
  int? get branchId => _branchId;
  String? get appointmentDate => _appointmentDate;
  List<String>? get slot => _slot;

  TimeSlotVO({
      bool? isError, 
      String? message, 
      int? branchId, 
      String? appointmentDate, 
      List<String>? slot}){
    _isError = isError;
    _message = message;
    _branchId = branchId;
    _appointmentDate = appointmentDate;
    _slot = slot;
}

  TimeSlotVO.fromJson(dynamic json) {
    _isError = json["isError"];
    _message = json["Message"];
    _branchId = json["BranchId"];
    _appointmentDate = json["AppointmentDate"];
    _slot = json["Slot"] != null ? json["Slot"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isError"] = _isError;
    map["Message"] = _message;
    map["BranchId"] = _branchId;
    map["AppointmentDate"] = _appointmentDate;
    map["Slot"] = _slot;
    return map;
  }

}