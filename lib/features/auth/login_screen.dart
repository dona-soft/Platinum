import 'package:flutter/material.dart';
import 'package:platinum/core/themes/main_theme.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  var userNameController = TextEditingController();
  var phoneNumController = TextEditingController();

  final k = 0.2;
  double? radius;
  bool isActiveAnim = true;
  bool moveCotainerUp = false;
  final duration = const Duration(milliseconds: 2000);

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumController.dispose();
    super.dispose();
  }

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      isActiveAnim = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    radius = MediaQuery.of(context).size.height * 0.45;
    moveCotainerUp = WidgetsBinding.instance.window.viewInsets.bottom != 0;
    startAnimation();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightTheme.secondaryColorLight,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // Login Container
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              alignment: moveCotainerUp
                  ? Alignment.lerp(Alignment.topCenter, Alignment.center, 0.55)
                      as Alignment
                  : Alignment.center,
              child: AnimatedOpacity(
                opacity: isActiveAnim ? 0.0 : 1,
                duration: duration,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          controller: userNameController,
                          decoration: const InputDecoration(
                            labelText: 'UserName:',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          autofocus: false,
                          controller: phoneNumController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'PhoneNum:',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                LightTheme.primaryColorLight),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
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
            ),
            // First Circle
            AnimatedPositioned(
              curve: Curves.easeInOutCubic,
              duration: duration,
              top: isActiveAnim ? (radius! * 0.5) - 50 : radius! * (-0.5),
              right: isActiveAnim ? radius! * (-0.1) : radius! * (-0.6),
              child: Container(
                height: radius,
                width: radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LightTheme.primaryColorLight,
                ),
              ),
            ),
            //Second Circle
            AnimatedPositioned(
              curve: Curves.easeInOutCubic,
              duration: duration,
              bottom: isActiveAnim ? (radius! * 0.5) - 50 : radius! * (-0.5),
              left: isActiveAnim ? radius! * (-0.1) : radius! * (-0.6),
              child: Container(
                height: radius,
                width: radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LightTheme.primaryColorLight,
                ),
              ),
            ),
            //LOGO
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
      ),
    );
  }
}
