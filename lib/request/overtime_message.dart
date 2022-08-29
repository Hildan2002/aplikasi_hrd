import 'dart:developer';

import 'package:aplikasi_hrd/request/overtime_approve.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class OvertimeView extends StatelessWidget {
  const OvertimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    final step = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final Stream<QuerySnapshot> _overtimeform = FirebaseFirestore.instance.collection('overtime').where('stepid', isEqualTo: user.email).snapshots();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme : ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme)
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          title: Center(
            child: Text('Message Overtime',
                textAlign: TextAlign.center),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _overtimeform,
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (streamSnapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (streamSnapshot.hasData ) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                        return Card(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(documentSnapshot['section'].toString()),
                            subtitle: Text(documentSnapshot['name_pic']),
                            trailing: Text(documentSnapshot['tanggal']),
                            onTap: (){
                              var id = documentSnapshot['idtime'];
                              Navigator.push(context
                                  ,MaterialPageRoute(builder: (context) =>  Overtimeinside(timestamp: id)));
                            },
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
