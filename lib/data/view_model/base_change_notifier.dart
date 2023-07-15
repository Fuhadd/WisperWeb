// import 'package:anon/data/repositories/community_repo.dart';
import 'package:flutter/foundation.dart';
import '../../components/app_logger.dart';

class BaseChangeNotifier extends ChangeNotifier {
  BaseChangeNotifier();

  // ignore: prefer_final_fields
  bool _loading = false;

  bool get loading => _loading;
  void log(Object? e) {
    AppLogger.log("$e");
  }
}
