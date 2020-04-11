import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donations/donations_provider.dart';
import 'model/donations.dart';

class HomePage extends StatelessWidget {
  final formatter = new NumberFormat("#,###");
  bool scrollVisible = true;

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
            padding: const EdgeInsets.all(0.0),
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
                                      color: Colors.green,
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
                                    trailing:
                                        Icon(Icons.monetization_on, size: 25,
                                          color: Colors.red,),
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
                                    trailing: Icon(Icons.person_add,size: 25,
                                      color: Colors.black,),
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
                                    trailing: Icon(Icons.supervised_user_circle, size: 25,
                                      color: Colors.blue,),
                                    title: Align(
                                      child: Text("  مجموع المتبرعين   "),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                        '${snapshot.data.totalDonators}   ',
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
                            Center(
                                child: Container(
                              margin: const EdgeInsets.only(top: 60.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Developed with "),
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
                                  Text("Freedom ",
                                      style: TextStyle(color: Colors.red)),
                                  Text("Peace ",
                                      style: TextStyle(color: Colors.green)),
                                  Text("Justice ",
                                      style: TextStyle(color: Colors.black)),
                                  Text("✌️"),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Center(child: CircularProgressIndicator());
              }),

        ],
      ),
      floatingActionButton: buildBoomMenu(),
    );
  }

  BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
          child: Icon(Icons.sd_card, color: Colors.black, size: 40,),
//            child: Image.asset('images/download.png', color: Colors.white),
            title: "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"+"رصيد",
            titleColor: Colors.grey[850],
            subtitle: "\t\t\t\t\t\t\t\t"+ " التبرع لحساب القومة للسودان عبر ",
            subTitleColor: Colors.grey[850],
            backgroundColor: Colors.grey[50],
            onTap: () => launch("tel:" + Uri.encodeComponent('*19#'))
          ),
          MenuItem(
            child: Icon(Icons.atm, color: Colors.black, size: 40,),
            title: "\t\t\t\t\t\t\t\t"+"تطبيقات البنوك",
            titleColor: Colors.white,
            subtitle: "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"+" عبر رقم الحساب 2019",
            subTitleColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () => print('FOURTH CHILD'),
          ),
        ]
    );
  }

  _launchURL() async {
    const url = 'fb://profile/jodeveloper8';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
