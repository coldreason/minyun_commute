import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/providers/fb_user_provider.dart';
import 'package:commute/app/data/providers/ip_provider.dart';

class LoginRepository {
  final FbUserProvider fbUserProvider;
  final IPProvider ipProvider;

  LoginRepository({
    required this.fbUserProvider,
    required this.ipProvider,
  });

  Future<FbUser?> getUser(String userId) => fbUserProvider.getUser(userId);

  Future<Map<String, FbUser>> getAllUser() => fbUserProvider.getAllUser();

  Future<String?> getIp() => ipProvider.getIP();
}
