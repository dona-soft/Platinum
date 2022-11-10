import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/presentation/widgets/login_screen/animated_circle.dart';
import 'package:platinum/features/person/presentation/widgets/login_screen/login_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    required this.networkInfo,
    required this.sharedPreferences,
  }) : super(key: key);

  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  var phoneNumberCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  final fireDatabase = FirebaseDatabase.instance;
  final fireAuth = FirebaseAuth.instance;

  final k = 0.2;
  double radius = 0;
  bool isActiveAnim = true, moveContainerUp = false, isCodeSent = false;

  late String phoneNumber,
      varifyId,
      smsCode,
      fireToken,
      apiToken,
      apiPassword,
      userUid;
  PhoneAuthCredential? _authProvider;

  final duration = const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(duration);
    isActiveAnim = false;
    setState(() {});
  }

  Future<void> validateUser() async {
    if (await FirebaseAuth.instance.currentUser != null &&
        !widget.sharedPreferences.containsKey('apiToken')) {
      await callApi(true);
      return;
    }
    try {
      if (isCodeSent) {
        if (passwordCtrl.text.isEmpty) {
          showSnackB(
            context,
            'الرجاء كتابة رقم الكود',
            isError: true,
          );
        } else {
          _authProvider = PhoneAuthProvider.credential(
              verificationId: varifyId, smsCode: passwordCtrl.text);

          final userInfo = await fireAuth
              .signInWithCredential(_authProvider as AuthCredential);

          if (userInfo.additionalUserInfo != null) {
            print(
                'Debug: isNewUser? ${userInfo.additionalUserInfo!.isNewUser}');
            callApi(userInfo.additionalUserInfo!.isNewUser);
          }
        }
      } else {
        if (phoneNumberCtrl.text.isEmpty || phoneNumberCtrl.text.length > 10) {
          showSnackB(
            context,
            'رقم الهاتف خاطئ',
            isError: true,
          );
        } else {
          phoneNumber = phoneNumberCtrl.text.substring(1);
          phoneNumber = '+963' + phoneNumber;
          print(phoneNumber);
          await authenticate(phoneNumber);
        }
      }
    } catch (e) {
      print('Debug: exception = $e');
    }
  }

  Future<void> authenticate(String phoneNum) async {
    if (await widget.networkInfo.isConnected) {
      await fireAuth.verifyPhoneNumber(
          phoneNumber: phoneNum,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (phoneAuthCredential) async {
            setState(() {
              isCodeSent = false;
            });
            print(
                'DEBUG >> Verification successful: ${phoneAuthCredential.smsCode} :: ${phoneAuthCredential.verificationId}');
            var a =
                await fireAuth.signInWithCredential(phoneAuthCredential).then(
              (value) {
                print('userInfo: is New = ${value.additionalUserInfo}');
                if (value.additionalUserInfo != null)
                  callApi(value.additionalUserInfo!.isNewUser);
              },
            );
            // if (a.additionalUserInfo != null) {
            //   print(a.additionalUserInfo!.toString());
            //   await callApi(a.additionalUserInfo!.isNewUser);
          },
          verificationFailed: (authException) {
            print('DEBUG >> Verification Failed with Exception $authException');
            showSnackB(context, 'الرجاء التحقق من اعدادات البروكسي',
                isError: true);
          },
          codeSent: (verificationId, resendToken) {
            varifyId = verificationId;
            setState(() {
              isCodeSent = true;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } else {
      showSnackB(context, 'لا يوجد اتصال بالانترنت', isError: true);
    }
  }

  Future<void> callApi(bool isNew) async {
    fireToken = await FirebaseMessaging.instance.getToken() as String;
    if (await FirebaseAuth.instance.currentUser != null)
      userUid = await FirebaseAuth.instance.currentUser!.uid;

    print('Debug: fireToken = $fireToken');
    print('Debug: userUid = $userUid');

    final http.Response response;

    if (isNew) {
      response = await http.post(
        Uri.parse(HTTP_PLAYER_REGISTER),
        headers: {
          'Accept': 'application/vnd.api+json',
        },
        body: {
          'phone': phoneNumber,
          'password': userUid,
          'password_confirmation': userUid,
          'Token': fireToken,
        },
      );
    } else {
      response = await http.post(
        Uri.parse(HTTP_PLAYER_LOGIN),
        headers: {
          'Accept': 'application/vnd.api+json',
        },
        body: {
          'phone': phoneNumber,
          'password': userUid,
          'Token': fireToken,
        },
      );
    }
    print('${response.statusCode}');
    print('body: ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      await widget.sharedPreferences.setString('phone', phoneNumber);
      await widget.sharedPreferences
          .setString('apiToken', json['data']['token'].toString());

      print('Debug: Authentication successful on both FireBase and Api!!');
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void showSnackB(
    BuildContext context,
    String content, {
    required bool isError,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        content: Text(content),
      ),
    );
  }

  // void psudoAuth() async {
  //   await fireAuth.verifyPhoneNumber(
  //     phoneNumber: '+11234567891',
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (c) {
  //       //
  //       print('Success!');
  //     },
  //     verificationFailed: (e) {
  //       //
  //       print('Failure!');
  //     },
  //     codeSent: (s, i) {
  //       //
  //       print('code sent!');
  //       fireAuth.signInWithCredential(
  //           PhoneAuthProvider.credential(verificationId: s, smsCode: '123456'));
  //       fireDatabase
  //           .ref()
  //           .child('uuid')
  //           .set({'+11234567891': fireAuth.currentUser?.uid ?? 'null value'});
  //     },
  //     codeAutoRetrievalTimeout: (s) {
  //       //
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    radius = MediaQuery.of(context).size.height * 0.45;
    moveContainerUp = WidgetsBinding.instance.window.viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightTheme.secondaryColorLight,
      body: Stack(
        children: [
          // Login Container
          // AnimatedAlign(
          //   duration: const Duration(milliseconds: 500),
          //   curve: Curves.ease,
          //   alignment: moveContainerUp
          //       ? Alignment.lerp(Alignment.topCenter, Alignment.center, 0.55)
          //           as Alignment
          //       : Alignment.center,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.8,
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text(
          //           'Login',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.blueGrey,
          //             fontSize: 20,
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 15,
          //         ),
          //         SizedBox(
          //           height: 50,
          //           child: TextField(
          //             autofocus: false,
          //             controller: phoneNumberCtrl,
          //             decoration: const InputDecoration(
          //               labelText: 'Phone number:',
          //               hintText: '0987654321',
          //               border: OutlineInputBorder(),
          //             ),
          //             textInputAction: TextInputAction.done,
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 15,
          //         ),
          //         !isCodeSent
          //             ? Container()
          //             : SizedBox(
          //                 height: 50,
          //                 child: TextField(
          //                   autofocus: false,
          //                   controller: passwordCtrl,
          //                   keyboardType: TextInputType.number,
          //                   decoration: const InputDecoration(
          //                     labelText: 'Code:',
          //                     border: OutlineInputBorder(),
          //                   ),
          //                   textInputAction: TextInputAction.done,
          //                 ),
          //               ),
          //         const SizedBox(
          //           height: 15,
          //         ),
          //         SizedBox(
          //           width: double.infinity,
          //           child: ElevatedButton(
          //             style: ButtonStyle(
          //               backgroundColor: MaterialStateProperty.all(
          //                   LightTheme.primaryColorLight),
          //             ),
          //             onPressed: validateUser,
          //             child: const Text(
          //               'Login',
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          LoginContainer(
            phoneNumberCtrl: phoneNumberCtrl,
            passwordCtrl: passwordCtrl,
            moveContainerUp: moveContainerUp,
            isCodeSent: isCodeSent,
            validateUser: () async => await validateUser(),
            fadeIn: isActiveAnim,
          ),
          // First Circle
          // AnimatedPositioned(
          //   curve: Curves.easeInOutCubic,
          //   duration: duration,
          //   top: isActiveAnim ? (radius * 0.5) - 50 : radius * (-0.5),
          //   right: isActiveAnim ? radius * (-0.1) : radius * (-0.6),
          //   child: Container(
          //     height: radius,
          //     width: radius,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: LightTheme.primaryColorLight,
          //     ),
          //   ),
          // ),
          AnimatedCircle(
            radius: radius,
            top: isActiveAnim ? (radius * 0.5) - 50 : radius * (-0.5),
            right: isActiveAnim ? radius * (-0.1) : radius * (-0.6),
          ),
          //Second Circle
          // AnimatedPositioned(
          //   curve: Curves.easeInOutCubic,
          //   duration: duration,
          //   bottom: isActiveAnim ? (radius * 0.5) - 50 : radius * (-0.5),
          //   left: isActiveAnim ? radius * (-0.1) : radius * (-0.6),
          //   child: Container(
          //     height: radius,
          //     width: radius,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: LightTheme.primaryColorLight,
          //     ),
          //   ),
          // ),
          //LOGO
          AnimatedCircle(
            radius: radius,
            bottom: isActiveAnim ? (radius * 0.5) - 50 : radius * (-0.5),
            left: isActiveAnim ? radius * (-0.1) : radius * (-0.6),
          ),
          AnimatedAlign(
            alignment: isActiveAnim
                ? Alignment.center
                : Alignment.lerp(Alignment.topLeft, Alignment.center, 0.15)
                    as Alignment,
            curve: Curves.easeInOutCubic,
            duration: duration,
            child: Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'icons/Logo_light.png',
                scale: 2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Powered by donasoft'),
            ),
          )
        ],
      ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberCtrl.dispose();
    passwordCtrl.dispose();
  }
}
