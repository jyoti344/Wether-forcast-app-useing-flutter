import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Appi.dart';
import 'package:weather_app/additional_infodata.dart';
import 'package:weather_app/logic.dart';
import 'package:weather_app/wether_forcast.dart';
import 'package:http/http.dart' as http;

class Wetherscreen extends StatefulWidget {
  const Wetherscreen({super.key});
  @override
  State<Wetherscreen> createState() => Wetherscreenstate();
}

class Wetherscreenstate extends State<Wetherscreen> {
  late Future<Map<String, dynamic>> wether;

  Future<Map<String, dynamic>> wether_api() async {
    try {
      String City = "odisha";
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$City&APPID=$Wether_appi',
        ),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != "200") {
        throw "An unexpected EROR occured";
      }
      return data;
      // temp = data["list"][0]["main"]['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wether = wether_api();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wether App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                wether = wether_api();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: wether,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currenttemp = data["list"][0]["main"]['temp'];
          final currentatm = data["list"][0]["weather"][0]["main"];
          final currwindpre = data["list"][0]["main"]["pressure"];
          final curwindspeed = data["list"][0]["wind"]["speed"];
          final currhumidity = data["list"][0]["main"]["humidity"];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //maincard
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    elevation: 10,
                    color: Colors.blue,
                    shadowColor: const Color.fromARGB(255, 8, 42, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LogicWeather.kToCelsius(currenttemp),
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(LogicWeather.iconchoser(currentatm), size: 85),
                            Text(
                              currentatm.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ////////////////
                //wetherforcast
                /*
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecast(
                        icon: Icons.cloud,
                        time: "9:10",
                        value: "310.9",
                      ),
                     
                    ],
                  ),
                ),*/
                const SizedBox(height: 20),
                Text(
                  "Wether Forcast",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, i) {
                      final time = DateTime.parse(
                        data["list"][i + 1]["dt_txt"],
                      );

                      return HourlyForecast(
                        icon: LogicWeather.iconchoser(
                          data["list"][i + 1]["weather"][0]["main"],
                        ),
                        time: DateFormat.j().format(time),
                        value: LogicWeather.kToCelsius(
                          data["list"][i + 1]["main"]['temp'],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    additional_info(
                      icon: Icons.water_drop,
                      leble: "Humidity",
                      value: currhumidity.toString(),
                    ),
                    additional_info(
                      icon: Icons.air,
                      leble: "Wind speed",
                      value: curwindspeed.toString(),
                    ),
                    additional_info(
                      icon: Icons.beach_access,
                      leble: "pressure",
                      value: currwindpre.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
