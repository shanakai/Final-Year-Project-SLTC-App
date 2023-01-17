import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:vis_mobile/view/login_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51MFxK5J3a91UpOsqB4fxPoj1Nqr8okqKAJG6f4zD5o7paPrNFa3FK6xd3X6kfVk0DwnbpR3D0YvfCcRT4cZ9xb2t00MvIxAicG'; 
  runApp(GetMaterialApp(
    title: 'Train Booking',
    initialRoute: '/',
    //fade in transition
    transitionDuration: const Duration(milliseconds: 500),
    defaultTransition: Transition.fadeIn,
    getPages: [
      GetPage(
        name: '/',
        page: () => LoginScreen(),
      ),
    ],
  ));
}
