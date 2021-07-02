import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchbottomSheet extends StatelessWidget {
  const SearchbottomSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            color: Colors.white,
            /*child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              itemCount: 2,
            ),*/
            child: ListView(
              controller: scrollController,
              children:<Widget> [
                Text("sdfsfs"),
                SizedBox(
                  height: 300,
                ),
                Text("sdfsfs"),
                SizedBox(
                  height: 30,
                ),
                Text("sdfsfs"),
                SizedBox(
                  height: 30,
                ),
                Text("sdfsfs"),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        },
    );
  }
}
