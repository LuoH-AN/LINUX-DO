import '../../const/app_const.dart';
import '../storage_manager.dart';

mixin Concatenated {
  String get userName =>
      StorageManager.getString(AppConst.identifier.username) ?? '';

  bool isUserEmpty() {
    return userName.isEmpty;
  }

  int get userId =>
      StorageManager.getInt(AppConst.identifier.userId) ?? -9;

  bool isUserIdEmpty() {
    return userId < 1;
  }

  String get name =>
      StorageManager.getString(AppConst.identifier.name) ?? '';

  bool isNameEmpty() {
    return name.isEmpty;
  } 
}