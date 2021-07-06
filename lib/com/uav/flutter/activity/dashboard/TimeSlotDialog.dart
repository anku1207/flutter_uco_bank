import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
    as DashboardAPI;
import 'package:flutter_uco_bank/com/uav/flutter/vo/services_response_v_o.dart';
import 'package:dotted_border/dotted_border.dart';

class TimeSlotDialog extends StatefulWidget {
  List<String> itemlist;
  Function customCallFunction;
  TimeSlotDialog(this.customCallFunction({String? timeSlot}),
      {Key? key, required this.itemlist})
      : super(key: key);

  @override
  _TimeSlotDialogState createState() => _TimeSlotDialogState();
}

class _TimeSlotDialogState extends State<TimeSlotDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 60) / 7 ;
    final double itemWidth = size.width / 3;



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
                initialChildSize: 1,
                minChildSize: 0.8,
                maxChildSize: 1,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            "Time Slot",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Expanded(
                            child: GridView.builder(
                          controller: controller,
                          itemCount: widget.itemlist.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            String timeSlotName = widget.itemlist[index];

                            return Card(
                              child: Material(
                                  color: Color(0x00000000),
                                  child: InkWell(
                                      onTap: () {
                                        widget.customCallFunction(
                                            timeSlot: timeSlotName);
                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                          child: DottedBorder(
                                        color: UavPrimaryColor,
                                        strokeWidth: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            timeSlotName,
                                            style: TextStyle(
                                                color: UavPrimaryColor),
                                          ),
                                        ),
                                      )))),
                            );
                          },
                        )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
