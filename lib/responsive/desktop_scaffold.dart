import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:wisper_web/screens/send_message_view_model.dart';

import '../constants/custom_colors.dart';
import '../utils/spacers.dart';
import '../widgets/confession_send_widget.dart';

class DesktopSendMessageScreen extends ConsumerStatefulWidget {
  final String destinationName;
  final String destinationId;
  final String destinationImage;
  const DesktopSendMessageScreen({
    super.key,
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
  });

  @override
  ConsumerState<DesktopSendMessageScreen> createState() =>
      _DesktopSendMessageScreenState();
}

class _DesktopSendMessageScreenState
    extends ConsumerState<DesktopSendMessageScreen> {
  // bool isSent = false;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    String message = ref.watch(messageProvider);
    bool isSent = ref.watch(isSentProvider);

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
      body: Row(
        children: [
          //Shadow Widget
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/doodles.png"),
                    fit: BoxFit.cover,
                    opacity: 0.04),
                color: const Color(0xFF1059C6).withOpacity(0.1),
              ),
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

                  /////
                  ///

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return RotationTransition(
                                turns: animation,
                                child: child,
                              );
                            },
                            child: Container(
                              key: ValueKey<bool>(isSent),
                              constraints: BoxConstraints(
                                minHeight: screenHeight / 2.5, // Minimum height
                                maxHeight: screenHeight / 1.5, // Maximum height
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
                                                  image: NetworkImage(
                                                      widget.destinationImage),
                                                  // "assets/images/anon_icon.png"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        // Container(
                                        //   height: 45,
                                        //   width: 45,
                                        //   decoration: const BoxDecoration(
                                        //       shape: BoxShape.circle,
                                        //       color:
                                        //           CustomColors.mainBlueColor),
                                        //   child: const Icon(
                                        //       Icons.person_2_outlined),
                                        // ),
                                        verticalSpacer(10),
                                        Text(
                                          widget.destinationName,
                                          style: TextStyle(
                                              fontSize: 11,
                                              // fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade500),
                                        ),
                                        verticalSpacer(15),
                                        const Text(
                                          "Send me an anonymous message",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        verticalSpacer(15),
                                        Expanded(
                                          child: Center(
                                            child: SingleChildScrollView(
                                              reverse: true,
                                              child: Center(
                                                child: Text(
                                                  message,
                                                  textAlign: TextAlign.center,
                                                  // maxLines: 3,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3),
                                                ),
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
                                                        BorderRadius.circular(
                                                            10),
                                                    color: CustomColors
                                                        .mainBlueColor
                                                        .withOpacity(0.6)),
                                                child: const Center(
                                                  child: Icon(
                                                    FontAwesomeIcons.star,
                                                    size: 16,
                                                    color:
                                                        CustomColors.whiteColor,
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
                                                        BorderRadius.circular(
                                                            10),
                                                    color: CustomColors
                                                        .mainBlueColor
                                                        .withOpacity(0.6)),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.message,
                                                    size: 16,
                                                    color:
                                                        CustomColors.whiteColor,
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
                                                        BorderRadius.circular(
                                                            10),
                                                    color: CustomColors
                                                        .mainBlueColor
                                                        .withOpacity(0.6)),
                                                child: const Center(
                                                  child: Icon(
                                                    FontAwesomeIcons.camera,
                                                    size: 16,
                                                    color:
                                                        CustomColors.whiteColor,
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
            ),
          ),

          // Real card widget
          Expanded(
              child: ConfessionSendWidget(
            destinationId: widget.destinationId,
            destinationName: widget.destinationName,
            destinationImage: widget.destinationImage,
            // confessionVM: confessionVM,
          ))
        ],
      ),
    );
  }
}
