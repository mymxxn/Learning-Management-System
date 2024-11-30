import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning_management_system/controller/login_provider.dart';
import 'package:learning_management_system/utils/constants.dart';
import 'package:learning_management_system/view/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoginProvider>().initialDataLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ConstantColor.primaryColor,
        body: Stack(
          children: [
            Image.asset(
              ConstantImages.splashScreen,
              fit: BoxFit.fill,
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SpinKitThreeBounce(size: 20,
            //     itemBuilder: (BuildContext context, int index) {
            //       return DecoratedBox(
            //         position: DecorationPosition.background,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: index.isEven
            //               ? ConstantColor.logoPrimary
            //               : ConstantColor.logoSecondary,
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ));
  }
}
