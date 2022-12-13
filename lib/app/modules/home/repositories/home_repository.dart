import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/providers/fb_commute_provider.dart';
import 'package:commute/app/data/providers/fb_plan_provider.dart';

class HomeRepository {
  final FbCommuteProvider fbCommuteProvider;
  final FbPlanProvider fbPlanProvider;

  HomeRepository({required this.fbCommuteProvider, required this.fbPlanProvider})
      : assert(fbCommuteProvider != null);

  Future<Map<String,FbCommute>> getCommutes(String id,DateTime month) => fbCommuteProvider.getCommutesByMonth(id,month);

  Future<void> setPlans(String id,DateTime month,Map<String,FbPlan> plans) => fbPlanProvider.setPlan(id, month, plans);

  Future<Map<String,FbPlan>> getPlans(String id,DateTime month)=> fbPlanProvider.getFbPlanByIdMonth(id, month);

  Future<Map<String,List<FbPlan>>> getPlansbyMonth(DateTime month)=> fbPlanProvider.getPlansByMonth(month);

  Future<void> deletePlan(String id,DateTime date) => fbPlanProvider.deletePlan(id,date);

}