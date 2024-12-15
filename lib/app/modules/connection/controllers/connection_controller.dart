import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:project_flutter/app/modules/boarding/views/boarding_view.dart';
import 'package:project_flutter/app/modules/connection/views/no_connection_view.dart';
class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  String? lastRoute;

  @override
  void onInit() {
    super.onInit();

    // Mendengarkan perubahan konektivitas
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      // Ambil status koneksi terakhir
      ConnectivityResult connectivityResult = result.first;
      _updateConnectionStatus(connectivityResult);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      lastRoute = Get.currentRoute;
      Get.offAll(() => const NoConnectionView());
    } else {
      if (lastRoute != null) {
        Get.offAllNamed(lastRoute!);
        lastRoute = null;
      } else {
        Get.offAll(() => const BoardingView());
      }
    }
  }
}