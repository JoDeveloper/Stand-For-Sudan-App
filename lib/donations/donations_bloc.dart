import 'package:rxdart/rxdart.dart';

import '../services/DonationsService.dart';
import 'donation_list.dart';
import 'donations.dart';

class DonationBloc {
  final _donations = BehaviorSubject<Donations>();
  final _donationsList = BehaviorSubject<List<DonationList>>();
  final _donationService = DonationsService();

  Stream<Donations> get donations => _donations.stream;
  Stream<List<DonationList>> get donationsList => _donationsList.stream;

  Function(Donations) get changeDonations => _donations.sink.add;
  Function(List<DonationList>) get changeDonationsList =>
      _donationsList.sink.add;
  dispose() {
    _donations.close();
    _donationsList.close();
  }

  DonationBloc() {
    this.loadDonations();
  }

  Future<void> loadDonations() async {
    changeDonations(await _donationService.getDonations());
    changeDonationsList(await _donationService.getDonationsList());
    print("loadDonations");
    print(_donations.value);
    print(_donationsList.value);
  }
}
