import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/providers/fb_user_provider.dart';

class LoginRepository {
  final FbUserProvider fbUserProvider;

  LoginRepository({required this.fbUserProvider})
      : assert(fbUserProvider != null);

  Future<FbUser?> getUser(String userId) => fbUserProvider.getUser(userId);
  Future<Map<String,FbUser>> getAllUser() => fbUserProvider.getAllUser();
}