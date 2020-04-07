import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stand_for_sudan/donations/donations.dart';

import 'donations/donations_provider.dart';

class HomePage extends StatelessWidget {
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
            height: 50.0,
            width: 50.0,
          ),
        ),
        title: Text("القوّمة للسودان"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/standFoSudan.gif",
              height: 380.0,
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
                                      leading: Icon(Icons.money_off, size: 50),
                                      title: Text("Total"),
                                      subtitle: Text('${snapshot.data.total}'),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.money_off, size: 50),
                                      title: Text("Last Donation"),
                                      subtitle:
                                          Text('${snapshot.data.lastDonation}'),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.money_off, size: 50),
                                      title: Text("Today Total Donators"),
                                      subtitle: Text(
                                          '${snapshot.data.todayTotalDonators}'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : CircularProgressIndicator(
                            strokeWidth: 3.0,
                          );
                  }),
            ],
          ))
        ],
      ),
    );
  }
}
