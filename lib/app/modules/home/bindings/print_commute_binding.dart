import 'package:commute/app/data/providers/fb_commute_provider.dart';
import 'package:commute/app/modules/home/controllers/print_commute_controller.dart';

import 'package:commute/app/modules/home/repositories/print_commute_repository.dart';
import 'package:get/get.dart';

class PrintCommuteBinding {
  void dependencies() {
    Get.lazyPut<PrintCommuteController>(() => PrintCommuteController(
        repository:
            PrintCommuteRepository(fbCommuteProvider: FbCommuteProvider())));
  }
}
