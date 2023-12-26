import 'package:bloc/bloc.dart';
import 'package:ev_charger/screens/statiochanger.dart';

import '../screens/myaccount.dart';

enum NavigationEvents {
  StationChargerClickedEvent,
  MyAccountClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(super.initialState);

  @override
  NavigationStates get initialState => MyAccountsPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.StationChargerClickedEvent:
        yield StationCharger();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
    }
  }
}
