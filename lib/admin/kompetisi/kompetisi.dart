import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:simple_icons/simple_icons.dart";

class KompetisiPage extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<KompetisiPage> {
  _launchURL() async {
    const url = 'https://www.instagram.com/wwizzyyy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen(BuildContext context) {
      return MediaQuery.of(context).size.width > 1200;
    }

    //Small screen is any screen whose width is less than 800 pixels
    bool isSmallScreen(BuildContext context) {
      return MediaQuery.of(context).size.width < 800;
    }

    //Medium screen is any screen whose width is less than 1200 pixels,
    //and more than 800 pixels
    bool isMediumScreen(BuildContext context) {
      return MediaQuery.of(context).size.width > 800 &&
          MediaQuery.of(context).size.width < 1200;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF12215C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: const Text(
          'Kompetisi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1526289034009-0240ddb68ce3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
            fit: BoxFit.cover,
          ),
        ),
        //color: CupertinoColors.black,
        padding: new EdgeInsets.all(16.0),
        child: new Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: isSmallScreen(context) ? 180 : 220,
                  height: 65,
                  child: ElevatedButton(
                      onPressed: _launchURL,
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.white),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.all(isSmallScreen(context) ? 5 : 20)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: isSmallScreen(context) ? 15 : 30,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child:
                                    Image.network("https://picsum.photos/200")),
                          ),
                          isSmallScreen(context)
                              ? SizedBox(
                                  width: 10,
                                )
                              : SizedBox.shrink(),
                          Flexible(
                            child: Column(
                              children: [
                                isSmallScreen(context)
                                    ? SizedBox(
                                        height: 3,
                                      )
                                    : SizedBox.shrink(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      "By ArenaConnect",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              isSmallScreen(context) ? 12 : 15),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Find Me On Instagram",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: isSmallScreen(context)
                                                ? 10
                                                : 12),
                                      )),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        SimpleIcons.instagram,
                                        color: Colors.blue,
                                        size: isSmallScreen(context) ? 12 : 15,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(width: 15.0),
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: isSmallScreen(context) ? 30 : 60,
                ),
                Icon(
                  Icons.stacked_line_chart_sharp,
                  color: Colors.blue,
                  size: 30,
                ),
                Text(
                  '  WELCOME TO KOMPETISI',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(color: Colors.white, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: isSmallScreen(context) ? 30 : 60,
                ),
                Expanded(
                  child: Text(
                    'COMING SOON',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.asap(
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: isSmallScreen(context) ? 30 : 60,
                ),
                Expanded(
                  child: Text(
                    'We are coming up with something big and exciting.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.asap(
                      textStyle: TextStyle(
                          fontSize: 23, color: Colors.white, letterSpacing: .5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
