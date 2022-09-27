import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  Stream<ConnectivityResult> checkConnection() async* {
    var connectivity = Connectivity().onConnectivityChanged;

    yield* connectivity;
  }
}
