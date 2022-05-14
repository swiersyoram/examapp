import 'package:examapp/pages/teacher/examtemplates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:examapp/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final db = FirebaseFirestore.instance;
    // final ref = db.collection("cities").doc("LA").withConverter(
    //       fromFirestore: City.fromFirestore,
    //       toFirestore: (City city, _) => city.toFirestore(),
    //     );
    // ref.get().then((value) => log(value.data()!.name));

    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          ),
      body: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Teachers dashboard",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {},
                            child: Column(
                              children: [
                                FaIcon(FontAwesomeIcons.fileCircleCheck,
                                    size: 60),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Exam entries",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExamTemplates(),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                FaIcon(FontAwesomeIcons.filePen, size: 60),
                                SizedBox(height: 10),
                                Text(
                                  "Exam templates",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {},
                            child: Column(
                              children: [
                                FaIcon(FontAwesomeIcons.users, size: 60),
                                SizedBox(height: 20),
                                Text(
                                  "Users",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {},
                            child: Column(
                              children: [
                                Icon(Icons.person, size: 70),
                                Text(
                                  "Users",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
                Row()
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Text("sign out")),
            )
          ]),
    );
  }
}
