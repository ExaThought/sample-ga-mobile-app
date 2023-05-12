import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:newrelic_mobile/newrelic_mobile.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'src/menu.dart';
import 'src/web_view_stack.dart';
// import 'package:newrelic_mobile/config.dart';
void main() {
  var appToken = "AA00e78b5d4cff2b845e596589507d0795a9bed32f-NRMA";

  // if (Platform.isAndroid) {
  //     appToken = "AA37a75aa298e10171c90fa21bebb531a5e969034e-NRMA"; // Replace with your application token copied from the New Relic UI.
  // } else if (Platform.isIOS) {
  //     appToken = "<ios app token>"; // Replace with your application token copied from the New Relic UI.
  // }

  // Config config = Config(
  //     accessToken: appToken,

  //     //Android Specific
  //     // Optional: Enable or disable collection of event data.
  //     analyticsEventEnabled: true,

  //     // Optional: Enable or disable reporting successful HTTP requests to the MobileRequest event type.
  //     networkErrorRequestEnabled: true,

  //     // Optional: Enable or disable reporting network and HTTP request errors to the MobileRequestError event type.
  //     networkRequestEnabled: true,

  //     // Optional: Enable or disable crash reporting.
  //     crashReportingEnabled: true,

  //     // Optional: Enable or disable interaction tracing. Trace instrumentation still occurs, but no traces are harvested. This will disable default and custom interactions.
  //     interactionTracingEnabled: true,

  //     // Optional: Enable or disable capture of HTTP response bodies for HTTP error traces and MobileRequestError events.
  //     httpResponseBodyCaptureEnabled: true,

  //     // Optional: Enable or disable agent logging.
  //     loggingEnabled: true,

  //     // iOS specific
  //     // Optional: Enable or disable automatic instrumentation of WebViews
  //     webViewInstrumentation: true,

  //     //Optional: Enable or disable Print Statements as Analytics Events
  //     printStatementAsEventsEnabled: true,

  //     // Optional: Enable or disable automatic instrumentation of HTTP Request
  //     httpInstrumentationEnabled: true);

  // NewrelicMobile.instance.start(config, () {
    runApp(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const WebViewApp(),
      ),
    );
  }
  // );
// }

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    // NewrelicMobile.instance.setUserId("test-id");
    // NewrelicMobile.instance.recordCustomEvent("newrelic mobile iuser",
    //     eventAttributes: {"user type": "mobile"}, eventName: "mobile newrelicuser");

    super.initState();
    controller = WebViewController()
      ..loadRequest(
        // Uri.parse('http://carparts-newrelic-test.s3-website-ap-southeast-1.amazonaws.com/'),
        //change the ip address
         Uri.parse('http://192.168.1.180:3000'),
      );
  }

  @override
  Widget build(BuildContext context) {
    // NewrelicMobile.instance.setUserId("1234");
    // NewrelicMobile.instance.recordCustomEvent("carparts mobile user",eventAttributes:
    //         {"user type": "mobile"}, eventName: "mobile user");

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          // elevation: 10,
          // title: const Text('carparts.com'),
          // actions: [
          //   NavigationControls(controller: controller),
          //   // Menu(controller: controller),
          // ],
        ),
        body: WebViewStack(controller: controller),
      ),
      onWillPop: () async {
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
