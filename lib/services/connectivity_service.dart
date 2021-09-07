import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService instance = ConnectivityService._();
  late Connectivity connectivity;
  bool status = false;

  ConnectivityService._(){
    connectivity = Connectivity();
  }




  Future<bool> get isConnected async {
    final ConnectivityResult connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return status = false;
    }
    return status = true;
  }
}
