import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/CustomerType.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/ServiceDialog.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/TimeSlotDialog.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Session.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/UiUtility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:intl/intl.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
as DashboardAPI;
import 'BranchDialog.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/services_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/time_slot_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Session.dart'
as customSession;
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_v_o.dart';



class SearchbottomSheet extends StatefulWidget {
  const SearchbottomSheet({Key? key}) : super(key: key);

  @override
  _SearchbottomSheetState createState() => _SearchbottomSheetState();
}

class _SearchbottomSheetState extends State<SearchbottomSheet> {

  final selectDateId = new TextEditingController();
  final selectBranchId = new TextEditingController();
  final timeSlotId = new TextEditingController();


  String? branchId;
  String? kioskId;
  String? serviceId;

  var _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;


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
                              child: ListView(
                                controller: controller,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: _formKey,
                                      autovalidateMode: _autoValidate,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 50,
                                            child:Text(
                                              "Filter",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          buildPaddingTextView("Branch"),
                                          buildTextFormField(
                                              context,
                                              "Select Branch",
                                              Icons.account_balance_rounded,
                                              branchClick,
                                              selectBranchId,
                                              "Please Select Bank"),
                                          buildSizedBox(),
                                          buildPaddingTextView("Date"),
                                          buildTextFormField(
                                              context,
                                              "Select Date",
                                              Icons.calendar_today_rounded,
                                              dateClick,
                                              selectDateId,
                                              "Please Enter Date"),
                                          buildSizedBox(),
                                          buildPaddingTextView("Time Slot"),
                                          buildTextFormField(
                                              context,
                                              "Select Time Slot",
                                              Icons.access_time_rounded,
                                              timeSlotClick,
                                              timeSlotId,
                                              "Please Select Time Slot"),
                                          buildSizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          buildExpandedButton("Search", () {
                            var isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              var outputFormat = DateFormat('yyyy/MM/dd');
                              var outputDate =outputFormat.format(StringToDate("dd-MM-yyyy", selectDateId.text));
                              String requestData =branchId! + "|" + outputDate + "|" + timeSlotId.text;
                              Navigator.pushReplacementNamed(context, UavRoutes.AppointmentListView_Screen,arguments: {"title":"Search","id":"","type":"filter","data":requestData});
                            }else {
                              setState(() => _autoValidate = AutovalidateMode.always);
                            }
                          }, buttonColor),
                        ],
                      ),
                    );
                  },
                )),
          ),
        )
    );
  }

  void branchClick() {
    //set service id and service text null set on branch text box click

    Future<BranchResponseVO?> response = DashboardAPI.getBranch("58", "2");
    response.catchError(
          (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        if (value.isError == false) {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              builder: (context) => BranchDialog(callbackBankIdAndName,
                  itemlist: value.branchList!));
        } else {
          showToastShortTime(context, "Branch not found");
        }
      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });
  }

  callbackBankIdAndName({String? bankName, String? bankId}) {
    selectBranchId.text = bankName!;
    branchId = bankId;
    getKioskIdbyBranch(bankId!);
  }

  void getKioskIdbyBranch(String bankId) {

  }

  void dateClick() {
    showDateDialog(context).then((value) {
      if (value != null) {
        selectDateId.text = DateFormat('dd-MM-yyyy').format(value);
      }
    });

  }

  void timeSlotClick() {
    showModalBottomSheet(
        context: context,
        //isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) => TimeSlotDialog(({String? timeSlot}) {
          this.timeSlotId.text = timeSlot!;
        }, itemlist: dummyList()));
  }

  List<String> dummyList(){
    var timeSlotArr = ["00", "15", "30", "45"];
    List<String> timeSlotList = List.filled(0, "", growable: true);
    for(int i=9;i<=23 ;i++ ){
      for(int j=0;j<=3 ;j++ ){
        var time = i.toString() + ":" + timeSlotArr[j];
        if (i < 10) {
          time = "0$time";
        }
        timeSlotList.add("$time"); // <-- no need to care about indexes
      }
    }
    return timeSlotList;
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

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 7,
    );
  }

  TextFormField buildTextFormField(
      BuildContext context,
      String hintText,
      IconData icon,
      Function tabFunction,
      TextEditingController? controller,
      String errorMessage) {
    return TextFormField(
        onTap: () => tabFunction(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        showCursor: false, //add this line
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: UavSecondaryColor),
            gapPadding: 5,
          ),
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          prefixText: ' ',
          contentPadding:
          new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        ),
        validator: (value) => value == "" ? errorMessage : null);
  }

  Padding buildPaddingTextView(String textTitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        textTitle,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


