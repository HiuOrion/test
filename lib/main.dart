import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/chat.dart';
import 'package:chat_app/screen/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  runApp(const ChatApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 39, 51, 126))),
      //StreamBuilder dùng để lắng nghe sự thay đổi
      //Hiện thị ChatScreen nếu đăng nhập rồi
      //Hiển thị AuthScreen nếu cha đăng nhập
      home: StreamBuilder(
        //Lắng nghe thng qua stream
          stream: FirebaseAuth.instance.authStateChanges(),
          //được gọi mỗi khi stream thay đổi
          //snapshot chưa thông tin mới nhất của stream
          builder: (ctx, snapshot) {
            // if(snapshot.connectionState == ConnectionState.waiting){
            //   return CircularProgressIndicator();
            // }
            if (snapshot.hasData) {
              return const ChatScreen();
            }
              return const AuthScreen();
          }),
    );
  }
}
