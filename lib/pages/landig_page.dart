import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';

import 'home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("images/landing.jpg",
                width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.7,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("News from around the", style: TextStyle(color: Colors.black,fontSize: 27.0,fontWeight: FontWeight.bold)),
            Center(child: Text("World for you",style: TextStyle(color: Colors.black,fontSize: 27.0,fontWeight: FontWeight.bold))),

            SizedBox(height: 20.0,),

            Text("Best Time to read, take your time to", style: TextStyle(color: Colors.black45,fontSize: 18.0,fontWeight: FontWeight.w500)),
            Center(child: Text("read a little more of this world",style: TextStyle(color: Colors.black45,fontSize: 18.0,fontWeight: FontWeight.w500))),
            SizedBox(height: 40.0,),
            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
              },
              child: Container(
                width:MediaQuery.of(context).size.width/1.2,
                child: Material(
                    borderRadius: BorderRadius.circular(30),
                  elevation: 5.0,
                  child: Container(
                    width:MediaQuery.of(context).size.width/1.2,
                    padding: EdgeInsets.symmetric(vertical:15.0),
                    decoration: BoxDecoration(color:Colors.blue,borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text("Get Started",
                          style:TextStyle(
                            color:Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ),
                ),
              ),
            )
          ],)
        ),
      )
    );
  }
}
