import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/admin/views/add.dart';
// import '../views/add_admin.dart';
import '../views/dashboard_admin.dart';
import '../views/product_admin.dart';
import '../views/payment_admin.dart';
import '../views/order_admin.dart';
import '../views/chat_admin.dart';
import '../views/feedback_admin.dart';
import '../views/profile_admin.dart';

class AdminController extends GetxController {
  // Kontrol buka-tutup sidebar
  var isMenuOpen = false.obs;

  // Ubah currentPage ke tipe Widget
  var currentTitle = 'Dashboard';
  Widget currentPage = DashboardAdmin();

  // Fungsi toggle buka-tutup menu
  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  // Fungsi ganti halaman
  void changePage(String title) {
    currentTitle = title;
    switch (title) {
      case 'Dashboard':
        currentPage = DashboardAdmin();
        break;
      case 'Product':
        currentPage = ProductAdmin();
        break;
      case 'Add':
        currentPage = AddAdmin();
        break;

      case 'Payment':
        currentPage = PaymentAdmin();
        break;

      case 'Order':
        currentPage = OrderAdmin();
        break;
      case 'Chat':
        currentPage = ChatAdmin(userId: 'lx4ACBzU3zdEuUXySpbLPd4o0lT2',);
        break;
      case 'Feedback':
        currentPage = FeedbackAdmin();
        break;
      case 'Profile':
        currentPage = ProfileAdmin();
        break;
      default:
        currentPage = DashboardAdmin();
    }
    update();
  }
}
