import 'donations_bloc.dart';

class DonationProvider {
  final DonationBloc _donation = DonationBloc();

  DonationProvider() {
    _donation.loadDonations();
  }

  DonationBloc get donation => _donation;
}
