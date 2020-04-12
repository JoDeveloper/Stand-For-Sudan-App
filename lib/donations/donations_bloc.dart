import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../model/donation_list.dart';
import '../model/donations.dart';
import '../services/DonationsService.dart';

enum Status { isLoading, loaded }

class DonationBloc {
  final _donations = BehaviorSubject<Donations>();
  final _status = BehaviorSubject<Status>();
  final _donationsList = BehaviorSubject<List<DonationList>>();
  final _donationService = DonationsService();

  DonationBloc() {
    Timer.periodic(Duration(seconds: 15), (Timer t) => this.loadDonations());
  }

  Stream<Donations> get donations => _donations.stream;

  Stream<Status> get status => _status.stream;

  Stream<List<DonationList>> get donationsList => _donationsList.stream;

  Function(Donations) get changeDonations => _donations.sink.add;

  Function(Status) get changeStatus => _status.sink.add;

  Function(List<DonationList>) get changeDonationsList =>
      _donationsList.sink.add;

  Future<void> loadDonations() async {
    changeStatus(Status.isLoading);
    changeDonations(await _donationService.getDonations());
    changeDonationsList(await _donationService.getDonationsList());
    changeStatus(Status.loaded);
  }

  dispose() {
    _donations.close();
    _donationsList.close();
    _status.close();
  }
}
