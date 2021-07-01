import 'package:flutter/cupertino.dart';

/// id : "Int"
/// image : "Drawable"
/// name : "String"
/// count : "String"

class DashboardItemVO {
  int? _id;
  IconData? _image;
  String? _name;
  String? _count;

  int? get id => _id;
  IconData? get image => _image;
  String? get name => _name;
  String? get count => _count;

  DashboardItemVO({int? id, IconData? image, String? name, String? count}) {
    _id = id;
    _image = image;
    _name = name;
    _count = count;
  }

  DashboardItemVO.fromJson(dynamic json) {
    _id = json["id"];
    _image = json["image"];
    _name = json["name"];
    _count = json["count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["image"] = _image;
    map["name"] = _name;
    map["count"] = _count;
    return map..removeWhere((key, value) => value == null);
    ;
  }
}

const int ADD_APPOINTMENT = 1;
const int ALL_APPOINTMENT = 2;
const int TODAY_APPOINTMENT = 3;
const int UPCOMING_APPOINTMENT = 4;
const int CANCELLED_APPOINTMENT = 5;
const int COMPLETED_APPOINTMENT = 6;
