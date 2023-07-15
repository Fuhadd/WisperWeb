import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisper_web/utils/store_utils.dart';

import '../../Constants/custom_colors.dart';
import '../components/generic_dialog.dart';
import '../enum.dart';
import '../screens/send_message_view_model.dart';
import '../utils/spacers.dart';
import 'custom_noborder_textfield.dart';

class ConfessionSendWidget extends ConsumerStatefulWidget {
  final String destinationName;
  final String destinationId;
  final String? destinationImage;
  const ConfessionSendWidget({
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
    super.key,
  });

  // ConfessionViewModel confessionVM;
  @override
  ConsumerState<ConfessionSendWidget> createState() =>
      _ConfessionSendWidgetState();
}

class _ConfessionSendWidgetState extends ConsumerState<ConfessionSendWidget>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isAppStoreHovered = false;
  bool isPlayStoreHovered = false;
  late AnimationController _animationController;
  bool isLoading = false;
  // bool isPlayStoreHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAppStoreHoverChange(bool hovered) {
    setState(() {
      isAppStoreHovered = hovered;
    });
    if (hovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handlePlayStoreHoverChange(bool hovered) {
    setState(() {
      isPlayStoreHovered = hovered;
    });
    if (hovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final confessionVM = ref.watch(confessionProvider);
    bool isSent = ref.watch(isSentProvider);
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 40),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Experience the power of community. Download our anonymous app now!",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.mainBlueColor.withOpacity(0.8)),
                    ),
                  ),
                ),
                verticalSpacer(20),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        StoreUtils.launchAppStore();
                        // Handle the onTap event
                      },
                      onHover: _handleAppStoreHoverChange,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: isAppStoreHovered
                            ? (Matrix4.identity()..scale(1.1))
                            : Matrix4.identity(),
                        child: isAppStoreHovered
                            ? const WhiteStoreContainer(
                                title: "App",
                                logoUrl: "apple_logo_black",
                              )
                            : const BlackStoreContainer(
                                title: "App",
                                logoUrl: "apple_logo",
                              ),
                      ),
                    ),
                    horizontalSpacer(40),
                    InkWell(
                      onTap: () {
                        // Handle the onTap event
                      },
                      onHover: _handlePlayStoreHoverChange,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: isPlayStoreHovered
                            ? (Matrix4.identity()..scale(1.1))
                            : Matrix4.identity(),
                        child: isPlayStoreHovered
                            ? const WhiteStoreContainer(
                                title: "Play",
                                logoUrl: "play_store",
                              )
                            : const BlackStoreContainer(
                                title: "Play",
                                logoUrl: "play_store",
                              ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: !isSent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacer(20),
                            // const Text(
                            //   "Welcome Back,",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w300,
                            //       fontSize: 30,
                            //       color: CustomColors.blackBgColor),
                            // ),
                            const Text(
                              "Say Something To",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: CustomColors.blackBgColor),
                            ),
                            Text(
                              widget.destinationName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: CustomColors.blackBgColor
                                      .withOpacity(0.7)),
                            ),
                            verticalSpacer(60),
                            // customTextField(
                            //   'userName',
                            //   Icons.person,
                            //   null,
                            //   'User Name',
                            //   validator: FormBuilderValidators.compose(
                            //     [
                            //       FormBuilderValidators.email(
                            //           errorText: 'Provided email not valid '),
                            //       FormBuilderValidators.required(
                            //           errorText: 'Email field cannot be empty '),
                            //     ],
                            //   ),
                            // ),
                            // verticalSpacer(30),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 300),
                              child: customNoBorderTextField(
                                'message',
                                Icons.mail,
                                null,
                                'Leave A Message',
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(
                                        errorText:
                                            'Message field cannot be empty '),
                                    FormBuilderValidators.minLength(4,
                                        errorText:
                                            'A valid message should be greater than 4 characters '),
                                  ],
                                ),
                                onChanged: (message) {
                                  setState(() {
                                    ref.read(messageProvider.notifier).state =
                                        message ?? "";
                                    // widget.message = message ?? "";
                                    // print(widget.message);
                                  });
                                },
                              ),
                            ),
                            verticalSpacer(30),

                            // customTextField(
                            //   'password',
                            //   Icons.vpn_key,
                            //   Icons.remove_red_eye_outlined,
                            //   'Password',
                            //   // obscureText: passwordObscured,
                            //   // onSuffixTap: () {
                            //   //   setState(() {
                            //   //     passwordObscured = !passwordObscured;
                            //   //   });
                            //   // },
                            //   onChanged: (value) {
                            //     // setState(() {
                            //     //   password = value!;
                            //     //   print(password);
                            //     // });
                            //   },
                            //   validator: FormBuilderValidators.compose([
                            //     FormBuilderValidators.minLength(6,
                            //         errorText:
                            //             'Good passwords are greater than 6 characters'),
                            //     FormBuilderValidators.required(
                            //         errorText: 'Password field cannot be empty '),
                            //   ]),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 300,
                            height: 55,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 2000),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isSent
                                    ? CustomColors.mainBlueColor
                                    : Colors
                                        .transparent, // Blue background color when isSent is true
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 2000),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: isSent
                                        ? Colors.white
                                        : CustomColors
                                            .mainBlueColor, // White text color when isSent is true
                                  ),
                                  child: const Text(
                                    "Get Your personalized link",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //     width: 300,
                          //     height: 55,
                          //     decoration: BoxDecoration(
                          //         // color: CustomColors.mainBlueColor,
                          //         borderRadius: BorderRadius.circular(10)),
                          //     child: const Center(
                          //       child: Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           "Get Your personalized link",
                          //           style: TextStyle(
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.w700,
                          //               color: CustomColors.mainBlueColor),
                          //         ),
                          //       ),
                          //     )),
                          Visibility(
                            visible: !isSent,
                            child: GestureDetector(
                              onTap: isLoading
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();
                                      bool? validate =
                                          _formKey.currentState?.validate();
                                      print(validate);
                                      if (validate == true) {
                                        _formKey.currentState?.save();

                                        var message = _formKey.currentState
                                            ?.fields['message']?.value
                                            .toString()
                                            .trim();
                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          CollectionReference
                                              confessionFirebaseFirestore =
                                              FirebaseFirestore.instance
                                                  .collection('Confessions');
                                          final docUser =
                                              confessionFirebaseFirestore.doc();
                                          await docUser.set(
                                              {
                                                "id": docUser.id,
                                                "imageUrl": "",
                                                "userName": "anon",
                                                "title": "Send me a message",
                                                "content": message,
                                                "destinationName":
                                                    widget.destinationName,
                                                "destinationId":
                                                    widget.destinationId,
                                                "destinationImage":
                                                    widget.destinationImage,
                                                "read": 0,
                                                "createdAt": Timestamp.now(),
                                              },
                                              SetOptions(
                                                merge: true,
                                              ));

                                          setState(() {
                                            isLoading = false;
                                          });

                                          GenericDialog().showSimplePopup(
                                            type: InfoBoxType.success,
                                            content:
                                                "Your anonymous message has been sent",
                                            context: context,
                                            onOkPressed: () {
                                              Navigator.of(context).pop();
                                              ref
                                                  .read(isSentProvider.notifier)
                                                  .state = true;
                                            },
                                          );

                                          // navigationHandler.goBack();
                                        } catch (error) {
                                          GenericDialog().showSimplePopup(
                                            type: InfoBoxType.error,
                                            context: context,
                                            content: error.toString(),
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }

                                        // confessionVM.sendConfessionMessage(
                                        //     content: message!,
                                        //     // createdAt: DateTime.now(),
                                        //     ref: ref,
                                        //     context: context);
                                      }
                                    },
                              child: Container(
                                width: 80,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: CustomColors.mainBlueColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: isLoading
                                    ? const Center(
                                        child: SpinKitDoubleBounce(
                                        color: Colors.white,
                                        size: 30.0,
                                      ))
                                    : const Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isSent
                          ? GestureDetector(
                              onTap: () {
                                ref.read(isSentProvider.notifier).state = false;
                                ref.read(messageProvider.notifier).state = "";
                                _formKey.currentState?.fields['message']
                                    ?.reset();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 100.0, left: 20),
                                child: SizedBox(
                                  width: 300,
                                  height: 55,
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .transparent, // Blue background color when isSent is true
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const AnimatedDefaultTextStyle(
                                      duration: Duration(milliseconds: 2000),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: CustomColors.mainBlueColor,
                                          decoration: TextDecoration.underline),
                                      child: Text(
                                        "Send another message",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlackStoreContainer extends StatelessWidget {
  const BlackStoreContainer({
    super.key,
    required this.logoUrl,
    required this.title,
  });
  final String title;
  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => StoreUtils.launchAppStore(),
      child: Container(
        height: 50,
        width: 165,
        decoration: BoxDecoration(
            color: CustomColors.blackColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            horizontalSpacer(5),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(
                          0, 2), // Adjust the values for shadow position
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage("assets/images/$logoUrl.png"),
                      fit: BoxFit.cover)),
            ),
            horizontalSpacer(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Download on the",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.whiteColor.withOpacity(0.7)),
                ),
                Text(
                  "$title Store",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.whiteColor),
                ),
              ],
            ),
            horizontalSpacer(5),
          ],
        ),
      ),
    );
  }
}

class WhiteStoreContainer extends StatelessWidget {
  const WhiteStoreContainer({
    super.key,
    required this.logoUrl,
    required this.title,
  });
  final String title;
  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => StoreUtils.launchAppStore(),
      child: Container(
        height: 50,
        width: 165,
        decoration: BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            horizontalSpacer(5),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(
                          0, 2), // Adjust the values for shadow position
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage("assets/images/$logoUrl.png"),
                      fit: BoxFit.cover)),
            ),
            horizontalSpacer(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Download on the",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.blackColor.withOpacity(0.7)),
                ),
                Text(
                  "$title Store",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.blackColor),
                ),
              ],
            ),
            horizontalSpacer(5),
          ],
        ),
      ),
    );
  }
}
