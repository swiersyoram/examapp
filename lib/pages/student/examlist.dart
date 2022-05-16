import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/student/check.dart';
import 'package:flutter/material.dart';

class ExamList extends StatelessWidget {
  final user;

  const ExamList(Object this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log(user.data()["firstname"]);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome ${user.data()["firstname"]} ${user.data()["lastname"]}",
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Container(
              width: 600,
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("exam_templates")
                    .where('active', isEqualTo: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("data loading");
                  }
                  final data = snapshot.requireData;
                  // log(data.docs);
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        String id = data.docs[index].id;
                        return ListTile(
                          title: Text(
                            data.docs[index]["name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey[700]),
                          ),
                          trailing: Wrap(children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Check(data.docs[index], user),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: const Text("start"))
                          ]),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
