/// MobileNo : "String"
/// Status : "String"
/// CustomerId : "String"
/// BranchId : "String"
/// AppointmentNumber : "String"
/// CustomerType : "String"
/// ServiceId : "String"
/// Appointmentdatetime : "String"
/// ServiceName : "String"
/// AppointmentId : "String"
/// KioskId : "String"
/// Slot : "String"
/// CustomerName : "String"
/// BranchName : "String"
/// TokenId : "String"

class AppointmentListItemVO {
  String? _mobileNo;
  String? _status;
  int? _customerId;
  int? _branchId;
  String? _appointmentNumber;
  dynamic? _customerType;
  int? _serviceId;
  String? _appointmentdatetime;
  String? _serviceName;
  int? _appointmentId;
  int? _kioskId;
  String? _slot;
  String? _customerName;
  String? _branchName;
  int? _tokenId;

  String? get mobileNo => _mobileNo;
  String? get status => _status;
  int? get customerId => _customerId;
  int? get branchId => _branchId;
  String? get appointmentNumber => _appointmentNumber;
  dynamic? get customerType => _customerType;
  int? get serviceId => _serviceId;
  String? get appointmentdatetime => _appointmentdatetime;
  String? get serviceName => _serviceName;
  int? get appointmentId => _appointmentId;
  int? get kioskId => _kioskId;
  String? get slot => _slot;
  String? get customerName => _customerName;
  String? get branchName => _branchName;
  int? get tokenId => _tokenId;

  AppointmentListItemVO({
      String? mobileNo, 
      String? status, 
      int? customerId,
      int? branchId,
      String? appointmentNumber, 
      dynamic? customerType,
      int? serviceId,
      String? appointmentdatetime, 
      String? serviceName,
      int? appointmentId,
      int? kioskId,
      String? slot, 
      String? customerName, 
      String? branchName, 
      int? tokenId}){
    _mobileNo = mobileNo;
    _status = status;
    _customerId = customerId;
    _branchId = branchId;
    _appointmentNumber = appointmentNumber;
    _customerType = customerType;
    _serviceId = serviceId;
    _appointmentdatetime = appointmentdatetime;
    _serviceName = serviceName;
    _appointmentId = appointmentId;
    _kioskId = kioskId;
    _slot = slot;
    _customerName = customerName;
    _branchName = branchName;
    _tokenId = tokenId;
}

  AppointmentListItemVO.fromJson(dynamic json) {
    _mobileNo = json["MobileNo"];
    _status = json["Status"];
    _customerId = json["CustomerId"];
    _branchId = json["BranchId"];
    _appointmentNumber = json["AppointmentNumber"];
    _customerType = json["CustomerType"];
    _serviceId = json["ServiceId"];
    _appointmentdatetime = json["Appointmentdatetime"];
    _serviceName = json["ServiceName"];
    _appointmentId = json["AppointmentId"];
    _kioskId = json["KioskId"];
    _slot = json["Slot"];
    _customerName = json["CustomerName"];
    _branchName = json["BranchName"];
    _tokenId = json["TokenId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["MobileNo"] = _mobileNo;
    map["Status"] = _status;
    map["CustomerId"] = _customerId;
    map["BranchId"] = _branchId;
    map["AppointmentNumber"] = _appointmentNumber;
    map["CustomerType"] = _customerType;
    map["ServiceId"] = _serviceId;
    map["Appointmentdatetime"] = _appointmentdatetime;
    map["ServiceName"] = _serviceName;
    map["AppointmentId"] = _appointmentId;
    map["KioskId"] = _kioskId;
    map["Slot"] = _slot;
    map["CustomerName"] = _customerName;
    map["BranchName"] = _branchName;
    map["TokenId"] = _tokenId;
    return map..removeWhere((key, value) => value == null);
  }

}