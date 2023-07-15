import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisper_web/data/view_model/base_change_notifier.dart';

import '../components/generic_dialog.dart';
import '../enum.dart';

final confessionProvider =
    ChangeNotifierProvider.autoDispose<ConfessionViewModel>((ref) {
  return ConfessionViewModel.initWhoAmI();
});

class ConfessionViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  ConfessionViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  ConfessionViewModel.profile()
      : _userId = "",
        _userName = "",
        _email = "",
        _password = "",
        _isloading = false;

  bool get isLoading => _isloading;
  String _email, _userId, _userName, _password = "";

  String get email => _email;
  String get password => _password;
  String get userId => _userId;

  String get userName => _userName;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  Future<void> sendConfessionMessage({
    required String content,
    DateTime? createdAt,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      CollectionReference confessionFirebaseFirestore =
          FirebaseFirestore.instance.collection('Confessions');
      final docUser = confessionFirebaseFirestore.doc();
      await docUser.set(
          {
            "id": docUser.id,
            "imageUrl": "",
            "userName": "anon",
            "title": "Send me a message",
            "content": content,
            // "createdAt": createdAt,
          },
          SetOptions(
            merge: true,
          ));

      isLoading = false;
      GenericDialog().showSimplePopup(
        type: InfoBoxType.success,
        content: "Your anonymous message has been sent",
        context: context,
        onOkPressed: () {
          Navigator.of(context).pop();
          ref.read(isSentProvider.notifier).state = true;
        },
      );

      // navigationHandler.goBack();
    } catch (error) {
      GenericDialog().showSimplePopup(
        type: InfoBoxType.error,
        context: context,
        content: error.toString(),
      );
      isLoading = false;
    }
    return;
  }
}

final messageProvider = StateProvider.autoDispose<String>((ref) => "");
final isSentProvider = StateProvider.autoDispose<bool>((ref) => false);
