import 'package:commute/app/data/providers/fb_commute_provider.dart';
import 'package:commute/app/modules/home/controllers/commute_check_controller.dart';
import 'package:commute/app/modules/home/repositories/commute_check_repository.dart';

import 'package:get/get.dart';

class CommuteCheckBinding {
  void dependencies() {
    Get.lazyPut<CommuteCheckController>(() => CommuteCheckController(
        repository:
            CommuteCheckRepository(fbCommuteProvider: FbCommuteProvider())));
  }
}
