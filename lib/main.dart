import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'firebase_options.dart';
import 'src/web_view_stack.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

//   firebaseAnalytics.setAnalyticsCollectionEnabled(true);
// firebaseAnalytics.setMeasurementEnabled(true, "<GA4_MEASUREMENT_ID>");

  @override
  void initState() {
    super.initState();
    firebaseAnalytics.setAnalyticsCollectionEnabled(true);
    // firebaseAnalytics.setMeasurementEnabled(true, "G-H382LDYLBZ");
    firebaseAnalytics.setAnalyticsCollectionEnabled(true);
    firebaseAnalytics.setDefaultEventParameters(
        <String, dynamic>{'stream_id': '5140560412'});
    firebaseAnalytics.setUserProperty(name: 'app-platform', value: 'app');

    controller = WebViewController()
      ..loadRequest(
        Uri.parse('http://ga-nextjs-web.s3-website.ap-south-1.amazonaws.com?fromMobile=1'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: WebViewStack(controller: controller),
      ),
      onWillPop: () async {
        // print("*********");
        // await FirebaseAnalytics.instance.logLogin();
        FirebaseAnalytics.instance.logEvent(
          name: "TestExathought",
          parameters: {
            // "mobile users": ,
            "test": 1234,
            // EventParamConstant.other_information: event.otherInformation
          },
          );
        if (await controller.canGoBack()) {
          await controller.goBack();
        } else {
          return Future.value(true);
        }
        return Future.value(false);
      },
    );
  }
}
