import 'package:commute/app/data/providers/fb_user_cached_provider.dart';

class HomeRepository {
  final FbUserCachedProvider fbUserCachedProvider;

  HomeRepository({required this.fbUserCachedProvider});


  void clearCachedUser()=> fbUserCachedProvider.clearCachedUser();

}
