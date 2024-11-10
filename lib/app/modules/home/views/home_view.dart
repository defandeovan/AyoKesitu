import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/booking/views/booking_view.dart';
import 'package:project_flutter/app/modules/messages/views/messages_view.dart';
import 'package:project_flutter/app/modules/profile/views/profile_view.dart';
import 'package:project_flutter/app/routes/app_pages.dart';
import 'package:project_flutter/controller/Destination.dart';
import 'package:project_flutter/app/modules/home/controllers/home_controller.dart';

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

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _widgetOptions = <Widget>[
      _buildDestinationContent(),
      Placeholder(),
      MessagesView(),
      ProfileView(userId: widget.userId), // Placeholder for other tab content
    ];
  }

  Widget _buildDestinationContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          _buildSearchBar(),
          Obx(
            () {
              if (homeController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (homeController.destinations.isEmpty) {
                return Center(child: Text('Tidak ada destinasi.'));
              }
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
                        _buildHorizontalList(destinations),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Popular Destinations",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        _buildPopularList(destinations),
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
  Widget _buildHorizontalList(List<Destination> destinations) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          var destination = destinations[index];
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
                      child: Image.asset(
                        'assets/img/Ratenggaro-village-in-Sumba-Explore-Sumba-island-villages-in-Indonesia-10.jpg',
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 4,
                                    offset: Offset(0, 4))
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/img/favorite.svg',
                              width: 24, height: 24, color: Colors.red),
                        ],
                      ),
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
  Widget _buildPopularList(List<Destination> destinations) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        var destination = destinations[index];
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
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              width: 355,
              height: 160,
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(12),
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
                    child: Image.asset(
                      'assets/img/lombok.jpg', // Gantilah dengan path gambar destinasi dari data
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
                            SvgPicture.asset('assets/img/favorite.svg',
                                width: 24, height: 24),
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
    );
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
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        margin: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: _buildBottomNavItem('assets/img/Home.svg', 0),
                  label: ''),
              BottomNavigationBarItem(
                  icon: _buildBottomNavItem('assets/img/Heart.svg', 1),
                  label: ''),
              BottomNavigationBarItem(
                  icon: _buildBottomNavItem('assets/img/Send.svg', 2),
                  label: ''),
              BottomNavigationBarItem(
                  icon: _buildBottomNavItem('assets/img/User.svg', 3),
                  label: ''),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
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
