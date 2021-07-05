import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/CustomerType.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/ServiceDialog.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/TimeSlotDialog.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:intl/intl.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
as DashboardAPI;
import 'BranchDialog.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/services_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/time_slot_v_o.dart';



class AddAppointment extends StatefulWidget {
  final Object? argument;
  const AddAppointment({Key? key, this.argument}) : super(key: key);
  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {

  final selectDateId = new TextEditingController();
  final selectBranchId = new TextEditingController();
  final selectServiceId = new TextEditingController();
  final customerTypeId = new TextEditingController();
  final timeSlotId = new TextEditingController();


  String? branchId;
  String? kioskId;
  String? serviceId;


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          if (EasyLoading.isShow)
            return false;
          else
            return true;
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: Text("Add Appointment"),
            ),
            body: Stack(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Form(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  buildPaddingTextView("Branch"),
                                  buildTextFormField(context, "Select Branch",
                                      Icons.account_balance_rounded,
                                      branchClick,
                                      selectBranchId),
                                  buildSizedBox(),
                                  buildPaddingTextView("Service Selection"),
                                  buildTextFormField(
                                      context,
                                      "Select services",
                                      Icons.settings_backup_restore_rounded,
                                      serviceClick,
                                      selectServiceId),
                                  buildSizedBox(),
                                  buildPaddingTextView("Customer Type"),
                                  buildTextFormField(
                                      context,
                                      "Select Customer Type",
                                      Icons.person,
                                      customerTypeClick,
                                      customerTypeId),
                                  buildSizedBox(),
                                  buildPaddingTextView("Date"),
                                  buildTextFormField(context, "Select Date",
                                      Icons.calendar_today_rounded, dateClick, selectDateId),
                                  buildSizedBox(),
                                  buildPaddingTextView("Time Slot"),
                                  buildTextFormField(
                                      context,
                                      "Select Time Slot",
                                      Icons.access_time_rounded,
                                      timeSlotClick,
                                      timeSlotId),
                                  buildSizedBox(),
                                 ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        buildExpandedButton("Submit", submitClick, UavPrimaryColor),
                        buildExpandedButton("Cancel", cancelClick, redColor),
                      ],
                    ),
                  ])),
            ])));
  }

  void branchClick() {
    //set service id and service text null set on branch text box click
    selectServiceId.text="";
    this.serviceId=null;

    Future<BranchResponseVO?> response = DashboardAPI.getBranch("58", "2");
    response.catchError(
          (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        if( value.isError == false){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              builder: (context) =>BranchDialog(callbackBankIdAndName , itemlist: value.branchList!)
          );
        }else{
          showToastShortTime(context, "Branch not found");
        }

      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });

  }

  callbackBankIdAndName({String? bankName , String? bankId }){
    selectBranchId.text=bankName!;
    branchId=bankId;
    getKioskIdbyBranch(bankId!);
  }

  void getKioskIdbyBranch(String bankId){
    Future<String?> response = DashboardAPI.getKioskIdbyBranch(bankId);
    response.catchError(
          (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        kioskId=value;
      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });
  }



  void serviceClick() {
    if(branchId != null && branchId!.isNotEmpty  ){
      Future<ServicesResponseVO?> response = DashboardAPI.getServices(branchId!);
      response.catchError(
            (onError) {
          print(onError.toString());
          showToastShortTime(context, onError.toString());
        },
      ).then((value) {
        if (value != null) {
          if( value.isError == false){
            showModalBottomSheet(
                context: context,
                //isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>ServiceDialog(callbackServiceNameAndServiceId , itemlist:value.serviceList!)
            );
          }else{
            showToastShortTime(context, value.message!);
          }
        }
      }).whenComplete(() {
        print("called when future completes");
        EasyLoading.dismiss();
      });

    }else{
      showToastShortTime(context, "No Branch Selected");
    }
  }
  callbackServiceNameAndServiceId({String? serviceName , String? serviceId }){
    selectServiceId.text=serviceName!;
    this.serviceId=serviceId;
  }


  void customerTypeClick() {
    List<String> customerTypeList=["Normal Citizen","Senior Citizen","Army Personnel"];
    showModalBottomSheet(
        context: context,
        //isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>CustomerTypeDialog(callbackCustomerTypeName , itemlist:customerTypeList)
    );
  }
  callbackCustomerTypeName({String? customerType }){
    customerTypeId.text=customerType!;
  }
  void dateClick() {
    showDateDialog(context).then((value){
      if(value!=null){
        selectDateId.text=DateFormat('dd-MM-yyyy').format(value);
      }
    });
  }

  void timeSlotClick() {
    if(branchId != null && branchId!.isNotEmpty && selectDateId.text != null && selectDateId.text.isNotEmpty ){
      Future<TimeSlotVO?> response = DashboardAPI.getSlotByBranchWise(branchId! , selectDateId.text.toString());
      response.catchError(
            (onError) {
          print(onError.toString());
          showToastShortTime(context, onError.toString());
        },
      ).then((value) {
        if (value != null) {
          if( value.isError == false){
            showModalBottomSheet(
                context: context,
                //isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>TimeSlotDialog(({String? timeSlot }){
                  this.timeSlotId.text=timeSlot!;
                }, itemlist:value.slot!)
            );
          }else{
            showToastShortTime(context, value.message!);
          }
        }
      }).whenComplete(() {
        print("called when future completes");
        EasyLoading.dismiss();
      });

    }else{
      showToastShortTime(context, "Branch and Date is required");
    }
  }


  void submitClick() {
  }



  void cancelClick() {
    Navigator.pop(context);
  }




  Expanded buildExpandedButton(
      String buttonText, Function? function, Color btnColor) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
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

  TextFormField buildTextFormField(BuildContext context, String hintText,
      IconData icon, Function tabFunction, TextEditingController? controller) {
    return TextFormField(
      onTap: () => tabFunction(),
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
    );
  }

  Padding buildPaddingTextView(String textTitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        textTitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
