import 'branch_list_v_o.dart';

class BranchResponseVO {
  List<BranchListVO>? _branchList;
  bool? _isError;
  String? _message;

  List<BranchListVO>? get branchList => _branchList;
  bool? get isError => _isError;
  String? get message => _message;

  BranchResponseVO({
      List<BranchListVO>? branchList,
      bool? isError, 
      String? message}){
    _branchList = branchList;
    _isError = isError;
    _message = message;
}

  BranchResponseVO.fromJson(dynamic json) {
    if (json["branchList"] != null) {
      _branchList = [];
      json["branchList"].forEach((v) {
        _branchList?.add(BranchListVO.fromJson(v));
      });
    }
    _isError = json["isError"];
    _message = json["Message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_branchList != null) {
      map["branchList"] = _branchList?.map((v) => v.toJson()).toList();
    }
    map["isError"] = _isError;
    map["Message"] = _message;
    return map;
  }

}

