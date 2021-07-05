/// serviceList : [{"ServiceName":"","ServiceId":1}]
/// isError : true
/// Message : ""

class ServicesResponseVO {
  List<ServiceList>? _serviceList;
  bool? _isError;
  String? _message;

  List<ServiceList>? get serviceList => _serviceList;
  bool? get isError => _isError;
  String? get message => _message;

  ServicesResponseVO({
      List<ServiceList>? serviceList, 
      bool? isError, 
      String? message}){
    _serviceList = serviceList;
    _isError = isError;
    _message = message;
}

  ServicesResponseVO.fromJson(dynamic json) {
    if (json["serviceList"] != null) {
      _serviceList = [];
      json["serviceList"].forEach((v) {
        _serviceList?.add(ServiceList.fromJson(v));
      });
    }
    _isError = json["isError"];
    _message = json["Message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_serviceList != null) {
      map["serviceList"] = _serviceList?.map((v) => v.toJson()).toList();
    }
    map["isError"] = _isError;
    map["Message"] = _message;
    return map;
  }

}

/// ServiceName : ""
/// ServiceId : 1

class ServiceList {
  String? _serviceName;
  int? _serviceId;

  String? get serviceName => _serviceName;
  int? get serviceId => _serviceId;

  ServiceList({
      String? serviceName, 
      int? serviceId}){
    _serviceName = serviceName;
    _serviceId = serviceId;
}

  ServiceList.fromJson(dynamic json) {
    _serviceName = json["ServiceName"];
    _serviceId = json["ServiceId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ServiceName"] = _serviceName;
    map["ServiceId"] = _serviceId;
    return map;
  }

}