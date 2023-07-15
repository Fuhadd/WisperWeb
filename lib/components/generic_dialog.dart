import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../Constants/custom_colors.dart';
import '../enum.dart';
import '../utils/spacers.dart';
import '../widgets/custom_button.dart';

class GenericDialog {
  Future<void> showSimplePopup(
      {String? title,
      bool showTitle = true,
      String content = "",
      required InfoBoxType type,
      Widget? customIcon,
      Widget? contentBody,
      TextAlign? textAlign,
      String? okText,
      required BuildContext context,
      Function()? onOkPressed,
      Function()? onNoPressed,
      Color? footerColor}) async {
    if ((type == InfoBoxType.information || type == InfoBoxType.warning) &&
        title == null) {
      showTitle = false;
    }
    return showDialog<void>(
      barrierColor: CustomColors.blackColor.withOpacity(0.75),
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 35, bottom: 25, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customIcon ??
                        Lottie.asset(
                          getAnimationPath(type),
                          height: 80,
                          width: 80,
                          animate: true,
                          repeat: false,
                          reverse: false,
                          fit: BoxFit.contain,
                        ),
                    // SvgPicture.asset(
                    //   getNewIconPath(type),
                    //   height: 50,
                    // ),
                    verticalSpacer(15),
                    showTitle
                        ? Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                title ?? toBeginningOfSentenceCase(type.name)!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: getTypeColor(type)),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    verticalSpacer(15),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: contentBody ??
                            Text(
                              content,
                              textAlign: textAlign ?? TextAlign.center,
                              style: const TextStyle(
                                  height: 1.4,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                      ),
                    ),
                    verticalSpacer(40),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: CustomButton(
                                  // height: 38.h,
                                  color: CustomColors.whiteColor,
                                  textcolor: CustomColors.greyBgColor,
                                  borderColor: CustomColors.greyBgColor,
                                  hasBorder: true,
                                  // borderSize: 1,
                                  title: okText ?? "Okay",
                                  onTap: onOkPressed ??
                                      () {
                                        Navigator.pop(context);
                                      }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpacer(10)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
