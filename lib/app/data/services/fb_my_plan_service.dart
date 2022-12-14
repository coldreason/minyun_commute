import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/utils/functions/get_date_string.dart';
import 'package:get/get.dart';

class FbMyPlanService extends GetxService {
  Map<String, Map<String, FbPlan>> _fbPlans = {};

  void clear() {
    _fbPlans = {};
  }

  setFbPlans(DateTime month, Map<String, FbPlan> fbPlans) {
    _fbPlans[getMonthString(month)] = fbPlans;
  }

  getFbPlans(DateTime month) {
    return _fbPlans[getMonthString(month)];
  }
}
