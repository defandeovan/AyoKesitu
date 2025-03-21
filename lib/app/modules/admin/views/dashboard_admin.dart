import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/app/data/Databese_Service.dart';

import 'package:project_flutter/app/data/destination.dart';
import 'package:project_flutter/app/modules/admin/controllers/admin_controller.dart';
import 'package:project_flutter/app/modules/admin/views/editproduct.dart';


class DashboardAdmin extends StatelessWidget {
  DashboardAdmin({super.key});

  final AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Search Field
            TextField(
              onChanged: adminController.updateSearchText,
              decoration: InputDecoration(
                hintText: "Cari destinasi...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (adminController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                var filteredDestinations = adminController.destinations
                    .where((destination) =>
                        destination.name.toLowerCase().contains(
                              adminController.searchText.value.toLowerCase(),
                            ))
                    .toList();

                if (filteredDestinations.isEmpty) {
                  return const Center(child: Text("Tidak ada hasil pencarian"));
                }

                return ListView.builder(
                  itemCount: filteredDestinations.length,
                  itemBuilder: (context, index) {
                   var destination = filteredDestinations[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EditProduct(
                        //       // destinationData: destination.,
                        //     // ),
                        //   ),
                        // );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                destination.img,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 220,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        destination.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/img/map_pin.png',
                                            width: 12,
                                            height: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            destination.location,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/img/star.svg',
                                            width: 12,
                                            height: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${destination.rating}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Hapus Produk"),
                                            content: const Text(
                                                "Apakah Anda yakin ingin menghapus produk ini?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Batal"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Hapus"),
                                                onPressed: () async {
                                                  await DatabaseService()
                                                      .deleteDestination(
                                                          destination.id);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}