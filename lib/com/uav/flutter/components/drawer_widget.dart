import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';

import 'constants.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key ,required this.userName , required this.email}) : super(key: key);
  var userName;
  var email;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(context),
            _buildPortfolioItem(context:context,leftIcon:Icon(Icons.add_circle, color: Colors.black,),rightIcon:Icon(Icons.arrow_right),btnName:ADD_APPOINTMENT),
            _buildDivider(),
            _buildPortfolioItem(context:context,leftIcon:Icon(Icons.power_settings_new, color: Colors.black,),rightIcon:Icon(Icons.arrow_right),btnName:LOGOUT)
          ],
        ),

    );
  }

  UserAccountsDrawerHeader _buildDrawerHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        widget.userName,
      ),
      accountEmail: Text(
        widget.email,
      ),
      currentAccountPicture: GestureDetector(
        onTap: () => showDialog(
          builder: (context) => AlertDialog(
            title: Text('Himdeve Fashion'),
            content: Text(
                'To be a designer is a kind of art work. However, to proceed further, to develop a brand and to find a marketplace for the ideas, it is sometimes a struggle. But with a firm determination, love and passion, finally, at the end, a little wish may come true… And that wish is called the Himdeve. The brand designed to be successful.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ), context: context,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(
              'https://himdeve.eu/wp-content/uploads/2019/04/logo_retina.png'),
        ),
      ),
      decoration: BoxDecoration(
          color: UavPrimaryColor

      ),
    );
  }

  ListTile _buildPortfolioItem({required BuildContext context , required Icon leftIcon , required Icon rightIcon , required String btnName}) {
    return ListTile(
      title: Text(
        '$btnName',
        style: TextStyle(color: Colors.black),
      ),
      leading: leftIcon,
      trailing: rightIcon,
      onTap: () {
        Navigator.of(context).pop();
        if(btnName==ADD_APPOINTMENT){
          showToastShortTime(context, "Add Appointment");
        }else if(btnName==LOGOUT){
          showToastShortTime(context, "Logout");
        }
      },
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.black,
    );
  }
}
