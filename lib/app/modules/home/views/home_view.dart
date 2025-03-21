import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:googleapis/secretmanager/v1.dart';
import 'package:project_flutter/app/data/Bukit.dart';
import 'package:project_flutter/app/data/Danau.dart';
import 'package:project_flutter/app/data/Hutan.dart';
import 'package:project_flutter/app/data/Mountain.dart';
import 'package:project_flutter/app/data/Pantai.dart';
import 'package:project_flutter/app/modules/Favorite/Favorite_view.dart';
import 'package:project_flutter/app/modules/booking/views/booking_view.dart';

import 'package:project_flutter/app/modules/home/views/location_view.dart';
import 'package:project_flutter/app/modules/messages/views/messages_view.dart';
import 'package:project_flutter/app/modules/profile/views/profile_view.dart';
import 'package:project_flutter/app/data/Destination.dart';
import 'package:project_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:custom_search_bar/custom_search_bar.dart';



class HomeView extends StatefulWidget {
  final String userId;
  HomeView({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());
  late TabController _tabController;
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  TextEditingController _searchController = TextEditingController();
  final List<Widget> pages = [
    const Mountain(title: 'Halaman 1'),
    const Pantai(title: 'Halaman 2'),
    const Danau(title: 'Halaman 3'),
    const Hutan(title: 'Halaman 4'),
    const Bukit(title: 'Halaman 5')
  ];

  // Daftar teks yang berbeda untuk kotak oval
  final List<String> texts = ["Gunung", "Pantai", "Danau", "Hutan", "Bukit"];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _selectedIndex = Get.arguments?['selectedIndex'] ?? 0;
    _widgetOptions = <Widget>[
      _buildDestinationContent(),
      FavoriteView(),
      MessagesView(userId: widget.userId),
      ProfileView(userId: widget.userId), // Placeholder for other tab content
    ];
  }

  Widget _buildDestinationContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LocationView(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Menentukan scroll horizontal
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align Row ke kiri
                children: List.generate(
                  texts
                      .length, // Menggunakan texts.length agar sesuai dengan jumlah teks
                  (index) => GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman tertentu berdasarkan index
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pages[index],
                        ),
                      );
                    },
                    child: Container(
                      width: 100, // Lebar oval
                      height: 30, // Tinggi oval
                      margin: EdgeInsets.only(right: 8.0), // Jarak antar oval
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 161, 161, 161), // Warna oval
                        borderRadius: BorderRadius.circular(20), // Membuat oval
                      ),
                      child: Center(
                        child: Text(
                          texts[index], // Teks sesuai dengan daftar 'texts'
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () {
              // if (homeController.isLoading.value) {
              //   return Center(
              //   child: CircularProgressIndicator());
              // } else if (homeController.destinations.isEmpty) {
              //   return Center(child: Text('Tidak ada destinasi.'));
              // }
              var destinations = homeController.destinations;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recommended Destinations",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        _buildHorizontalList(
                            homeController.recommendedDestinations),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // Warna untuk debugging
                          child: Text("All Destinations",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double maxHeight = constraints.maxHeight < 100000
                                ? constraints.maxHeight
                                : 100000;
                            return Container(
                                constraints:
                                    BoxConstraints(maxHeight: maxHeight),
                                child: _buildPopularList(destinations));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 355,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/img/Search.svg'),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search destinations...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                print("User is typing: $value");
              },
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal list for recommended destinations
  Widget _buildHorizontalList(List<Destination> RecomendationtsDestinations) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: RecomendationtsDestinations.length,
        itemBuilder: (context, index) {
          var destination = RecomendationtsDestinations[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingView(destination: destination),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        destination.img,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 220,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Image.asset('assets/img/Map Pin.png',
                                    width: 12, height: 12),
                                SizedBox(width: 4),
                                Text('${destination.location}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset('assets/img/star.svg',
                                    width: 12, height: 12),
                                SizedBox(width: 4),
                                Text('${destination.rating}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Obx(() {
                        bool isFav = homeController.isFavorite(destination.id);
                        return GestureDetector(
                          onTap: () {
                            homeController.toggleFavorite(destination);
                          },
                          child: Icon(
                            Icons.favorite,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 24,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Vertical list for popular destinations
  Widget _buildPopularList(List<Destination> Destinations) {
    return Flexible(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: Destinations.length,
      itemBuilder: (context, index) {
        var destination = Destinations[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingView(destination: destination),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Container(
              width: 355,
              height: 160,
              // margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      destination
                          .img, // Gantilah dengan path gambar destinasi dari data
                      fit: BoxFit.cover,
                      width: 111,
                      height: 135,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(destination.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                homeController.toggleFavorite(destination);
                              },
                              child: Obx(() {
                                bool isFav =
                                    homeController.isFavorite(destination.id);
                                return GestureDetector(
                                  onTap: () {
                                    homeController.toggleFavorite(destination);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: isFav ? Colors.red : Colors.grey,
                                    size: 24,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            SvgPicture.asset('assets/img/star.svg'),
                            Text('${destination.rating}',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('\$${destination.price}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          'Kebersihan Akomodasi: ${destination.cleanAccommodation}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var screensize = MediaQuery.of(context).size;
    // if(screensize.width > oneColumnLayout){

    // }else{

    // }
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          if (_selectedIndex == 0) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: PreferredSize(
                  preferredSize: const Size(double.infinity, 50.0),
                  child: AppBar(
                    elevation: 0.0,
                    automaticallyImplyLeading: false,
                    // title: const Text('AYO KESITU'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: InkWell(
                          // child: const Icon(Icons.close),
                          child: Row(children: [
                            Container(
                                padding: const EdgeInsets.all(1),
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0))),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/img/Search.svg'),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text('Search Destination')
                                  ],
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagesView(userId: widget.userId,)),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/img/message-circle.svg',
                                width: 40,
                              ),
                              // Tanpa titik setelah asset
                            )
                          ]),
                          onTap: () =>
                              showSearchForCustomiseSearchDelegate<Destination>(
                            context: context,
                            delegate: SearchScreen<Destination>(
                              itemStartsWith: true,
                              hintText: 'search here',
                              items: homeController.destinations,
                              filter: (destination) => [destination.name],
                              itemBuilder: (destination) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BookingView(destination: destination),
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Container(
                                    width: 355,
                                    height: 160,
                                    // margin: EdgeInsets.only(bottom: 16),
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            blurRadius: 4,
                                            offset: Offset(0, 4)),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            destination
                                                .img, // Gantilah dengan path gambar destinasi dari data
                                            fit: BoxFit.cover,
                                            width: 111,
                                            height: 135,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(destination.name,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/img/star.svg'),
                                                  Text('${destination.rating}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Text('\$${destination.price}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 4),
                                              Text(
                                                'Kebersihan Akomodasi: ${destination.cleanAccommodation}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              failure: const Center(
                                child: Text('no destinations found'),
                              ),
                              appBarBuilder: (
                                controller,
                                onSubmitted,
                                textInputAction,
                                focusNode,
                              ) {
                                return PreferredSize(
                                  preferredSize:
                                      const Size(double.infinity, 50.0),
                                  child: AppBar(
                                    elevation: 0.0,
                                    automaticallyImplyLeading: false,
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                              padding: const EdgeInsets.all(1),
                                              width: 360,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  border: Border.all(
                                                      width: 2.0,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0))),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/img/Search.svg'),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                        controller: controller,
                                                        // onSubmitted:
                                                        //     onSubmitted,
                                                        textInputAction:
                                                            textInputAction,
                                                        focusNode: focusNode,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Search here',

                                                          border:
                                                              InputBorder.none,
                                                          fillColor: const Color
                                                              .fromARGB(
                                                              255, 67, 49, 49),
                                                          suffixIcon: controller
                                                                  .text
                                                                  .isNotEmpty
                                                              ? IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close),
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .clear(); // Menghapus teks pencarian
                                                                  },
                                                                )
                                                              : null, // Tidak menampilkan ikon jika tidak ada teks
                                                        ),
                                                        onChanged: (text) =>
                                                            setState(() {}),
                                                        onSubmitted: (query) {
                                                          print(
                                                              "Pencarian: $query");
                                                        }),
                                                  )
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          }
          return [];
        },
        body: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: _buildBottomNavItem('assets/img/home-2.svg', 0),
              label: 'home'),
          BottomNavigationBarItem(
              icon: _buildBottomNavItem('assets/img/Heart.svg', 1),
              label: 'favorite'),
          BottomNavigationBarItem(
              icon: _buildBottomNavItem('assets/img/send_chat.svg', 2),
              label: ''),
          BottomNavigationBarItem(
              icon: _buildBottomNavItem('assets/img/user copy.svg', 3),
              label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  Widget _buildBottomNavItem(String assetPath, int index) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Color(0xfe00A550) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          assetPath,
          color: _selectedIndex == index ? Colors.black : Colors.grey,
          width: 32,
        ),
      ),
    );
  }
}
