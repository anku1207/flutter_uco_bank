import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
    as DashboardAPI;
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_list_v_o.dart';

class BranchDialog extends StatefulWidget {
  Function customCallFunchtion;
  List<BranchListVO> itemlist = List.filled(0, BranchListVO(), growable: true);
  BranchDialog(this.customCallFunchtion({String? bankId, String? bankName}),
      {Key? key, required this.itemlist})
      : super(key: key);

  @override
  _BranchDialogState createState() => _BranchDialogState();
}

class _BranchDialogState extends State<BranchDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  maxChildSize: 0.9,
                  builder: (_, controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.remove,
                            color: Colors.grey[600],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Expanded(
                              child: ListView.builder(
                            controller: controller,
                            itemCount: widget.itemlist.length,
                            itemBuilder: (context, index) {
                              BranchListVO branchListVO =
                                  widget.itemlist[index];
                              return Material(
                                  color: Color(0x00000000),
                                  child: InkWell(
                                    onTap: () {
                                      widget.customCallFunchtion(
                                          bankName: branchListVO.branchName!,
                                          bankId:
                                              branchListVO.branchId.toString());
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                            height: 50,
                                            width: 50,
                                            child: Icon(
                                              Icons.location_on_rounded,
                                              color: Colors.grey[600],
                                            )),
                                        Container(
                                          padding: const EdgeInsets.all(16.0),
                                          //80% of screen width
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  branchListVO.branchName!,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                    "Peeragarhi\nDistance 3.2"),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          )),
                          buildExpandedButton("Close", () {
                            Navigator.pop(context);
                          }, redColor),
                        ],
                      ),
                    );
                  },
                )),
          ),
        )
    );
  }

  SizedBox buildExpandedButton(
      String buttonText, Function? function, Color btnColor) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ElevatedButton(
            onPressed: () => function!(),
            child: Text(buttonText.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                )),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(btnColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
          ),
        ));
  }
}
