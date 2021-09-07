import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService instance = ConnectivityService._();
  late final ConnectivityResult connectivityResult;

  ConnectivityService._();

  Future init() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  bool get isConnected {
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
