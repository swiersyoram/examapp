import 'package:flutter/material.dart';
import './teacher/teacherlogin.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text("AP Exam App".toUpperCase()),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
        ),
        body: Center(
          child: Container(
              child: Column(
            children: [
              Image.asset(
                "assets/images/ap_logo.png",
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/teacherlogin');
                      },
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      child: Column(
                        children: [
                          Icon(
                            Icons.co_present,
                            size: 60,
                          ),
                          Text(
                            "Teacher",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      )),
                  SizedBox(width: 80),
                  ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 60,
                          ),
                          Text(
                            "Student",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ))
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )),
        ));
  }
}
