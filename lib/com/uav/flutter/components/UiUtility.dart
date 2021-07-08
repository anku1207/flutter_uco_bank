import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_v_o.dart';
import 'constants.dart';


Widget appointmentListCreate(List<AppointmentListItemVO> list) {
  return list.isNotEmpty
      ? ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Text(list[position].serviceName!),
                      onLongPress: () => showToastLongTime(
                          context, list[position].serviceName!))
                ],
              ),
            );
          })
      : Center(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "No Appointment Found",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: UavPrimaryColor),
                  ),
                ),
              ),
            ),
          ),
        );
}

void showResponseDialogCbsl(BuildContext context,
    Map<String, dynamic> designMap, Function customCallBack) {
  showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => true,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(3.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: designMap["H_BACKGROUND_COLOR"],
                              //border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Icon(
                            designMap["H_ICON"],
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              designMap["TITLE"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              designMap["MESSAGE"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: UavSecondaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => customCallBack("click"),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(designMap["BTN_TEXT"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          designMap["BTN_COLOR"]),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color:
                                                designMap["BTN_BORDER_COLOR"],
                                            width: 1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      });
}

Future<String>? showAlertDialog({required BuildContext context,String? title,required String message ,required String btnNameOk ,required String btnNameCancel}) async {
 return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title==null?"":title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, btnNameCancel),
                child: Text(btnNameCancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, btnNameOk),
                child:  Text(btnNameOk),
              ),
            ],
          ));
}
