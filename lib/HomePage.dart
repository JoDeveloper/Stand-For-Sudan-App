import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

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
        title: Text("Stand For Sudan"),
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
          Expanded(
              child: Column(
            children: <Widget>[
              StreamBuilder<dynamic>(
                  stream: bloc.donations,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    return snapshot.hasData
                        ? Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(Icons.money_off, size: 50),
                                  title: Text('Heart Shaker'),
                                  subtitle: Text('TWICE'),
                                ),
                              ],
                            ),
                          )
                        : CircularProgressIndicator();
                  }),
            ],
          ))
        ],
      ),
    );
  }

  getMoney(double money) {
    return new FlutterMoneyFormatter(
            amount: money,
            settings: MoneyFormatterSettings(
                symbol: 'SDG',
                thousandSeparator: '.',
                decimalSeparator: ',',
                symbolAndNumberSeparator: ' ',
                fractionDigits: 3,
                compactFormatType: CompactFormatType.short))
        .output
        .toString();
  }
}
