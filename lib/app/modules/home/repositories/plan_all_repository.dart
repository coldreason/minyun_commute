import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/providers/fb_plan_provider.dart';

class PlanAllRepository {
  final FbPlanProvider fbPlanProvider;

  PlanAllRepository({required this.fbPlanProvider});

  Future<Map<String, List<FbPlan>>> getPlansbyMonth(DateTime month) =>
      fbPlanProvider.getPlansByMonth(month);
}
