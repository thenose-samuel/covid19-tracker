import 'package:covid19_tracker/pages/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';
import 'package:covid19_tracker/scripts/fetcher.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //to retrieve the data from the firebase server
  //still finding a way to implement this in a more scalable manner.
  final databaseReference =
      FirebaseDatabase.instance.reference().child('meghalaya');
  Map<dynamic, dynamic> meghalaya = {};
  Map<dynamic, dynamic> data = {};
  List<String> keys = [];
  List<int> values = [];
  var fetch = Fetcher();
  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      meghalaya = snapshot.value;
      meghalaya.forEach((key, value) {
        values.add(int.parse(value));
        keys.add(key);
        data[key] = value;
      });
    });
  }

  bool _fabPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            if (!_fabPressed) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('This feature is coming soon!'),
                  duration: Duration(milliseconds: 6000),
                ),
              );
              setState(() {
                _fabPressed = true;
              });
            }
          },
          backgroundColor: Colors.deepPurple[200],
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Container(
            color: Color(0xFF121212),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'Meghalaya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                margin: EdgeInsets.fromLTRB(30, 60, 0, 0),
              ),
              Container(
                //margin: EdgeInsets.fromLTRB(50, 10, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.info_outline_rounded,color: Colors.white,),
                  onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => AboutPage() ));},
                ),
              )
            ],
          ),
          FutureBuilder(
            future: FirebaseDatabase.instance
                .reference()
                .child('meghalaya')
                .once()
                .then((DataSnapshot snapshot) {
              meghalaya = snapshot.value;
              meghalaya.forEach((key, value) {
                data[key] = value;
              });
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print('DONE');
                print(data);
                return FinalScreen(data);
              } else {
                print('Not Done');
                return LoadingScreen();
              }
            },
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30,top: 100,bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Shimmer.fromColors(child: Container(
                child: Text('----',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),),
              ), baseColor: Colors.deepOrange[100], highlightColor: Colors.deepOrange[600]),
              Container(
                child: Text('Active',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Shimmer.fromColors(child: Container(
                child: Text('----',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),),
              ), baseColor: Colors.red[100], highlightColor: Colors.red[600]),
              Container(
                child: Text('Deceased',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.red[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Shimmer.fromColors(child: Container(
                child: Text('----',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),),
              ), baseColor: Colors.green[100], highlightColor: Colors.green[600]),
              Container(
                child: Text('Recovered',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.green[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Shimmer.fromColors(child: Container(
                child: Text('----',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),),
              ), baseColor: Colors.blue[100], highlightColor: Colors.blue[600]),
              Container(
                child: Text('Total Confirmed',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.blue[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
        ],),
    );
  }
}

class FinalScreen extends StatelessWidget {
  Map<dynamic, dynamic> data;
  FinalScreen(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30,top: 100,bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text(data['Active'].toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Active',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text(data['Deceased'].toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.red[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Deceased',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.red[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text(data['Recovered'].toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.green[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Recovered',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.green[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text(data['Positive'].toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.blue[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Total Confirmed',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.blue[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
        ],),
    );
  }
}

class LoadingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30,top: 100,bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
          Container(
            child: Text('2467',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),),
          ),
          Container(
            child: Text('Active',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.deepOrange[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
          )
        ],
      ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text('2467',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.red[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Deceased',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.red[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text('1504',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.green[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Recovered',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.green[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                child: Text('2467',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.blue[300],fontFamily: 'PoppinsLight'),),
              ),
              Container(
                child: Text('Total Confirmed',style: TextStyle(fontSize:  20,fontWeight: FontWeight.w300,color: Colors.blue[300],fontFamily: 'PoppinsLight'),textAlign: TextAlign.left,),
              )
            ],
          ),
    ],),
    );
  }
}
