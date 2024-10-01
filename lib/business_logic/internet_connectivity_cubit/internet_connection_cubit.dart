import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());
  // ignore: unused_field
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  void connected() => emit(
        ConnectedState(
          message: "Internet's Connected",
        ),
      );
  void disconnected() => emit(
        DisconnectedState(
          message: "Internet's Disconnected",
        ),
      );

  void checkInternetConnectivity() {
    _subscription = Connectivity().onConnectivityChanged.listen(
      (result) {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          connected();
        } else {
          disconnected();
        }
      },
    );
  }
}
