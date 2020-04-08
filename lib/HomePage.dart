import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donations/donations_provider.dart';
import 'model/donations.dart';

class HomePage extends StatelessWidget {
  final formatter = new NumberFormat("#,###");

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
                                    trailing:
                                        Icon(Icons.attach_money, size: 25),
                                    title: Align(
                                      child: Text("جملة التبرعات   "),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                          '   ${formatter.format(snapshot.data.total)}   ',
                                          style:
                                              TextStyle(color: Colors.green)),
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
                                        Icon(Icons.attach_money, size: 25),
                                    title: Align(
                                      child: Text("عدد التبرعات   "),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                        '${snapshot.data.todayTotalDonators}   ',
                                        style: TextStyle(color: Colors.green),
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
                                    trailing:
                                        Icon(Icons.attach_money, size: 25),
                                    title: Align(
                                      child: Text("اخر تبرع"),
                                      alignment: Alignment.topRight,
                                    ),
                                    subtitle: Align(
                                      child: Text(
                                        '${snapshot.data.lastDonation}   ',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                                child: Container(
                              margin: const EdgeInsets.only(top: 85.0),
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
                                      style: TextStyle(color: Colors.lightBlue),
                                    ),
                                    onTap: _launchURL,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      )
                    : Center(child: CircularProgressIndicator());
              }),
          // StreamBuilder<List<DonationList>>(
          //     stream: bloc.donationsList,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         for (var i = 0; i < snapshot.data.length; i++) {
          //           ListTile(
          //             title: Text(snapshot.data[i].totalAmount.toString()),
          //             subtitle: Text(snapshot.data[i].donatedAt),
          //           );
          //         }
          //       }
          //       return Center();
          //     })
        ],
      ),
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
