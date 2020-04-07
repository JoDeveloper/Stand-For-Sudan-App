import 'package:rxdart/rxdart.dart';

import '../services/DonationsService.dart';
import 'donations.dart';

class DonationBloc {
  final _donations = BehaviorSubject<Donations>();
  final _donationService = DonationsService();

  Stream<Donations> get donations => _donations.stream;

  Function(Donations) get changeDonations => _donations.sink.add;
  dispose() {
    _donations.close();
  }

  DonationBloc() {
    loadDonations();
  }

  Future<void> loadDonations() async {
    changeDonations(await _donationService.getDonations());
    print(_donations);
  }
}
