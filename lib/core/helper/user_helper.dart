import 'package:pet_finder_app/core/constants/app_strings.dart';
import 'package:pet_finder_app/core/storage/cache_helper.dart';

class UserHelper {
  static bool isLogin() {
    return AppSharedPreferences.getString(key: AppStrings.accessToken) != null;
  }

  static bool isAgent() {
    return AppSharedPreferences.getInt(key: AppStrings.appRole) == 0;
  }
}
