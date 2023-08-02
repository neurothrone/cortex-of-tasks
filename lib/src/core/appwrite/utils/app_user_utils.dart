import 'package:appwrite/models.dart';

import '../../models/app_user.dart';

extension AppUserFactory on AppUser {
  static AppUser fromAppwriteUser(User user) => AppUser(
        id: user.$id,
        email: user.email,
      );
}
