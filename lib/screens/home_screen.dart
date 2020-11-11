import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_mini_project/models/pins.dart';
import 'package:home_automation_mini_project/services/http_service.dart';
import 'package:home_automation_mini_project/widgets/fan.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<Pins> pins;

  void getData() async {
    try {
      List<Pins> pinsRes = await HttpService.getPins();
      setState(() {
        pins = pinsRes;
      });
    } catch (exception) {
      print("An error has occured");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          brightness: Brightness.light,
          actions: [
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.info,
                size: 15,
                color: Colors.lightGreen,
              ),
              onPressed: () {
                showAboutDialog(
                    applicationVersion: "0.5 Beta",
                    context: context,
                    applicationIcon: FaIcon(FontAwesomeIcons.home),
                    applicationName: "Home Automation",
                    children: [
                      Text('Subject : IOT'),
                      Divider(color: Colors.lightGreen),
                      Text(
                          'Project Title : Home Automation using raspberry pi'),
                      Divider(color: Colors.lightGreen),
                      Text('Subject Code : 18MCA554'),
                      Divider(color: Colors.lightGreen),
                      Text('Teacher : Dwarkanath Sir'),
                      Divider(color: Colors.lightGreen),
                      Text('Saket Anand - 1BY18MCA25'),
                      Divider(color: Colors.lightGreen),
                      Text('Prathik Rakop - 1BY18MCA65'),
                      Divider(color: Colors.lightGreen),
                    ]);
              },
              color: Colors.lightGreen,
            ),
          ],
          centerTitle: true,
          elevation: 0,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Home',
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ) //,
                        ),
                    Text(
                      'Automation ',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.lightGreen,
                thickness: 2.0,
                indent: 60,
                endIndent: 60,
              ),
            ],
          ),
          backgroundColor: Colors.grey[300],
        ),
        body
        //: pins == null
         //   ? Center(
           /*     child: SpinKitWave(
                  controller: AnimationController(
                    vsync: this,
                    duration: Duration(milliseconds: 800),
                  ),
                  color: Colors.lightGreen,
                  size: 50.0,
                ),
              )
            : */
            : GridView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                ),
                children: pins.map((e) => Fan(e.color, e.state, e.id)).toList(),
                // [Fan("Test Fan", false)]
                //  pins.map((pin) {
                //   return Lamp(pin.color, pin.state);
                // }).toList(),
              ));
    // Fan(),
    // Lamp('Kitchen'),
    // Lamp('Bathroom'),
    // Fan(),
    // Lamp('Bedroom'),
  }
}
