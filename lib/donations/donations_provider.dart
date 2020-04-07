import 'donations_bloc.dart';

class DonationProvider {
  final DonationBloc _donation = DonationBloc();

  DonationProvider();

  DonationBloc get donation => _donation;
}
