import 'package:bloc/bloc.dart';
import 'package:ev_charger/screens/map.dart';
import 'package:ev_charger/screens/statiochanger.dart';

import '../screens/myaccount.dart';

enum NavigationEvents {
  mapClickedEvent,
  StationChargerClickedEvent,
  MyAccountClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(super.initialState);

  NavigationStates get initialState => map();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.mapClickedEvent:
        yield StationCharger();
        break;
      case NavigationEvents.StationChargerClickedEvent:
        yield StationCharger();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
    }
  }
}
