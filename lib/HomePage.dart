import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stand_for_sudan/model/donation_list.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donations/donations_provider.dart';
import 'model/donations.dart';

class HomePage extends StatelessWidget {
  final formatter = new NumberFormat("#,###");
  final bool scrollVisible = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DonationProvider>(context).donation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        title: Text("القوّمة للسودان"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              "images/color-t.png",
              height: 35.0,
              width: 35.0,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/standFoSudan.gif",
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          StreamBuilder<Donations>(
              stream: bloc.donations,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    trailing: Icon(
                                      Icons.local_atm,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    title: Align(
                                      child: Text("جملة التبرعات   "),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                          '   ${formatter.format(snapshot.data.total)}   ',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold)),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    trailing: Icon(
                                      Icons.monetization_on,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    title: Align(
                                      child: Text("عدد التبرعات اليوم   "),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                        '${snapshot.data.todayTotalDonators}   ',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    trailing: Icon(
                                      Icons.person_add,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    title: Align(
                                      child: Text("اخر تبرع"),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                        '${snapshot.data.lastDonation}   ',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    trailing: Icon(
                                      Icons.supervised_user_circle,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                    title: Align(
                                      child: Text("  مجموع المتبرعين   "),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                        '${formatter.format(snapshot.data.totalDonators)}   ',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center();
              }),
          Center(
            child: Container(
              margin: EdgeInsets.only(top:25.0),
              height: 50.0,
              width: 80.0,
              child: Text("آخر التبرعات",style: TextStyle(fontSize: 16.0),),
            ),
          ),
          StreamBuilder<List<DonationList>>(
            stream: bloc.donationsList,
            builder: (context, donations) {
              return (donations.hasData && donations.data != null)
                  ? CarouselSlider(
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      items: donations.data.map(
                        (donation) {
                          return Container(
//                            margin: EdgeInsets.all(5.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                          "${formatter.format(donation.donation)}" ,
                                          style: TextStyle(
                                              fontSize: 25, color: Colors.green)),
                                      Text(donation.donatedAt,style: TextStyle(fontSize: 12.0,fontFamily: GoogleFonts.arapey().fontFamily),)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          );
                        },
                      ).toList(),
                    )
                  : Center();
            },
          ),
          Center(
              child: Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Built with "),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                Text(" By"),
                InkWell(
                  child: Text(
                    "  Joseph ",
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                  onTap: _launchURL,
                ),
              ],
            ),
          )),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Freedom ", style: TextStyle(color: Colors.red)),
                Text("Peace ", style: TextStyle(color: Colors.green)),
                Text("Justice ", style: TextStyle(color: Colors.black)),
                Text("✌️"),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Colors.blue,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: [
            UnicornButton(
                hasLabel: true,
                labelText: "الرصيد",
                currentButton: FloatingActionButton(
                  backgroundColor: Colors.green,
                  mini: true,
                  child: Icon(Icons.phone_iphone),
                  onPressed: () {
                    launch("tel:" + Uri.encodeComponent('*19#'));
                  },
                )),
            UnicornButton(
                hasLabel: true,
                labelText: "تطبيقات البنوك",
                currentButton: FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                    mini: true,
                    child: Icon(Icons.monetization_on),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showAlert(context);
                        },
                      );
                    }))
          ]),
    );
  }

  AlertDialog showAlert(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text("تطبيقات البنوك"),
      ),
      content: Text("عن طريق رقم الحساب 2019"),
      actions: [
        FlatButton(
            child: Text("ظاابط"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  void _launchURL() async {
    const url = 'fb://profile/jodeveloper8';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
