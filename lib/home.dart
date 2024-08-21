import 'dart:async';

import 'package:flutter/material.dart';
import 'package:measure_heart/login_screen.dart';
import 'package:measure_heart/history_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final limitCount = 100;
  final sinPoints = <FlSpot>[];
  final cosPoints = <FlSpot>[];

  double xValue = 0;
  double step = 0.05;

  late Timer timer;
  Query dbRef = FirebaseDatabase.instance
      .ref()
      .child('Data')
      .child('R6CAj4ELPGPAtUXwFeorSrBlaBx1')
      .child('Max30100_Readings')
      .limitToLast(1);

  var heartRate = '';
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Students');
  void _activateListeners() {
    dbRef.onValue.listen((event) {
      Map data = event.snapshot.value as Map;
      print(data);
      setState(() {
        heartRate = '${data.values.first['heartRate']}';
      });
    });
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      while (sinPoints.length > limitCount) {
        sinPoints.removeAt(0);
        cosPoints.removeAt(0);
      }
      setState(() {
        sinPoints.add(FlSpot(xValue, math.sin(xValue)));
        cosPoints.add(FlSpot(xValue, math.cos(xValue)));
      });
      xValue += step;
    });
    _activateListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Đo nhịp tim',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(175, 0, 0, 0),
              ),
              child: Text(
                'Tên thiết bị',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
            // ListTile(
            //   title: Text('Đăng nhập',
            //       style: GoogleFonts.poppins(color: Colors.black)),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const LoginScreen()));
            //   },
            // ),
            ListTile(
              title: Text('Lịch sử',
                  style: GoogleFonts.poppins(color: Colors.black)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryScreen()));
              },
            ),
          ]),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 15),
            Text('Biểu đồ nhịp tim',
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),
            // Text(
            //   heartRate,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: MediaQuery.of(context).size.width * 0.1,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            cosPoints.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Nhịp tim: $heartRate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   'Nhịp tim: ${xValue.toStringAsFixed(1)}',
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Text(
                      //   'x: ${sinPoints.last.y.toStringAsFixed(1)}',
                      //   style: const TextStyle(
                      //     color: Colors.red,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Text(
                      //   'x: ${cosPoints.last.y.toStringAsFixed(1)}',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: LineChart(
                            LineChartData(
                              minY: -1,
                              maxY: 1,
                              minX: sinPoints.first.x,
                              maxX: sinPoints.last.x,
                              lineTouchData: LineTouchData(enabled: false),
                              clipData: FlClipData.all(),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                sinLine(sinPoints),
                                // cosLine(cosPoints),
                              ],
                              titlesData: FlTitlesData(
                                show: false,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset(
                      'asset/image/sick.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                GestureDetector(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset('asset/image/sad.png',
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                        filterQuality: FilterQuality.high),
                  ),
                ),
                GestureDetector(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset(
                      'asset/image/confused.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    'asset/image/good.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                GestureDetector(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset(
                      'asset/image/love.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  LineChartBarData sinLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: const LinearGradient(
        colors: [Colors.red, Colors.white],
        stops: [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: false,
    );
  }

  LineChartBarData cosLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: const LinearGradient(
        colors: [Colors.black, Colors.grey],
        stops: [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: false,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class HeartRateModel {
  HeartRateModel({
    required this.date,
    required this.rate,
  });
  final String date;
  final String rate;
}
