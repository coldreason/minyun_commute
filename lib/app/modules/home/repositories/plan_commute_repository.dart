import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/providers/fb_plan_provider.dart';

class PlanCommuteRepository {
  final FbPlanProvider fbPlanProvider;

  PlanCommuteRepository( {required this.fbPlanProvider})
      : assert(fbPlanProvider != null);

  Future<void> setPlans(String id,DateTime date,Map<String,FbPlan> plans) => fbPlanProvider.setPlan(id, date, plans);

  Future<Map<String,FbPlan>> getPlans(String id,DateTime month)=> fbPlanProvider.getFbPlanByIdMonth(id, month);

  Future<void> deletePlan(String id,DateTime date) => fbPlanProvider.deletePlan(id,date);

}