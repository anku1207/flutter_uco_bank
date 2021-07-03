/// BranchId : 1
/// BranchName : "String?"

class BranchListVO {
  int? _branchId;
  String? _branchName;

  int? get branchId => _branchId;
  String? get branchName => _branchName;

  BranchListVO({
      int? branchId, 
      String? branchName}){
    _branchId = branchId;
    _branchName = branchName;
}

  BranchListVO.fromJson(dynamic json) {
    _branchId = json["BranchId"];
    _branchName = json["BranchName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["BranchId"] = _branchId;
    map["BranchName"] = _branchName;
    return map;
  }

}