import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FacebookCustomWebView extends StatefulWidget {
  const FacebookCustomWebView({
    Key key,
    this.selectedUrl,
  }) : super(key: key);

  final String selectedUrl;

  @override
  _FacebookCustomWebViewState createState() => _FacebookCustomWebViewState();
}

class _FacebookCustomWebViewState extends State<FacebookCustomWebView> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((url) {
      if (url.contains("#access_token")) {
        succeed(url);
      }

      if (url.contains(
          "https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
        denied();
      }
    });
  }

  Future<void> denied() async {
    Navigator.pop(context);
  }

  Future<void> succeed(String url) async {
    var params = url.split("access_token=");

    var endparam = params[1].split("&");

    Navigator.pop(context, endparam[0]);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.selectedUrl,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        brightness: Brightness.dark,
        backgroundColor: const Color.fromRGBO(66, 103, 178, 1),
        title: const Text(
          "Facebook login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
