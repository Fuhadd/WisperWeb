import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:wisper_web/screens/send_message_view_model.dart';
import 'package:wisper_web/utils/store_utils.dart';

import '../components/generic_dialog.dart';
import '../constants/custom_colors.dart';
import '../enum.dart';
import '../utils/spacers.dart';
import '../widgets/confession_send_widget.dart';
import '../widgets/custom_noborder_textfield.dart';

class MobileSendMessageScreen extends ConsumerStatefulWidget {
  final String destinationName;
  final String destinationId;
  final String destinationImage;

  const MobileSendMessageScreen({
    super.key,
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
  });

  @override
  ConsumerState<MobileSendMessageScreen> createState() =>
      _MobileSendMessageScreenState();
}

class _MobileSendMessageScreenState
    extends ConsumerState<MobileSendMessageScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isAppStoreHovered = false;
  bool isPlayStoreHovered = false;
  late AnimationController _animationController;
  bool isLoading = false;

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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    String message = ref.watch(messageProvider);
    bool isSent = ref.watch(isSentProvider);
    final confessionVM = ref.watch(confessionProvider);

    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1059C6).withOpacity(0.1),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: 0.04,
                      child: Image.asset(
                        "assets/images/doodles.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/anon_icon.png"),
                                        fit: BoxFit.cover)),
                              ),
                              horizontalSpacer(5),
                              Container(
                                height: 60,
                                width: 120,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/wisper_text.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpacer(10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Experience the power of community. Download our anonymous app now!",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.mainBlueColor
                                      .withOpacity(0.8)),
                            ),
                          ),
                        ),
                      ),
                      verticalSpacer(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                StoreUtils.launchAppStore();
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
                            horizontalSpacer(10),
                            InkWell(
                              onTap: () {},
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
                      ),
                      verticalSpacer(10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                    turns: animation,
                                    child: child,
                                  );
                                },
                                child: Container(
                                  key: ValueKey<bool>(isSent),
                                  constraints: BoxConstraints(
                                    minHeight: screenHeight / 2.5,
                                    maxHeight: screenHeight / 1.5,
                                  ),
                                  height: screenHeight / 2.5,
                                  width: screenWidth * 0.75,
                                  decoration: BoxDecoration(
                                      color: CustomColors.whiteColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF1059C6)
                                              .withOpacity(0.25),
                                          blurRadius: 50,
                                          spreadRadius: 10,
                                          offset: const Offset(0, 40),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20),
                                    child: Visibility(
                                      visible: !isSent,
                                      replacement: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/doodles.png"),
                                              fit: BoxFit.cover,
                                              opacity: 0.1),
                                        ),
                                        child: Center(
                                          child: Lottie.asset(
                                            "assets/animations/message_sent_animation2.json",
                                            animate: true,
                                            repeat: true,
                                            reverse: false,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 28,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(widget
                                                          .destinationImage),
                                                      // "assets/images/anon_icon.png"),
                                                      fit: BoxFit.cover)),
                                            ),
                                            // Container(
                                            //   height: 25,
                                            //   width: 25,
                                            //   decoration: const BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //       color:
                                            //           CustomColors.mainBlueColor),
                                            //   child: const Icon(
                                            //     Icons.person_2_outlined,
                                            //     size: 20,
                                            //   ),
                                            // ),
                                            verticalSpacer(10),
                                            Text(
                                              widget.destinationName,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey.shade500),
                                            ),
                                            verticalSpacer(10),
                                            const Text(
                                              "Send me an anonymous message",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            verticalSpacer(15),
                                            Expanded(
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  reverse: true,
                                                  child: Center(
                                                    child:
                                                        customNoBorderTextField(
                                                      'message',
                                                      Icons.mail,
                                                      null,
                                                      'Leave A Message',
                                                      isFloating: false,
                                                      validator:
                                                          FormBuilderValidators
                                                              .compose(
                                                        [
                                                          FormBuilderValidators
                                                              .required(
                                                                  errorText:
                                                                      'Message field cannot be empty '),
                                                          FormBuilderValidators
                                                              .minLength(4,
                                                                  errorText:
                                                                      'A valid message should be greater than 4 characters '),
                                                        ],
                                                      ),
                                                      onChanged: (message) {
                                                        setState(() {
                                                          ref
                                                              .read(
                                                                  messageProvider
                                                                      .notifier)
                                                              .state = message ?? "";
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            verticalSpacer(10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: CustomColors
                                                            .mainBlueColor
                                                            .withOpacity(0.6)),
                                                    child: const Center(
                                                      child: Icon(
                                                        FontAwesomeIcons.star,
                                                        size: 12,
                                                        color: CustomColors
                                                            .whiteColor,
                                                      ),
                                                    )),
                                                horizontalSpacer(20),
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: CustomColors
                                                            .mainBlueColor
                                                            .withOpacity(0.6)),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.message,
                                                        size: 12,
                                                        color: CustomColors
                                                            .whiteColor,
                                                      ),
                                                    )),
                                                horizontalSpacer(20),
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: CustomColors
                                                            .mainBlueColor
                                                            .withOpacity(0.6)),
                                                    child: const Center(
                                                      child: Icon(
                                                        FontAwesomeIcons.camera,
                                                        size: 12,
                                                        color: CustomColors
                                                            .whiteColor,
                                                      ),
                                                    )),
                                                horizontalSpacer(20),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            verticalSpacer(30),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: isSent
                                          ? CustomColors.mainBlueColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: AnimatedDefaultTextStyle(
                                        duration:
                                            const Duration(milliseconds: 2000),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: isSent
                                              ? Colors.white
                                              : CustomColors.mainBlueColor,
                                        ),
                                        child: const Text(
                                          "Get Your personalized link",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isSent,
                                    child: GestureDetector(
                                      onTap: isLoading
                                          ? null
                                          : () async {
                                              FocusScope.of(context).unfocus();
                                              bool? validate = _formKey
                                                  .currentState
                                                  ?.validate();
                                              print(validate);
                                              if (validate == true) {
                                                _formKey.currentState?.save();

                                                var message = _formKey
                                                    .currentState
                                                    ?.fields['message']
                                                    ?.value
                                                    .toString()
                                                    .trim();

                                                try {
                                                  setState(() {
                                                    isLoading = true;
                                                  });

                                                  CollectionReference
                                                      confessionFirebaseFirestore =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Confessions');
                                                  final docUser =
                                                      confessionFirebaseFirestore
                                                          .doc();
                                                  await docUser.set(
                                                      {
                                                        "id": docUser.id,
                                                        "imageUrl": "",
                                                        "userName": "anon",
                                                        "title":
                                                            "Send me a message",
                                                        "content": message,
                                                        "destinationName": widget
                                                            .destinationName,
                                                        "destinationId": widget
                                                            .destinationId,
                                                        "destinationImage": widget
                                                            .destinationImage,
                                                        "read": 0,
                                                        "createdAt":
                                                            Timestamp.now(),
                                                      },
                                                      SetOptions(
                                                        merge: true,
                                                      ));

                                                  setState(() {
                                                    isLoading = false;
                                                  });

                                                  GenericDialog()
                                                      .showSimplePopup(
                                                    type: InfoBoxType.success,
                                                    content:
                                                        "Your anonymous message has been sent",
                                                    context: context,
                                                    onOkPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      ref
                                                          .read(isSentProvider
                                                              .notifier)
                                                          .state = true;
                                                    },
                                                  );
                                                } catch (error) {
                                                  GenericDialog()
                                                      .showSimplePopup(
                                                    type: InfoBoxType.error,
                                                    context: context,
                                                    content: error.toString(),
                                                  );
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                }
                                              }
                                            },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Container(
                                          width: 60,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: CustomColors.mainBlueColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                  ),
                                ],
                              ),
                            ),
                            isSent
                                ? GestureDetector(
                                    onTap: () {
                                      ref.read(isSentProvider.notifier).state =
                                          false;
                                      ref.read(messageProvider.notifier).state =
                                          "";
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20.0, left: 25),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: AnimatedDefaultTextStyle(
                                          duration:
                                              Duration(milliseconds: 2000),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: CustomColors.mainBlueColor,
                                              decoration:
                                                  TextDecoration.underline),
                                          child: Text(
                                            "Send another message",
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
            ],
          ),
        ),
      ),
    );
  }
}
