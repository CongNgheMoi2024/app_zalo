import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'storage.dart';

const kHiveStorageKey = 'hive-storage-key';

@singleton
class HiveStorage extends KeyStorage {
  final Box box;
  HiveStorage() : box = Hive.box(KeyStorage.setting);

  String get token => box.get(KeyStorage.accessToken, defaultValue: '');
  String get otpToken => box.get(KeyStorage.otpToken, defaultValue: '');
  String get refreshToken => box.get(KeyStorage.refreshToken, defaultValue: '');
  void updateToken(String value) => box.put(KeyStorage.accessToken, value);
  void updateOTPToken(String value) => box.put(KeyStorage.otpToken, value);
  void updateRefreshToken(String value) =>
      box.put(KeyStorage.refreshToken, value);
  void clearTokenAccess() => box.delete(KeyStorage.accessToken);
  void clearRefreshToken() => box.delete(KeyStorage.refreshToken);
}
