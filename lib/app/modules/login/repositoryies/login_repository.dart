import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/providers/fb_user_cached_provider.dart';
import 'package:commute/app/data/providers/fb_user_provider.dart';
import 'package:commute/app/data/providers/ip_provider.dart';

class LoginRepository {
  final FbUserProvider fbUserProvider;
  final IPProvider ipProvider;
  final FbUserCachedProvider fbUserCachedProvider;

  LoginRepository({
    required this.fbUserProvider,
    required this.ipProvider,
    required this.fbUserCachedProvider,
  });

  Future<FbUser?> getUser(String userId) => fbUserProvider.getUser(userId);

  Future<Map<String, FbUser>> getAllUser() => fbUserProvider.getAllUser();

  Future<String?> getIp() => ipProvider.getIP();

  FbUser? getCachedUser()=> fbUserCachedProvider.getCachedUser();

  void setCachedUser(FbUser fbUser) => fbUserCachedProvider.setCachedUser(fbUser);
}
