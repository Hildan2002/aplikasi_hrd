import 'package:aplikasi_hrd/dashboard/constant.dart';
import 'package:aplikasi_hrd/dashboard/util/my_box.dart';
import 'package:aplikasi_hrd/dashboard/util/my_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    return Scaffold(
      backgroundColor: Color(0xFFF1f1f1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF1f1f1),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Color(0xFF22215B),
        //   ),
        // ),
        title: Text(
          'User Profile',
          style: TextStyle(
            color: Color(0xFF22215B),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              _signOut();
              },
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
                Column(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      // child: Image.asset(
                      //   'assets/images/profile.png',
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Neelesh Chaudhary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF22215B),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "UI / UX Designer",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF22215B).withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Container(
                //     width: 60,
                //     height: 30,
                //     decoration: BoxDecoration(
                //       color: Color(0xFFFF317B),
                //       borderRadius: BorderRadius.circular(7),
                //     ),
                //     child: Center(
                //       child: Text(
                //         "PRO",
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                CardFolder(
                  image: const Icon(Icons.more_time_sharp, size: 25,),
                  title: "Overtime",
                  date: "Request Overtime",
                  color: Color(0xFF415EB6),
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
                CardFolder(
                  image: const Icon(Icons.history, size: 25,),
                  // image: Image.asset("assets/icons/folder-23B0B0.png"),
                  title: "History",
                  date: "History Request",
                  color: Color(0xFF23B0B0),
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

