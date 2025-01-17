// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:delivery_app/core/constant/route.dart';
import 'package:delivery_app/core/middleware/mymiddleware.dart';
import 'package:delivery_app/view/screens/auth/login.dart';
import 'package:delivery_app/view/screens/auth/signUp.dart';
import 'package:delivery_app/view/screens/home/card.dart';
import 'package:delivery_app/view/screens/home/favorit.dart';
import 'package:delivery_app/view/screens/home/homescreen.dart';
import 'package:delivery_app/view/screens/home/homescreencardview.dart/discribtionScreen.dart';
import 'package:delivery_app/view/screens/home/homescreencardview.dart/searchScreen.dart';
import 'package:delivery_app/view/screens/home/productsScreen.dart';
import 'package:delivery_app/view/screens/home/profile.dart';
import 'package:delivery_app/view/screens/language.dart';
import 'package:delivery_app/view/screens/oldFatoras.dart';
import 'package:delivery_app/view/screens/onBoarding.dart';
import 'package:delivery_app/view/screens/home/storesscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'view/screens/auth/saccessSignUp.dart';

List<GetPage<dynamic>>? routes = [
  //onBoarding
  GetPage(name: Approute.onBoarding, page: () => OnBoarding()),
  // Auth
  GetPage(
    name: '/',
    page: () => Language(),
    middlewares: [MyMiddleWare()],
  ),
  GetPage(name: Approute.login, page: () => LogIn()),
  GetPage(name: Approute.signUp, page: () => SignUp()),
  GetPage(name: Approute.saccessSignUp, page: () => SaccessSignUp()),
  GetPage(name: Approute.home, page: () => HomeScreec()),
  GetPage(name: Approute.storesscreen, page: () => StoresScreen()),
  GetPage(name: Approute.card, page: () => Cardd()),
  GetPage(name: Approute.favorit, page: () => Favorit()),
  GetPage(name: Approute.profileScreen, page: () => ProfileScreen()),
  GetPage(name: Approute.products, page: () => ProductsScreen()),
  GetPage(name: Approute.discribtion, page: () => Discribtion()),
  GetPage(name: Approute.oldFatoras, page: () => OldFatoras()),
  GetPage(name: Approute.searshscreen, page: () => SearchScreen()),
];
