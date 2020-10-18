// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:pidos/src/data/constanst.dart' as Constans;
// import 'package:pidos/src/utils/colors.dart';

// class RegistroWebviewPage extends StatefulWidget {
  

//   @override
//   _RegistroWebviewPageState createState() => _RegistroWebviewPageState();
// }

// class _RegistroWebviewPageState extends State<RegistroWebviewPage> {

//   final flutterWebviewPlugin = new FlutterWebviewPlugin();

//   StreamSubscription _onDestroy;
//   StreamSubscription<String> _onUrlChanged;
//   StreamSubscription<WebViewStateChanged> _onStateChanged;
  

//   @override
//   void initState() {
//     super.initState();
//     flutterWebviewPlugin.close();
//     _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) => print('destroy'));
//     _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//       if(state.type.toString() == WebViewState.startLoad.toString()){
//         if(state.url == Constans.successRegisterUrl || state.url == Constans.loginUrl){
//           Navigator.of(context).pop();
//           flutterWebviewPlugin.cleanCookies();
//           flutterWebviewPlugin.clearCache();
//           flutterWebviewPlugin.close();
//         }
//       }
//       print("onStateChanged: ${state.type} ${state.url}");
//     });
//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) { 
//       if(url == Constans.successRegisterUrl || url == Constans.loginUrl){
//         // Navigator.of(context).pop();
//         // flutterWebviewPlugin.cleanCookies();
//         // flutterWebviewPlugin.clearCache();
//         // flutterWebviewPlugin.close();
//         print('[REGISTRO_WEBVIEW_PAGE] webview closed');
//       }
//     });
    
//   }


//   @override
//   void dispose() {
//     _onDestroy?.cancel();
//     _onUrlChanged?.cancel();
//     _onStateChanged?.cancel();
//     flutterWebviewPlugin?.dispose();
//     print('[REGISTRO_WEBVIEW_PAGE] dispose');
//     super.dispose();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       resizeToAvoidBottomInset: true,
//       url: Constans.registerUrl,
//       hidden: true,
//       withJavascript: true,
//       withLocalStorage: false,
//       clearCache: true,
//       clearCookies: true,
//       appCacheEnabled: false,
//       initialChild: Center(
//         child: CircularProgressIndicator(
//           valueColor: const AlwaysStoppedAnimation(primaryColor),
//         ),
//       ),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             flutterWebviewPlugin.canGoBack().then((value) {
//               if (value) {
//                 flutterWebviewPlugin.goBack();
//               } else {
//                 Navigator.pop(context);
//                 flutterWebviewPlugin.cleanCookies();
//                 flutterWebviewPlugin.clearCache();
//               }
//             });
//           }),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.refresh, color: Color.fromRGBO(255, 255, 255, 1.0),),
//             onPressed: () => flutterWebviewPlugin.reload(), // this is reloading the url that was provided to webview, not the current URL.
//           )
//         ],
//         elevation: 1.0,
//         centerTitle: true,
//         title: Text("Registro", style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600))
//       ),
//     );
//   }
// }