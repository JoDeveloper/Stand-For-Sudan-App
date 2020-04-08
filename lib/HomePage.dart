import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'donations/donations_provider.dart';
import 'model/donation_list.dart';
import 'model/donations.dart';

class HomePage extends StatelessWidget {
  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DonationProvider>(context).donation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.asset(
            "images/color-t.png",
            height: 25.0,
            width: 25.0,
          ),
        ),
        title: Text("القوّمة للسودان"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              "images/color-t.png",
              height: 25.0,
              width: 25.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              "images/standFoSudan.gif",
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder<Donations>(
                    stream: bloc.donations,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Column(
                              children: <Widget>[
                                Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        trailing:
                                            Icon(Icons.attach_money, size: 25),
                                        title: Align(
                                          child: Text("جملة التبرعات"),
                                          alignment: Alignment.topRight,
                                        ),
                                        subtitle: Align(
                                          child: Text(
                                              '${formatter.format(snapshot.data.total)}',
                                              style: TextStyle(
                                                  color: Colors.green)),
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
                                          child: Text("أخر تبرع"),
                                          alignment: Alignment.topRight,
                                        ),
                                        subtitle: Align(
                                          child: Text(
                                              '${snapshot.data.lastDonation}',
                                              style: TextStyle(
                                                  color: Colors.green)),
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
                                          child: Text("عدد التبرعات"),
                                          alignment: Alignment.topRight,
                                        ),
                                        subtitle: Align(
                                          child: Text(
                                            '${snapshot.data.todayTotalDonators}',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          alignment: Alignment.bottomRight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : CircularProgressIndicator();
                    }),
                Column(
                  children: <Widget>[
                    StreamBuilder<List<DonationList>>(
                        stream: bloc.donationsList,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(snapshot
                                          .data[index].totalAmount
                                          .toString()),
                                      subtitle:
                                          Text(snapshot.data[index].donatedAt),
                                    );
                                  })
                              : Center();
                        })
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
