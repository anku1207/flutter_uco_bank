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

class ServiceDialog extends StatefulWidget {
  List<ServiceList> itemlist = List.filled(0, ServiceList(), growable: true);
  Function customCallFunction;
  ServiceDialog(
      this.customCallFunction({String? serviceId, String? serviceName}),
      {Key? key,
      required this.itemlist})
      : super(key: key);

  @override
  _ServiceDialogState createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
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
                initialChildSize: 1,
                minChildSize: 0.9,
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
                            "Services",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Expanded(
                            child: ListView.builder(
                          controller: controller,
                          itemCount: widget.itemlist.length,
                          itemBuilder: (context, index) {
                            ServiceList serviceList = widget.itemlist[index];
                            return Material(
                                color: Color(0x00000000),
                                child: InkWell(
                                    onTap: () {
                                      widget.customCallFunction(
                                          serviceName: serviceList.serviceName,
                                          serviceId:
                                              serviceList.serviceId.toString());
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      //80% of screen width
                                      width: MediaQuery.of(context).size.width -
                                          50,

                                      child: Text(
                                        serviceList.serviceName!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                )
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
