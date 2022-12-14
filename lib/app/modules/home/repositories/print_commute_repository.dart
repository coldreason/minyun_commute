import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/providers/fb_commute_provider.dart';

class PrintCommuteRepository {
  final FbCommuteProvider fbCommuteProvider;

  PrintCommuteRepository({required this.fbCommuteProvider});

  Future<Map<String, FbCommute>> getCommutes(String id, DateTime month) =>
      fbCommuteProvider.getCommutesByMonth(id, month);
}
