import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:wisper_web/screens/send_message_view_model.dart';

import '../components/generic_dialog.dart';
import '../constants/custom_colors.dart';
import '../enum.dart';
import '../utils/spacers.dart';
import '../utils/store_utils.dart';
import '../widgets/confession_send_widget.dart';
import '../widgets/custom_noborder_textfield.dart';

class TabletSendMessageScreen extends ConsumerStatefulWidget {
  final String destinationName;
  final String destinationId;
  final String destinationImage;
  const TabletSendMessageScreen({
    super.key,
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
  });

  @override
  ConsumerState<TabletSendMessageScreen> createState() =>
      _TabletSendMessageScreenState();
}

class _TabletSendMessageScreenState
    extends ConsumerState<TabletSendMessageScreen>
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

  // bool isSent = false;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    String message = ref.watch(messageProvider);
    bool isSent = ref.watch(isSentProvider);
    final confessionVM = ref.watch(confessionProvider);

    // final confessionVM = ref.watch(confessionProvider);

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
      //       child: Container(
      //         height: 40,
      //         width: 40,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: CustomColors.blackBgColor.withOpacity(0.2),
      //           // image: DecorationImage(
      //           //     image: NetworkImage(userData.avatarUrl))
      //         ),
      //         // child: const Icon(Icons.person_2_outlined),
      //       ),
      //     ),
      //   ],
      // ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            //Shadow Widget
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // image: const DecorationImage(
                  //     image: AssetImage("assets/images/doodles.png"),

                  //     opacity: 0.04),
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
                    Column(
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
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text(
                                "Experience the power of community. Download our anonymous app now!",
                                style: TextStyle(
                                    fontSize: 19,
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
                                  StoreUtils.launchAppStore();
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
                        ),

                        /////
                        ///

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0),
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
                                      minHeight:
                                          screenHeight / 2.5, // Minimum height
                                      maxHeight:
                                          screenHeight / 1.5, // Maximum height
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
                                            // color: const Color(0xFF1059C6).withOpacity(0.1),
                                          ),
                                          // color: Colors.black,
                                          child: Center(
                                            child: Lottie.asset(
                                              "assets/animations/message_sent_animation2.json",
                                              // height: 80,
                                              // width: 80,
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
                                              //   height: 45,
                                              //   width: 45,
                                              //   decoration: const BoxDecoration(
                                              //       shape: BoxShape.circle,
                                              //       color: CustomColors
                                              //           .mainBlueColor),
                                              //   child: const Icon(
                                              //       Icons.person_2_outlined),
                                              // ),
                                              verticalSpacer(10),
                                              Text(
                                                widget.destinationName,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    // fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              verticalSpacer(15),
                                              const Text(
                                                "Send me an anonymous message",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                                    .read(messageProvider
                                                                        .notifier)
                                                                    .state =
                                                                message ?? "";
                                                            // widget.message = message ?? "";
                                                            // print(widget.message);
                                                          });
                                                        },
                                                      ),
                                                      // Text(
                                                      //   message,
                                                      //   textAlign: TextAlign.center,
                                                      //   // maxLines: 3,
                                                      //   // overflow: TextOverflow.ellipsis,
                                                      //   style: const TextStyle(
                                                      //       fontSize: 16,
                                                      //       fontWeight:
                                                      //           FontWeight.w500,
                                                      //       height: 1.3),
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // verticalSpacer(10),
                                              // Text(
                                              //   "read all features",
                                              //   style: TextStyle(
                                              //       fontSize: 11,
                                              //       // fontWeight: FontWeight.w400,
                                              //       color: Colors.grey.shade500),
                                              // ),
                                              verticalSpacer(10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // Text(
                                                  //   "I want this",
                                                  //   style: TextStyle(
                                                  //       fontSize: 12,
                                                  //       fontWeight: FontWeight.w600,
                                                  //       color: isCardActivated
                                                  //           ? Colors.greenAccent
                                                  //           : Colors.grey.shade500),
                                                  // ),
                                                  Container(
                                                      // margin:
                                                      //     const EdgeInsets.only(top: 5, bottom: 5),
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: CustomColors
                                                              .mainBlueColor
                                                              .withOpacity(
                                                                  0.6)),
                                                      child: const Center(
                                                        child: Icon(
                                                          FontAwesomeIcons.star,
                                                          size: 16,
                                                          color: CustomColors
                                                              .whiteColor,
                                                        ),
                                                        // FaIcon(
                                                        //   FontAwesomeIcons.message,
                                                        //   size: 20,
                                                        // ),
                                                      )),
                                                  horizontalSpacer(20),
                                                  Container(
                                                      // margin:
                                                      //     const EdgeInsets.only(top: 5, bottom: 5),
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: CustomColors
                                                              .mainBlueColor
                                                              .withOpacity(
                                                                  0.6)),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.message,
                                                          size: 16,
                                                          color: CustomColors
                                                              .whiteColor,
                                                        ),
                                                        // FaIcon(
                                                        //   FontAwesomeIcons.message,
                                                        //   size: 20,
                                                        // ),
                                                      )),
                                                  horizontalSpacer(20),
                                                  Container(
                                                      // margin:
                                                      //     const EdgeInsets.only(top: 5, bottom: 5),
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: CustomColors
                                                              .mainBlueColor
                                                              .withOpacity(
                                                                  0.6)),
                                                      child: const Center(
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .camera,
                                                          size: 16,
                                                          color: CustomColors
                                                              .whiteColor,
                                                        ),
                                                        // FaIcon(
                                                        //   FontAwesomeIcons.message,
                                                        //   size: 20,
                                                        // ),
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
                                padding: isSent
                                    ? const EdgeInsets.only(left: 20)
                                    : EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      height: 55,
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 2000),
                                        curve: Curves.easeInOut,
                                        decoration: BoxDecoration(
                                          color: isSent
                                              ? CustomColors.mainBlueColor
                                              : Colors
                                                  .transparent, // Blue background color when isSent is true
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                                milliseconds: 2000),
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
                                                FocusScope.of(context)
                                                    .unfocus();
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
                                                        FirebaseFirestore
                                                            .instance
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
                                                          // "createdAt": createdAt,
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

                                                    // navigationHandler.goBack();
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

                                                  // confessionVM
                                                  //     .sendConfessionMessage(
                                                  //         content: message!,
                                                  //         createdAt:
                                                  //             DateTime.now(),
                                                  //         ref: ref,
                                                  //         context: context);
                                                }
                                              },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Container(
                                            width: 80,
                                            height: 55,
                                            decoration: BoxDecoration(
                                                color:
                                                    CustomColors.mainBlueColor,
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
                                        ref
                                            .read(isSentProvider.notifier)
                                            .state = false;
                                        ref
                                            .read(messageProvider.notifier)
                                            .state = "";
                                        _formKey.currentState?.fields['message']
                                            ?.reset();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            top: 20.0, left: 25),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedDefaultTextStyle(
                                            duration:
                                                Duration(milliseconds: 2000),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    CustomColors.mainBlueColor,
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

                        ///This is the code

                        // Expanded(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        //         child: Container(
                        //           constraints: BoxConstraints(
                        //             minHeight: screenHeight / 2.5, // Minimum height
                        //             maxHeight: screenHeight / 1.5, // Maximum height
                        //           ),
                        //           height: screenHeight / 2.5,
                        //           width: screenWidth * 0.75,
                        //           decoration: BoxDecoration(
                        //               color: CustomColors.whiteColor,
                        //               borderRadius:
                        //                   const BorderRadius.all(Radius.circular(40)),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: const Color(0xFF1059C6)
                        //                       .withOpacity(0.25),
                        //                   blurRadius: 50,
                        //                   spreadRadius: 10,
                        //                   offset: const Offset(0, 40),
                        //                 )
                        //               ]),
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 20.0, vertical: 20),
                        //             child: Column(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   Container(
                        //                     height: 45,
                        //                     width: 45,
                        //                     decoration: const BoxDecoration(
                        //                         shape: BoxShape.circle,
                        //                         color: CustomColors.mainBlueColor),
                        //                     child:
                        //                         const Icon(Icons.person_2_outlined),
                        //                   ),
                        //                   verticalSpacer(10),
                        //                   Text(
                        //                     "@elvisss",
                        //                     style: TextStyle(
                        //                         fontSize: 11,
                        //                         // fontWeight: FontWeight.w400,
                        //                         color: Colors.grey.shade500),
                        //                   ),
                        //                   verticalSpacer(15),
                        //                   const Text(
                        //                     "Send me an anonymous message",
                        //                     style: TextStyle(
                        //                         fontSize: 17,
                        //                         fontWeight: FontWeight.w700),
                        //                   ),
                        //                   verticalSpacer(15),
                        //                   Expanded(
                        //                     child: Center(
                        //                       child: SingleChildScrollView(
                        //                         reverse: true,
                        //                         child: Center(
                        //                           child: Text(
                        //                             message,
                        //                             textAlign: TextAlign.center,
                        //                             // maxLines: 3,
                        //                             // overflow: TextOverflow.ellipsis,
                        //                             style: const TextStyle(
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                                 height: 1.3),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   // verticalSpacer(10),
                        //                   // Text(
                        //                   //   "read all features",
                        //                   //   style: TextStyle(
                        //                   //       fontSize: 11,
                        //                   //       // fontWeight: FontWeight.w400,
                        //                   //       color: Colors.grey.shade500),
                        //                   // ),
                        //                   verticalSpacer(10),
                        //                   Row(
                        //                     mainAxisAlignment: MainAxisAlignment.end,
                        //                     children: [
                        //                       // Text(
                        //                       //   "I want this",
                        //                       //   style: TextStyle(
                        //                       //       fontSize: 12,
                        //                       //       fontWeight: FontWeight.w600,
                        //                       //       color: isCardActivated
                        //                       //           ? Colors.greenAccent
                        //                       //           : Colors.grey.shade500),
                        //                       // ),
                        //                       Container(
                        //                           // margin:
                        //                           //     const EdgeInsets.only(top: 5, bottom: 5),
                        //                           height: 30,
                        //                           width: 30,
                        //                           decoration: BoxDecoration(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(10),
                        //                               color: CustomColors
                        //                                   .mainBlueColor
                        //                                   .withOpacity(0.6)),
                        //                           child: const Center(
                        //                             child: Icon(
                        //                               FontAwesomeIcons.star,
                        //                               size: 16,
                        //                               color: CustomColors.whiteColor,
                        //                             ),
                        //                             // FaIcon(
                        //                             //   FontAwesomeIcons.message,
                        //                             //   size: 20,
                        //                             // ),
                        //                           )),
                        //                       horizontalSpacer(20),
                        //                       Container(
                        //                           // margin:
                        //                           //     const EdgeInsets.only(top: 5, bottom: 5),
                        //                           height: 30,
                        //                           width: 30,
                        //                           decoration: BoxDecoration(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(10),
                        //                               color: CustomColors
                        //                                   .mainBlueColor
                        //                                   .withOpacity(0.6)),
                        //                           child: const Center(
                        //                             child: Icon(
                        //                               Icons.message,
                        //                               size: 16,
                        //                               color: CustomColors.whiteColor,
                        //                             ),
                        //                             // FaIcon(
                        //                             //   FontAwesomeIcons.message,
                        //                             //   size: 20,
                        //                             // ),
                        //                           )),
                        //                       horizontalSpacer(20),
                        //                       Container(
                        //                           // margin:
                        //                           //     const EdgeInsets.only(top: 5, bottom: 5),
                        //                           height: 30,
                        //                           width: 30,
                        //                           decoration: BoxDecoration(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(10),
                        //                               color: CustomColors
                        //                                   .mainBlueColor
                        //                                   .withOpacity(0.6)),
                        //                           child: const Center(
                        //                             child: Icon(
                        //                               FontAwesomeIcons.camera,
                        //                               size: 16,
                        //                               color: CustomColors.whiteColor,
                        //                             ),
                        //                             // FaIcon(
                        //                             //   FontAwesomeIcons.message,
                        //                             //   size: 20,
                        //                             // ),
                        //                           )),
                        //                       horizontalSpacer(20),
                        //                     ],
                        //                   ),
                        //                 ]),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Real card widget
            // const Expanded(
            //     child: ConfessionSendWidget(
            //         // confessionVM: confessionVM,
            //         ))
          ],
        ),
      ),
    );
  }
}
