import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:platinum/core/themes/main_theme.dart';

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
                  autofocus: false,
                  controller: phoneNumberCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Phone number:',
                    hintText: '0987654321',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              !isCodeSent
                  ? Container()
                  : SizedBox(
                      height: 50,
                      child: TextField(
                        autofocus: false,
                        controller: passwordCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Code:',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
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
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
