import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'CustomDialog.dart';

class GetImagePermission {
  bool granted = false;

  late Permission _permission;
  late String subHeading;

  Future<void> getPermission(context, String source) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String permission = androidInfo.version.sdkInt >= 33 ? 'photos' : 'storage';

    if (source == 'Camera') {
      _permission = Permission.camera;
      subHeading = "Camera permission is needed to take photos";
    } else {
      _permission =
          permission == 'storage' ? Permission.storage : Permission.photos;
      subHeading = "Photos permission is needed to select photos";
    }

    PermissionStatus permissionStatus = await _permission.status;
    print("Woah mama");
    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context, subHeading);
      permissionStatus = await _permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context, subHeading);

      permissionStatus = await _permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.limited) {
      permissionStatus = await _permission.request();

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      print('Woah');
      permissionStatus = await _permission.request();

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      granted = true;
      return;
    }
  }

  _showOpenAppSettingsDialog(context, String subHeading) {
    print("YES");
    return CustomDialog.show(
      context,
      'Permission needed',
      subHeading,
      'Open settings',
      openAppSettings,
    );
  }
}
