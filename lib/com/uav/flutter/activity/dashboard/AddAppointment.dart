import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:intl/intl.dart';

import 'BranchDialog.dart';
import 'SearchBottomSheet.dart';

class AddAppointment extends StatefulWidget {
  final Object? argument;
  const AddAppointment({Key? key, this.argument}) : super(key: key);
  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {

  final selectDate = new TextEditingController();
  final mobileNumber = new TextEditingController();
  final emailId = new TextEditingController();


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
                                      Icons.account_balance_rounded, branchClick, null),
                                  buildSizedBox(),
                                  buildPaddingTextView("Service Selection"),
                                  buildTextFormField(
                                      context,
                                      "Select services",
                                      Icons.settings_backup_restore_rounded,
                                      serviceClick,
                                      null),
                                  buildSizedBox(),
                                  buildPaddingTextView("Customer Type"),
                                  buildTextFormField(
                                      context,
                                      "Select Customer Type",
                                      Icons.person,
                                      customerTypeClick,
                                      null),
                                  buildSizedBox(),
                                  buildPaddingTextView("Date"),
                                  buildTextFormField(context, "Select Date",
                                      Icons.calendar_today_rounded, dateClick, selectDate),
                                  buildSizedBox(),
                                  buildPaddingTextView("Time Slot"),
                                  buildTextFormField(
                                      context,
                                      "Select Time Slot",
                                      Icons.access_time_rounded,
                                      timeSlotClick,
                                      null),
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
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
       // backgroundColor: Colors.transparent,
        builder: (context) =>BranchDialog()
    );
  }

  void serviceClick() {
    showToastShortTime(context, "serviceClick");
  }

  void customerTypeClick() {
    showToastShortTime(context, "customerTypeClick");
  }

  void dateClick() {
    showDateDialog(context).then((value){
      if(value!=null){
        selectDate.text=DateFormat('dd-MM-yyyy').format(value);
      }
    });
  }

  void timeSlotClick() {
    showToastShortTime(context, "timeSlotClick");
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
      height: 10,
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
      padding: const EdgeInsets.only(top: 15, bottom: 15),
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
