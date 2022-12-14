import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/providers/fb_commute_provider.dart';

class CommuteCheckRepository {
  final FbCommuteProvider fbCommuteProvider;

  CommuteCheckRepository({required this.fbCommuteProvider});

  Future<Map<String, FbCommute>> getCommutes(String id, DateTime month) =>
      fbCommuteProvider.getCommutesByMonth(id, month);

  Future<FbCommute> setCommute(String id, DateTime date, FbCommute fbCommute) =>
      fbCommuteProvider.setCommute(id, date, fbCommute);

  Future<FbCommute> getCommute(String id, DateTime date) =>
      fbCommuteProvider.getCommuteByDate(id, date);
}
