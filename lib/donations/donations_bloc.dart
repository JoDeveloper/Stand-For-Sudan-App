import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../model/donation_list.dart';
import '../model/donations.dart';
import '../services/DonationsService.dart';

class DonationBloc {
  final _donations = BehaviorSubject<Donations>();
  final _donationsList = BehaviorSubject<List<DonationList>>();
  final _donationService = DonationsService();

  DonationBloc() {
    Timer.periodic(Duration(seconds: 15), (Timer t) => this.loadDonations());
  }

  Stream<Donations> get donations => _donations.stream;

  Stream<List<DonationList>> get donationsList => _donationsList.stream;

  Function(Donations) get changeDonations => _donations.sink.add;

  Function(List<DonationList>) get changeDonationsList =>
      _donationsList.sink.add;

  Future<void> loadDonations() async {
    changeDonations(await _donationService.getDonations());
    changeDonationsList(await _donationService.getDonationsList());
//    print("1");
  }

  dispose() {
    _donations.close();
    _donationsList.close();
  }
}
