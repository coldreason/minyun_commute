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

  Future<Map<String,List<FbPlan>>> getPlansbyMonth(DateTime month)=> fbPlanProvider.getPlansByMonth(month);

}