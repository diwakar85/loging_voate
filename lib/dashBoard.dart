import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List parties = ['AAP', 'BJP', 'Congress', 'CP', 'SP'];
  List partyColor = [Colors.blue, Colors.deepOrange, Colors.green, Colors.red, Colors.teal];

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Live Counter",
          style: TextStyle(fontSize: width*0.065),
        ),
      ),
      body: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(parties[index],
                style: TextStyle(fontSize: width*0.065),
              ),
              tileColor: partyColor[index],
              trailing: Text("0",
                style: TextStyle(fontSize: width*0.065),
              ),
            );
          },
        separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: height*0.05);
        },),
    );
  }
}
