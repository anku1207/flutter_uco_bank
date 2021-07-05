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


class CustomerTypeDialog extends StatefulWidget {
  List<String> itemlist ;
  Function customCallFunction;
  CustomerTypeDialog(this.customCallFunction({String? customerType}), {Key? key, required this.itemlist}) : super(key: key);

  @override
  _CustomerTypeDialogState createState() => _CustomerTypeDialogState();
}

class _CustomerTypeDialogState extends State<CustomerTypeDialog> {
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
              onTap: () {
              },
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
                            "Customer Type",
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
                                String customerType = widget.itemlist[index];
                                return InkWell(
                                    onTap: () {
                                      widget.customCallFunction(customerType:customerType );
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      //80% of screen width
                                      width: MediaQuery.of(context).size.width - 50,

                                      child: Text(
                                        customerType,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
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
