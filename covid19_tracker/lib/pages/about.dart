import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutPage extends StatelessWidget {
  @override
  var meghalayaSite = "http://meghalayaonline.gov.in/covid/login.htm";
  var githubSite = "https://github.com/thenose-samuel/covid19-tracker";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF121212),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'About',
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
                    margin: EdgeInsets.fromLTRB(50, 10, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Text(
                      'covid19_tracker v1.0',
                      style: TextStyle(
                          color: Colors.white38,
                          fontSize: 15,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Text(
                        'This is a small test project, but if it somehow gains more than a handful of regular users I will consider adding new features with further updates, maybe even upload it on the play store.',
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 25,
                            fontFamily: 'Poppins'),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Text(
                      'All data shown here has been taken from a site accessible from the button below.',
                      style: TextStyle(
                          color: Colors.white38,
                          fontSize: 25,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 140, top: 10, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        var urlLaunchable = await canLaunch(meghalayaSite);
                        if(urlLaunchable){
                          await launch(meghalayaSite);
                        }else{
                          print("URL can't be launched.");
                        }
                      },
                      child: Text(
                        'Source',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple[200]),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Text(
                        'Source code of this app can be found in the repo linked under, any contribution would be greatly appreciated: ',
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 15,
                            fontFamily: 'Poppins'),
                      ),),
                  Container(
                    margin: EdgeInsets.only(left: 123, top: 10, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        var urlLaunchable = await canLaunch(githubSite);
                        if(urlLaunchable){
                          await launch(githubSite);
                        }else{
                          print("URL can't be launched.");
                        }
                      },
                      child: Text(
                        'Github Repo',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple[200]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
