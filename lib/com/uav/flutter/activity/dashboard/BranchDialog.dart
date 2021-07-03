import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
    as DashboardAPI;
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_list_v_o.dart';

class BranchDialog extends StatefulWidget {
  const BranchDialog({Key? key}) : super(key: key);

  @override
  _BranchDialogState createState() => _BranchDialogState();
}

class _BranchDialogState extends State<BranchDialog> {
  late List<BranchListVO> itemlist =
      List.filled(0, BranchListVO(), growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<BranchResponseVO?> response = DashboardAPI.getBranch("58", "2");
    response.catchError(
      (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null && value.isError == false) {
        print(json.encode(value.branchList![0].branchName));
        setState(() {
          itemlist.addAll(value.branchList!);
        });
      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          if (EasyLoading.isShow)
            return false;
          else
            return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: itemlist.length,
              itemBuilder: (context, index) {
                BranchListVO branchListVO = itemlist[index];
                return Column(
                  children: <Widget>[
                    Center(
                      child: Text(branchListVO.branchName!),
                    )
                    // Widget to display the list of project
                  ],
                );
              },
            );
          },
        ));
  }
}
