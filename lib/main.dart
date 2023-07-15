import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisper_web/screens/prelaunch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(
        apiKey: "AIzaSyAA2ioiE_exWDzlfi2T6tmUMGRBZGx5JhI",
        authDomain: "anon-c0a35.firebaseapp.com",
        projectId: "anon-c0a35",
        storageBucket: "anon-c0a35.appspot.com",
        messagingSenderId: "94213465783",
        appId: "1:94213465783:web:5ff242b6249b2f36088f32",
        measurementId: "G-29T9SETE35"),
  );
  // FlutterBranchSdk.validateSDKIntegration();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisper Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const PrelaunchScreen(),
      // home: const ResponsiveLayout(
      //     desktopScaffold: DesktopSendMessageScreen(),
      //     mobileScaffold: MobileSendMessageScreen(),
      //     tabletScaffold: TabletSendMessageScreen()),
    );
  }
}
