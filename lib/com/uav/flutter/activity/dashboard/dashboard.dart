import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/dashboard/searchbottomsheet.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/drawer_widget.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_item_v_o.dart'
    as itemVO;
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_item_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
    as DashboardAPI;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String userName = "";
  String userEmail = "";
  late List<AppointmentListItemVO> itemlist = List.filled(0, AppointmentListItemVO(), growable: true);
  List<DashboardItemVO> myList =
      List.filled(0, DashboardItemVO(), growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<DashboardResponseVO?> response = DashboardAPI.getDashboardData("58");
    response.catchError(
      (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        if (value.isError == false) {
          setState(() {
            userName = value.name!;
            userEmail = value.email!;

            if(itemlist.length>0){
              itemlist.cast();
            }
            itemlist.addAll(value.appointmentList!);

            myList.add(DashboardItemVO(
                id: itemVO.ADD_APPOINTMENT,
                name: "Add Appointment",
                image: Icons.add_circle,
                count: "0"));
            myList.add(DashboardItemVO(
                id: itemVO.ALL_APPOINTMENT,
                name: "All Appointments",
                image: Icons.add_circle,
                count: value.allAppointment.toString()));
            myList.add(DashboardItemVO(
                id: itemVO.TODAY_APPOINTMENT,
                name: "Today Appointment",
                image: Icons.add_circle,
                count: value.todayAppointment.toString()));
            myList.add(DashboardItemVO(
                id: itemVO.UPCOMING_APPOINTMENT,
                name: "Upcoming Appointments",
                image: Icons.compare_arrows_rounded,
                count: value.upcomingAppointment.toString()));
            myList.add(DashboardItemVO(
                id: itemVO.CANCELLED_APPOINTMENT,
                name: "Cancelled Appointments",
                image: Icons.clear_rounded,
                count: value.cancelledAppointment.toString()));
            myList.add(DashboardItemVO(
                id: itemVO.COMPLETED_APPOINTMENT,
                name: "Completed Appointments",
                image: Icons.check,
                count: value.completedAppointment.toString()));

          });
        } else {
          showToastShortTime(context, value.message.toString());
        }
      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight -60) / 6;
    final double itemWidth = size.width  / 2;

    return new WillPopScope(
      onWillPop: () async {
        if (EasyLoading.isShow)
          return false;
        else
          return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:  IconButton(
                  iconSize: 25,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>SearchbottomSheet()
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          drawer: DrawerWidget(userName: userName, email: userEmail , previousContext: context,),
          body: Container(
            color: UavPrimaryColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Card(
                        // margin: EdgeInsets.zero,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Appointments",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GridView.count(
                                // Create a grid with 2 columns. If you change the scrollDirection to
                                // horizontal, this produces 2 rows.
                                childAspectRatio: (itemWidth / itemHeight),
                                crossAxisCount: 2,
                                padding: EdgeInsets.all(5.0),
                                shrinkWrap: true,
                                controller: new ScrollController(keepScrollOffset: false),

                                // Generate 100 widgets that display their index in the List.
                                children: List.generate(myList.length, (index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: IconButton(
                                            iconSize: 25,
                                            onPressed:()=>clickGridIcon(myList[index].name! , myList[index].id!),
                                            icon: Icon(
                                              myList[index].image,
                                              color: IconColor,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Color(0xFFBBDEFB),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFFBBDEFB),
                                                spreadRadius: 1),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            myList[index].name!,
                                          )),
                                      Text(
                                        myList[index].count!,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            )
                          ],
                        ) //
                        ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: (
                        Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Card(
                          // margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Upcoming Appointments",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: appointmentListCreate(itemlist),
                              )
                            ],
                          ) //
                          ),
                    ))),
              ],
            ),
          )),
    );
  }

  clickGridIcon(String title, int id) {
    Navigator.pushNamed(context, UavRoutes.AppointmentListView_Screen,arguments: {"title":title,"id":id});
  }
}
