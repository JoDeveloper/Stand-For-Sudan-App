import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'donations/donations_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'القوّمة للسودان',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.tajawal().fontFamily),
        home: Provider(
          create: (context) => new DonationProvider(),
          child: HomePage(),
        ));
  }
}
