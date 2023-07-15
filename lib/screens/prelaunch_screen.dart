import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisper_web/constants/custom_string.dart';
import 'package:wisper_web/utils/local_cache.dart';

import '../components/generic_dialog.dart';
import '../enum.dart';
import '../responsive/desktop_scaffold.dart';
import '../responsive/mobile_scaffold.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/tablet_scaffold.dart';

class PrelaunchScreen extends ConsumerStatefulWidget {
  const PrelaunchScreen({super.key});

  @override
  ConsumerState<PrelaunchScreen> createState() => _PrelaunchScreenState();
}

class _PrelaunchScreenState extends ConsumerState<PrelaunchScreen> {
  String testing = "1";
  String new_testing = "2";
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  StreamSubscription<Map<String, dynamic>>? _streamSubscription;

  static const imageURL =
      'https://raw.githubusercontent.com/RodrigoSMarques/flutter_branch_sdk/master/assets/branch_logo_qrcode.jpeg';

  void listenDynamicLinks() async {
    testing = "starting ...........";
    setState(() {});
    streamSubscription = FlutterBranchSdk.initSession().listen(
      (data) {
        testing = data.toString();
        testing = "next 123...........";
        setState(() {});
        print('listenDynamicLinks - DeepLink Data: $data');
        GenericDialog().showSimplePopup(
          context: context,
          type: InfoBoxType.error,
          content: 'Link clicked: This is it - , key is 1',
        );
        controllerData.sink.add((data.toString()));
        print(data);
        GenericDialog().showSimplePopup(
          context: context,
          type: InfoBoxType.error,
          content: '$data data',
        );

        if (data.containsKey('+clicked_branch_link') &&
            data['+clicked_branch_link'] == true) {
          print(
              '------------------------------------Link clicked----------------------------------------------');
          print('Custom string: ${data['title']}');
          print('Custom number: ${data['key']}');
          print('Custom bool: ${data['custom_bool']}');
          print('Custom list number: ${data['custom_list_number']}');
          print(
              '------------------------------------------------------------------------------------------------');

          var result = int.parse(data['key']);
          var destinationId = data['destinationId'];
          var destinationName = data['destinationName'];
          var destinationImage = data['destinationImage'];
          LocalCache.saveToLocalCache(
              key: ConstantString.destinationId, value: destinationId);
          LocalCache.saveToLocalCache(
              key: ConstantString.destinationName, value: destinationName);
          LocalCache.saveToLocalCache(
              key: ConstantString.destinationImage, value: destinationImage);

          if (result == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponsiveLayout(
                      desktopScaffold: DesktopSendMessageScreen(
                          destinationId: destinationId,
                          destinationName: destinationName,
                          destinationImage: destinationImage),
                      mobileScaffold: MobileSendMessageScreen(
                        destinationId: destinationId,
                        destinationName: destinationName,
                        destinationImage: destinationImage,
                      ),
                      tabletScaffold: TabletSendMessageScreen(
                        destinationId: destinationId,
                        destinationName: destinationName,
                        destinationImage: destinationImage,
                      )),
                ));
          }
        } else {
          var destinationId = LocalCache.getFromLocalCache(
            ConstantString.destinationId,
          );
          var destinationName = LocalCache.getFromLocalCache(
            ConstantString.destinationName,
          );
          var destinationImage = LocalCache.getFromLocalCache(
            ConstantString.destinationImage,
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResponsiveLayout(
                    desktopScaffold: DesktopSendMessageScreen(
                        destinationId: destinationId.toString(),
                        destinationName: destinationName.toString(),
                        destinationImage: destinationImage.toString()),
                    mobileScaffold: MobileSendMessageScreen(
                      destinationId: destinationId.toString(),
                      destinationName: destinationName.toString(),
                      destinationImage: destinationImage.toString(),
                    ),
                    tabletScaffold: TabletSendMessageScreen(
                      destinationId: destinationId.toString(),
                      destinationName: destinationName.toString(),
                      destinationImage: destinationImage.toString(),
                    )),
              ));
        }
      },
      // onDone: () {
      //   testing = " THis is error donee}";
      //   setState(() {});
      // }, onError: (error) {
      //   print('InitSesseion error: ${error.toString()}');
      //   testing = " THis is error${error.toString()}";
      //   setState(() {});
      // }
    );
  }

  void _initializeBranchSession() async {
    testing = "starting ...........";
    setState(() {});
    await Future.delayed(const Duration(seconds: 3));

    try {
      testing = "next ...........";
      setState(() {});
      _streamSubscription = FlutterBranchSdk.initSession()
          .cast<Map<String, dynamic>>()
          .listen((data) {
        testing = "next 123...........";
        setState(() {});
        if (data.containsKey('+clicked_branch_link') &&
            data['+clicked_branch_link'] == true) {
          // Link was clicked, handle custom data here
          var customTitle = data['custom_title'];
          var customKey = data['custom_key'];
          var customBool = data['custom_bool'];
          var customListNumber = data['custom_list_number'];
          var customListString = data['custom_list_string'];

          // Use the custom data as needed
          print('Custom Title: $customTitle');
          print('Custom Key: $customKey');
          print('Custom Bool: $customBool');
          print('Custom List Number: $customListNumber');
          print('Custom List String: $customListString');
          testing = "$customTitle , $customKey , $customBool";
          setState(() {});
          // return testing;
        } else {
          testing = "Didn't Work";
          // return "Didn't Work";
          setState(() {});
        }
      }, onError: (error) {
        print('Branch Session Error: ${error.toString()}');
        testing = error.toString();
        setState(() {});
      });
    } catch (e) {
      testing = e.toString();
      setState(() {});
    }
  }

  void initDeepLinkData() {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('custom_string', 'abcd')
      ..addCustomMetadata('custom_number', 12345)
      ..addCustomMetadata('custom_bool', true)
      ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
      ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
      //--optional Custom Metadata
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(
          street: 'street',
          city: 'city',
          region: 'ES',
          country: 'Brazil',
          postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        //parameter canonicalUrl
        //If your content lives both on the web and in the app, make sure you set its canonical URL
        // (i.e. the URL of this piece of content on the web) when building any BUO.
        // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
        // even if the user goes to the app instead of your website! This will help your SEO efforts.
        canonicalUrl: 'https://flutter.dev',
        title: 'Flutter Branch Plugin',
        imageUrl: imageURL,
        contentDescription: 'Flutter Branch Description',
        /*
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('custom_string', 'abc')
          ..addCustomMetadata('custom_number', 12345)
          ..addCustomMetadata('custom_bool', true)
          ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
          ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
         */
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        //parameter alias
        //Instead of our standard encoded short url, you can specify the vanity alias.
        // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
        // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
        //alias: 'https://branch.io' //define link url,
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('referring_user_id', 'user_id');

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  void generateLink(BuildContext context) async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      GenericDialog().showSimplePopup(
          type: InfoBoxType.success,
          content: response.result,
          context: context);
    } else {
      GenericDialog().showSimplePopup(
          type: InfoBoxType.error,
          content: '${response.errorCode} - ${response.errorMessage}',
          context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      listenDynamicLinks();
      // _initializeBranchSession();..........
      // _store.fetchContent(context);
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   listenDynamicLinks(context);
    //   // initDeepLinkData();

    //   // Access the BuildContext here
    //   // Example: Scaffold.of(context).showSnackBar(...);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
        ),
        // child
        // child: Column(
        //   children: [
        //     Text(testing),
        //     ElevatedButton(
        //         onPressed: () async {
        //           listenDynamicLinks();
        //           // setState(() {});
        //         },
        //         child: const Text("data2"))
        //   ],
        // ),
      ),
    );
  }
}
