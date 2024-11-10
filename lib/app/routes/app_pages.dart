import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/DestinasiService.dart';
import '../../controller/Destination.dart';
import '../modules/addDest/bindings/add_dest_binding.dart';
import '../modules/addDest/views/add_dest_view.dart';
import '../modules/boarding/bindings/boarding_binding.dart';
import '../modules/boarding/views/boarding_view.dart';
import '../modules/boardingNext/bindings/boarding_next_binding.dart';
import '../modules/boardingNext/views/boarding_next_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/destination/bindings/destination_binding.dart';
import '../modules/destination/views/destination_view.dart';
import '../modules/editprofile/bindings/editprofile_binding.dart';
import '../modules/editprofile/views/editprofile_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/payMethod/bindings/pay_method_binding.dart';
import '../modules/payMethod/views/pay_method_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/yourOrder/bindings/your_order_binding.dart';
import '../modules/yourOrder/views/your_order_view.dart';

// Import bindings dan views dari module

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () {
        final args = Get.arguments;

   
        final userId = args['userId'];
        return HomeView(userId: userId);
      },
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () {
        final args = Get.arguments;
        final userId = args['userId'];
        return ProfileView(userId: userId);
      },
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () {
        final args = Get.arguments;
        final String userId = args['userId'];
        final String firstName = args['firstName'];
        final String lastName = args['lastName'];
        final String email = args['email'];
        final String phoneNumber = args['phoneNumber'];
        final File? image = args['image'];

        return EditprofileView(
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          image: image,
        );
      },
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () {
        final String destinationId = Get.arguments['destinationId'];
        return FutureBuilder<Destination>(
          future: DestinationService().getDestination(destinationId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return BookingView(destination: snapshot.data!);
            } else {
              return Center(child: Text('Destination not found'));
            }
          },
        );
      },
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAY_METHOD,
      page: () => PaymentMethodView(),
      binding: PayMethodBinding(),
    ),
    GetPage(
      name: _Paths.YOUR_ORDER,
      page: () => const YourOrderView(),
      binding: YourOrderBinding(),
    ),
    GetPage(
      name: _Paths.BOARDING,
      page: () => const BoardingView(),
      binding: BoardingBinding(),
    ),
    GetPage(
      name: _Paths.BOARDING_NEXT,
      page: () => BoardingNextView(),
      binding: BoardingNextBinding(),
    ),
    GetPage(
      name: _Paths.DESTINATION,
      page: () => const DestinationView(),
      binding: DestinationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DEST,
      page: () => AddDestView(),
      binding: AddDestBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => MessagesView(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () =>  NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
     GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
