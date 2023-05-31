import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/reusable_widgets/keys.dart';
import 'package:project/screens/login.dart';
import 'package:project/screens/splashscreen.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

//initializing notifications and firebase
void main() async {
  await MpesaFlutterPlugin.setConsumerKey(consumerKey);
  await MpesaFlutterPlugin.setConsumerSecret(consumerSecret);

  AwesomeNotifications().initialize(
      null,
    [
      NotificationChannel(
          channelKey: 'channelKey',
          channelName: 'channelName',
          channelDescription: 'channelDescription',
          importance: NotificationImportance.Max,
      ),
    ],
    debug: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if (!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    // Delay the navigation to the login screen
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //if _isLoading is true splash screen else login page
      home: _isLoading ? const SplashScreen() : const Login(),
    );
  }
}