import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'src/web_view_stack.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );

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
  late final WebViewController controller, navigationDelegate;
  
  @override
  void initState()  {
    super.initState();
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.setAnalyticsCollectionEnabled(true);
    // analytics.setDefaultEventParameters(<String, dynamic>{
    //   'stream_id': '5159556243'
    // });
    // analytics.setUserProperty(name: 'app-platform', value: 'app');
     controller = WebViewController()
     ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://1428-2405-201-d024-c8b5-b42f-2001-c850-2622.ngrok-free.app/'))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          final Uri uri = Uri.parse(request.url);
          final Map<String, String> queryParameters = Map.from(uri.queryParameters);
          queryParameters.addAll({'fromMobile': '1'});
          final Uri modifiedUri = Uri.https(uri.authority, uri.path, queryParameters);
          controller.loadRequest(modifiedUri);
          return NavigationDecision.prevent;
        },
      )
      );

    //  controller.setNavigationDelegate(NavigationDecisionPolicyDelegate(
    //   shouldOverrideUrlLoading: (NavigationAction action) {
    //     Uri uri = Uri.parse(action.request.url!);
    //     Map<String, String> queryParameters = Map.from(uri.queryParameters);
    //     queryParameters.addAll({'fromMobile': '1'});
    //     Uri newUri = Uri.https(uri.authority, uri.path, queryParameters);
    //     controller.loadRequest(Uri.parse('https://carparts.com/?fromMobile=1'),);
    //     return NavigationDecision.prevent;
    //   },
    // ));
    // controller.loadUrl('https://carparts.com/');
    
      
      
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
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

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late WebViewController _webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: WebView(
//             initialUrl: 'https://0dcc-2405-201-d024-c8b5-e86f-6a7-cf3c-880f.ngrok-free.app',
//             onWebViewCreated: (WebViewController webViewController) {
//               _webViewController = webViewController;
//               _webViewController.loadUrl(
//                 Uri.https(
//                   '0dcc-2405-201-d024-c8b5-e86f-6a7-cf3c-880f.ngrok-free.app',
//                   '/',
//                   {'fromMobile': '1'},
//                 ).toString(),
//               );
//             },
//             navigationDelegate: (NavigationRequest request) {
//               Uri uri = Uri.parse(request.url);
//               Map<String, String> queryParameters = Map.from(uri.queryParameters);
//               queryParameters.addAll({'fromMobile': '1'});
//               Uri newUri = Uri.https(uri.authority, uri.path, queryParameters);
//               _webViewController.loadUrl(newUri.toString());
//               return NavigationDecision.prevent;
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late WebViewController _webViewController;
//   bool _isLoadingPage = true;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               WebView(
//                 initialUrl: 'https://0dcc-2405-201-d024-c8b5-e86f-6a7-cf3c-880f.ngrok-free.app',
//                 onWebViewCreated: (WebViewController webViewController) {
//                   _webViewController = webViewController;
//                 },
//                 onPageFinished: (_) {
//                   setState(() {
//                     _isLoadingPage = false;
//                   });
//                 },
//                 navigationDelegate: (NavigationRequest request) {
//                   Uri uri = Uri.parse(request.url);
//                   Map<String, String> queryParameters = Map.from(uri.queryParameters);
//                   queryParameters.addAll({'fromMobile': '1'});
//                   Uri newUri = Uri.https(uri.authority, uri.path, queryParameters);
//                   _webViewController.loadUrl(newUri.toString());
//                   return NavigationDecision.prevent;
//                 },
//               ),
//               if (_isLoadingPage)
//                 Center(
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//Inappwebview
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late InAppWebViewController _webViewController;
//   bool _isLoadingPage = true;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               InAppWebView(
//                 initialUrlRequest: URLRequest(url: Uri.parse('https://0dcc-2405-201-d024-c8b5-e86f-6a7-cf3c-880f.ngrok-free.app')),
//                 onWebViewCreated: (InAppWebViewController webViewController) {
//                   _webViewController = webViewController;
//                 },
//                 onLoadStop: (_, __) {
//                   setState(() {
//                     _isLoadingPage = false;
//                   });
//                 },
//                 shouldOverrideUrlLoading: (controller, navigationAction) async {
//                   Uri uri = navigationAction.request.url!;
//                   Map<String, String> queryParameters = Map.from(uri.queryParameters);
//                   queryParameters.addAll({'fromMobile': '1'});
//                   Uri newUri = Uri.https(uri.authority, uri.path, queryParameters);
//                   await _webViewController.loadUrl(urlRequest: URLRequest(url: newUri));
//                   return NavigationActionPolicy.CANCEL;
//                 },
//               ),
//               if (_isLoadingPage)
//                 Center(
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

