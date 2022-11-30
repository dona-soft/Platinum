import 'package:flutter/material.dart';
import 'package:platinum/core/themes/main_theme.dart';

// ignore: must_be_immutable
class LoginContainer extends StatelessWidget {
  LoginContainer({
    Key? key,
    required this.phoneNumberCtrl,
    required this.passwordCtrl,
    required this.moveContainerUp,
    required this.isCodeSent,
    required this.validateUser,
    required this.fadeIn,
  }) : super(key: key);

  final TextEditingController phoneNumberCtrl, passwordCtrl;

  bool moveContainerUp, isCodeSent, fadeIn;
  VoidCallback validateUser;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      alignment: moveContainerUp
          ? Alignment.lerp(Alignment.topCenter, Alignment.center, 0.6)
              as Alignment
          : Alignment.center,
      child: AnimatedCrossFade(
        alignment: Alignment.center,
        duration: Duration(seconds: 2),
        crossFadeState:
            fadeIn ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: Container(),
        secondChild: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  autofocus: false,
                  controller: phoneNumberCtrl,
                  decoration: const InputDecoration(
                    labelText: ':رقم الهاتف',
                    hintText: '0987654321',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              isCodeSent
                  ? Container(
                      child: TextField(
                        textAlign: TextAlign.center,
                        autofocus: false,
                        controller: passwordCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Code:',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(LightTheme.primaryColorLight),
                  ),
                  onPressed: validateUser,
                  child: Text(
                    isCodeSent ? 'تأكيد الكود' : 'تسجيل الدخول',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                'الرجاء تفعيل البروكسي فقط عند تسجيل الدخول!',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
