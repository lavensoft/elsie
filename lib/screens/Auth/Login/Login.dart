import "package:flutter/material.dart";
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;

void _lauchAuthInBrowser(String url) async {
  await canLaunch(url) ? await launch(url) : throw 'Could not lauch $url';
}

void _loginWindowsDesktop() async {
  var id = ClientId(
    // "37810002148-m8bl8vj2bb67k6vf3encqtfc3pmshil9.apps.googleusercontent.com" //MYFPL
    "625931149342-ta1eg5g949f9qcp40s544qpdg3ikiipo.apps.googleusercontent.com",
    "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",
  );
  var scopes = [
    'email'
  ];
  
  var client = http.Client();

  try {
    AccessCredentials res = await obtainAccessCredentialsViaUserConsent(
      id, scopes, client, (url) => _lauchAuthInBrowser(url));
    

    print(res.accessToken.data);
    print(res.idToken);
    print(res.scopes);
    print(res.refreshToken);
  } finally {
    // client.close();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Đăng Nhập"),
            ElevatedButton(
              onPressed: () {
                _loginWindowsDesktop();
              }, 
              child: const Text("Đăng nhập với Google")
            )
          ],
        ),
      )
    );
  }
}