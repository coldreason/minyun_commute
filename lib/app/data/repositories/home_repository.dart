import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/providers/fb_commute_provider.dart';
import 'package:commute/app/data/providers/fb_plan_provider.dart';

class HomeRepository {
  final FbCommuteProvider fbCommuteProvider;
  final FbPlanProvider fbPlanProvider;

  HomeRepository({required this.fbCommuteProvider, required this.fbPlanProvider})
      : assert(fbCommuteProvider != null);

  Future<Map<String,FbCommute>> getCommutes(String id,String month) => fbCommuteProvider.getCommutesByMonth(id,month);

  Future<FbCommute> setCommute(String id,Timestamp stamp,FbCommute fbCommute) => fbCommuteProvider.setCommute(id, stamp, fbCommute);

  Future<void> setPlans(String id,String month,Map<String,FbPlan> plans) => fbPlanProvider.setPlan(id, month, plans);

  Future<Map<String,FbPlan>> getPlans(String id,String month)=> fbPlanProvider.getFbPlanByIdMonth(id, month);

  Future<Map<String,List<FbPlan>>> getPlansbyMonth(String month)=> fbPlanProvider.getPlansByMonth(month);

  Future<void> deletePlan(String month,String key) => fbPlanProvider.deletePlan(month,key);

}