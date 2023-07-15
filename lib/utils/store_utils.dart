import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

class StoreUtils {
  // static Future<void> launchAppStore() async {
  //   String url = '';
  //   if (kIsWeb) {
  //     // Handle web platform
  //     url =
  //         'https://play.google.com/store/apps/details?id=com.firstally.myinvestar'; // Add your web URL here
  //   } else {
  //     switch (Platform.operatingSystem) {
  //       case 'android':
  //         url =
  //             'https://play.google.com/store/apps/details?id=com.firstally.myinvestar';
  //         break;
  //       case 'ios':
  //         url = 'itms-apps://itunes.apple.com/app/id6446764500';
  //         break;
  //       default:
  //         url =
  //             'https://play.google.com/store/apps/details?id=com.firstally.myinvestar';
  //     }
  //   }
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(
  //       uri,
  //       mode: LaunchMode.externalApplication,
  //     );
  //   }
  // }
  static Future<void> launchAppStore() async {
    String url = '';
    if (kIsWeb) {
      String userAgent = html.window.navigator.userAgent.toLowerCase();

      if (userAgent.contains('android')) {
        url =
            'https://play.google.com/store/apps/details?id=com.firstally.myinvestar';
      } else if (userAgent.contains('iphone') || userAgent.contains('ipad')) {
        url = 'itms-apps://itunes.apple.com/app/id6446764500';
      } else {
        url =
            'https://play.google.com/store/apps/details?id=com.firstally.myinvestar';
      }
      // Handle web platform
    } else {
      switch (Platform.operatingSystem) {
        case 'android':
          url =
              'https://play.google.com/store/apps/details?id=com.firstally.myinvestar';
          break;
        case 'ios':
          url = 'itms-apps://itunes.apple.com/app/id6446764500';
          break;
        default:
          url =
              'https://play.google.com/store/apps/details?id=com.firstally.myinvestar';
      }
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
