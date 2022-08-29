import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi_hrd/request/overtime_form.dart';
import 'package:aplikasi_hrd/request/overtime_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
    }
    final user = FirebaseAuth.instance.currentUser!;
    final Stream<QuerySnapshot> _message = FirebaseFirestore.instance.collection('overtime').where('stepid', isEqualTo: user.email).snapshots();

    return Scaffold(
      backgroundColor: Color(0xFFF1f1f1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF1f1f1),
        title: Text(
          'User Profile',
          style: TextStyle(
            color: Color(0xFF22215B),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              _signOut();},
            icon: Icon(
              Icons.logout,
              color: Color(0xFF22215B),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if(snapshot.hasError){
                      return Text('Error : ${snapshot.error}');
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Text('loading');
                    }
                    return Column(
                      children: [
                        // Container(
                        //   width: 75,
                        //   height: 75,
                        // ),
                        SizedBox(height: 15),
                        Text(
                          snapshot.data!['nama'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF22215B),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          snapshot.data!['department'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 15),
                        StreamBuilder<QuerySnapshot>(
                          stream: _message,
                          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            
                            return Text(
                              "Anda mendapatkan request overtime sebanyak ${streamSnapshot.data?.docs.length}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF22215B).withOpacity(0.6),
                                fontSize: 16,
                              ),
                            );
                          }
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.asset("assets/icons/plus.png"),
                      // Image.asset("assets/icons/setting.png"),
                      // Image.asset("assets/icons/panah-kanan-2.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RequestOvertime())
                    );
                  },
                  child: CardFolder(
                    image: const Icon(Icons.more_time_sharp, size: 25,),
                    title: "Overtime",
                    date: "Request Overtime",
                    color: Color(0xFF415EB6),
                  ),
                ),
                CardFolder(
                  image: const Icon(Icons.card_travel, size: 25,),
                  title: "Off Work",
                  date: "Tombol Form Cuti",
                  color: Color(0xFFFFB110),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardFolder(
                  image: const Icon(Icons.inventory),
                  title: "Inventaris",
                  date: "Request Inventaris",
                  color: Color(0xFFAC4040),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OvertimeView())
                    );
                  },
                  child: CardFolder(
                    image: const Icon(Icons.inbox, size: 25,),
                    // image: Image.asset("assets/icons/folder-23B0B0.png"),
                    title: "Inbox",
                    date: "Inbox Request",
                    color: Color(0xFF23B0B0),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Image.asset("assets/icons/sort.png"),
              ],
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              // child: Image.asset(
              //   "assets/icons/word.png",
              //   fit: BoxFit.cover,
              // ),
            ),
            title: Text("Projects.docx"),
            subtitle: Text("Novemaber 22.2020"),
            trailing: Text("300kb"),
          ),
        ],
      ),
    );
  }
}

class CardFolder extends StatelessWidget {
  CardFolder({
    Key? key,
    required this.title,
    required this.date,
    required this.color,
    required this.image,
  }) : super(key: key);

  final String title;
  final String date;
  final Color color;
  final Icon image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: Get.width * 0.4,
      height: 120,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
    //   Scaffold(
    //   backgroundColor: defaultBackgroundColor,
    //   appBar: myAppBar,
    //   drawer: myDrawer,
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         // first 4 boxes in grid
    //         AspectRatio(
    //           aspectRatio: 1,
    //           child: SizedBox(
    //             width: double.infinity,
    //             child: GridView.builder(
    //               itemCount: 4,
    //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 return MyBox();
    //               },
    //             ),
    //           ),
    //         ),
    //
    //         // list of previous days
    //         Expanded(
    //           child: ListView.builder(
    //             itemCount: 4,
    //             itemBuilder: (context, index) {
    //               return const MyTile();
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

