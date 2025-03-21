import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/mybusinessaccountmanagement/v1.dart';
import '../controllers/admin_controller.dart';
// Import halaman baru

class AdminView extends StatefulWidget {
  final String userId;

  AdminView({Key? key, required this.userId}) : super(key: key);

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final AdminController adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Menu dengan AnimatedContainer
          Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: adminController.isMenuOpen.value ? 250 : 70, // Lebar berubah
                color: Colors.blueGrey[900],
                child: Column(
                  children: [
                    DrawerHeader(
                      child: adminController.isMenuOpen.value
                          ? const Text(
                              'Admin Panel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )
                          : const Icon(Icons.admin_panel_settings,
                              color: Colors.white, size: 40),
                    ),
                    IconButton(
                      icon: Icon(
                        adminController.isMenuOpen.value
                            ? Icons.arrow_back
                            : Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        adminController.toggleMenu();
                      },
                    ),
                    menuItem("Dashboard", Icons.dashboard),
                    menuItem("Add", Icons.add),
                    menuItem("Product", Icons.shopping_bag),
                    // Tambahkan di sini
                    menuItem("Payment", Icons.payment),
                    menuItem("Order", Icons.receipt),
                    // menuItem("Chat", Icons.chat),
                    menuItem("Feedback", Icons.feedback),
                    menuItem("Profile", Icons.person),
                  ],
                ),
              )),
          // Content Area
          Expanded(
            child: GetBuilder<AdminController>(
              builder: (_) {
                return Scaffold(
                  body: _.currentPage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(String title, IconData icon) {
    return Obx(() => ListTile(
          leading: Icon(icon, color: Colors.white),
          title: adminController.isMenuOpen.value
              ? Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            adminController.changePage(title);
          },
        ));
  }
}
