// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // void heartRate() async {
  //   await FirebaseFirestore.instance
  //      .ref().child('Max30100 Readings');
  // }

  Query dbRef = FirebaseDatabase.instance
      .ref()
      .child('Data')
      .child('R6CAj4ELPGPAtUXwFeorSrBlaBx1')
      .child('Max30100_Readings')
      .limitToLast(10);

  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Students');
  @override
  void initState() {
    super.initState();
    print(dbRef.path);
  }

  Widget listItem({required Map data}) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(data['epoch_time']) * 1000,
    );
    print(dateTime);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Thời gian:',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  )),
              const SizedBox(width: 10),
              Text(
                '${dateTime.hour < 10 ? 0 : ''}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ''}${dateTime.minute} - ${dateTime.day < 10 ? 0 : ''}${dateTime.day}/${dateTime.month < 10 ? 0 : ''}${dateTime.month}/${dateTime.year}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text('Nhịp tim:',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  )),
              const SizedBox(width: 10),
              Text(
                data['heartRate'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Lịch sử đo nhịp tim',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map data = snapshot.value as Map;
            data['key'] = snapshot.key;
            print(data);
            return listItem(data: data);
          },
        ),
      ),
    );
  }
}
//  Container(
//               height: 110,
//               child: Column(
//                 children: [
//                   ListTile(
//                     textColor: Colors.white,
//                     leading: Text(
//                       data['epoch_time'],
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                       ),
//                     ),
//                     title: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Nhịp tim:',
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             data['heartRate'],
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ]),
//                   ),
//                 ],
//               ),
//             );

//  Column(children: [
//           const SizedBox(height: 50),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(
//                 color: Colors.white,
//               ),
//             ),
//             child: ListTile(
//               textColor: Colors.white,
//               leading: Text(
//                 '06/05/2024',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                 ),
//               ),
//               title: Text(
//                 'Sức khỏe ............',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                 ),
//               ),
//               trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Nhịp tim:',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       '70',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//           const SizedBox(height: 15),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.white,
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: ListTile(
//               textColor: Colors.white,
//               leading: Text(
//                 '06/05/2024',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                 ),
//               ),
//               title: Text(
//                 'Sức khỏe ............',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                 ),
//               ),
//               trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Nhịp tim:',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       '79',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//         ]),