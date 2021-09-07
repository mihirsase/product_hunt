import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService instance = ConnectivityService._();
  late Connectivity _connectivity;
  bool status = false;

  ConnectivityService._(){
    _connectivity = Connectivity();
  }




  Future<bool> get isConnected async {
    final ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return status = false;
    }
    return status = true;
  }
}
