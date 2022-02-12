import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashBoard.dart';
import 'logInPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    dynamic votete="vote";
    return Scaffold(
      appBar: AppBar(
        title: Text("Select your vote",
          style: TextStyle(fontSize: width*0.06),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new, size: width*0.065),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height*0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Email:",
                  style: TextStyle(fontSize: width*0.055, fontWeight: FontWeight.w800),
                ),
                Text(auth.currentUser!.email.toString(),
                  style: TextStyle(fontSize: width*0.055, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height*0.015),
              child: Center(
                child: Text("UID :",
                  style: TextStyle(fontSize: width*0.055, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Text(auth.currentUser!.uid.toString(),
              style: TextStyle(fontSize: width*0.055, fontWeight: FontWeight.w800),
            ),
            Padding(
              padding: EdgeInsets.only(top: height*0.015),
              child: Text("Creation Time : ",
                style: TextStyle(fontSize: width*0.055, fontWeight: FontWeight.w800),
              ),
            ),
            Text(auth.currentUser!.metadata.creationTime.toString(),
              style: TextStyle(fontSize: width*0.055, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadioListTile(
              title:const Text("BJP"),
              value:"Bjp",
              groupValue: votete,
              onChanged:(val){
                setState(() {
                  votete=val;
                });
              }
          ),
          RadioListTile(
            title:const Text("APP"),
              value:"AAP",
              groupValue: voteSelection(context),
              onChanged:(val){
                setState(() {
                  votete=val;
                });
              }
          ),
          ElevatedButton(
              child: Text("DashBoard",
                style: TextStyle(fontSize: width*0.06),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));
              },
          ),
        ],
      ),
    );
  }

  Widget voteSelection(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('party').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        return candidateList(context, snapshot.data!.docs);
      },
    );
  }

  Widget candidateList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => candidateListItem(context, data)).toList(),
    );
  }

  Widget candidateListItem(BuildContext context, DocumentSnapshot data) {
    final record = VoteRecord.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => record.reference.update({'votes': record.votes + 1}),
        ),
      ),
    );
  }
}

class VoteRecord {
  final String name;
  final int votes;
  final DocumentReference reference;

  VoteRecord.fromMap(Map<String, dynamic> map, {required this.reference}): assert(map['name'] != null), assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  VoteRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data as Map<String,dynamic>, reference: snapshot.reference);

  @override
  String toString() => "VoteRecord<$name:$votes>";
}
