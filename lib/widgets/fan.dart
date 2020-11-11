import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_automation_mini_project/services/http_service.dart';

class Fan extends StatefulWidget {
  final String fanName;
  String state;
  int id;

  Fan(this.fanName, this.state, this.id);

  @override
  _FanState createState() => _FanState();
}

class _FanState extends State<Fan> {
  bool patchSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.state = widget.state == "on" ? "off" : "on";
        setState(() {
          widget.state;
        });
        patchSuccess =
            await HttpService.updateState("${widget.id}", widget.state);
        setState(() {
          if (!patchSuccess) {
            widget.state = widget.state == "on" ? "on" : "off";
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
            border: widget.state == "off"
                ? Border.all(color: Colors.lightGreen, width: 5.0)
                : Border.all(color: Colors.grey[300]),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(4.0, 4.0),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 50, left: 0),
                child: Container(
                  child: SvgPicture.asset(
                    "assets/icons/light.svg",
                    fit: BoxFit.scaleDown,
                    color: widget.state == "off"
                        ? Colors.lightGreen
                        : Colors.grey[400],
                  ),
                ),
              ),
              Positioned(
                bottom: 28,
                left: 5,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // color: widget.state == "off"
                    //     ? Colors.lightGreen
                    //     : Colors.grey[300],
                  ),
                  child: Text(
                    widget.state == "off" ? "on" : "    ",
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        color: widget.state == "off"
                            ? Colors.lightGreen
                            : Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 10,
                child: Text(
                  widget.fanName,
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
