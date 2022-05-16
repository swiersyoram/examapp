import 'package:examapp/pages/teacher/examentries.dart';
import 'package:examapp/pages/teacher/examtemplates.dart';
import 'package:examapp/pages/teacher/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                    const Text(
                      "Teachers dashboard",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: const EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ExamEntries()),
                              );
                            },
                            child: Column(
                              children: const [
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
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: const EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ExamTemplates(),
                                ),
                              );
                            },
                            child: Column(
                              children: const [
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 150),
                                padding: const EdgeInsets.all(20),
                                primary: Colors.grey[700]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Users()),
                              );
                            },
                            child: Column(
                              children: const [
                                FaIcon(FontAwesomeIcons.users, size: 60),
                                SizedBox(height: 20),
                                Text(
                                  "Students",
                                  style: TextStyle(fontSize: 25),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                Row()
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                  },
                  child: const Text("sign out")),
            )
          ]),
    );
  }
}
