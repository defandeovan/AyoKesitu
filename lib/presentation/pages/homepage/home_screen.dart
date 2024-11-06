import 'dart:io'; // untuk File
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_flutter/presentation/pages/homeprofile/profile/profile.dart';
import 'package:project_flutter/presentation/pages/pemesanan/pemesanan_page.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:get/get.dart'; //
import 'package:cloud_firestore/cloud_firestore.dart';

// Model untuk menyimpan status gambar profil
class ProfileImage with ChangeNotifier {
  File? _image;

  File? get image => _image;

  void updateImage(File? image) {
    _image = image;
    notifyListeners(); // Beritahu pendengar bahwa ada perubahan
  }
}

class HomeScreen extends StatefulWidget {
  final String userId;

  // Tambahkan konstruktor untuk menerima userId
  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    // Inisialisasi _widgetOptions menggunakan widget.userId
    _widgetOptions = <Widget>[
      HomeScreenBody(),
      Placeholder(),
      Placeholder(),
      ProfilePage(userId: widget.userId), // Gunakan widget.userId di sini
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
            Positioned(
              bottom: 0,
              left: (MediaQuery.of(context).size.width - 372) / 2,
              child: Container(
                width: 372,
                height: 70, // Sesuaikan tinggi berdasarkan ukuran layar
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 0
                                ? Color(0xfe00A550)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/img/Home.svg',
                              color: _selectedIndex == 0
                                  ? Colors.black
                                  : Colors
                                      .grey, // Warna ikon saat dipilih dan tidak dipilih
                              width: 32,
                            ),
                          ),
                        ),
                        label: '', // Tidak ada label
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 1
                                ? Color(0xfe00A550)
                                : Colors.transparent, // Warna saat dipilih
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/img/Heart.svg',
                              color: _selectedIndex == 1
                                  ? Colors.black
                                  : Colors
                                      .grey, // Warna ikon saat dipilih dan tidak dipilih
                              width: 32,
                            ),
                          ),
                        ),
                        label: '', // Tidak ada label
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 2
                                ? Color(0xfe00A550)
                                : Colors.transparent, // Warna saat dipilih
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/img/Send.svg',
                              color: _selectedIndex == 2
                                  ? Colors.black
                                  : Colors.grey,
                              width: 32,
                            ),
                          ),
                        ),
                        label: '', // Tidak ada label
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 3
                                ? Color(0xfe00A550)
                                : Colors.transparent, // Warna saat dipilih
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/img/User.svg',
                              color: _selectedIndex == 3
                                  ? Colors.black
                                  : Colors.grey,
                              width: 32,
                            ),
                          ),
                        ),
                        label: '', // Tidak ada label
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: const Color.fromARGB(
                        255, 0, 0, 0), // Warna ikon saat dipilih
                    unselectedItemColor:
                        Colors.grey, // Warna ikon tidak dipilih
                    onTap: _onItemTapped,
                    showSelectedLabels: false, // Sembunyikan label terpilih
                    showUnselectedLabels:
                        false, // Sembunyikan label tidak terpilih
                    backgroundColor: Colors
                        .transparent, // Warna latar belakang navigation bar
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 30,
          ),
          _buildSearch(),
          SizedBox(height: 10),
          _buildRecomendationSearch(),
          SizedBox(height: 20),
          _buildSectionTitle("Recommended", "Explore"),
          SizedBox(height: 10),
          _buildHorizontalList(),
          SizedBox(height: 10),
          _buildSectionTitle("Popular Activities", "see All"),
          _buildPopularActivities(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Center(
      child: Center(
        child: Row(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 355,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
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
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none, // Hilangkan border default
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onChanged: (value) {
                        // Tangkap teks yang diketik di sini
                        print("User is typing: $value");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecomendationSearch() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 35,
          decoration: BoxDecoration(
            color: Color(0xfe00A550),
            border: Border.all(
              color: Color(0xfe00A550),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Spacer(),
        Container(
          width: 80,
          height: 35,
          decoration: BoxDecoration(
            color: Color(0xfe00A550),
            border: Border.all(
              color: Color(0xfe00A550),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Spacer(),
        Container(
          width: 80,
          height: 35,
          decoration: BoxDecoration(
            color: Color(0xfe00A550),
            border: Border.all(
              color: Color(0xfe00A550),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Spacer(),
        Container(
          width: 80,
          height: 35,
          decoration: BoxDecoration(
            color: Color(0xfe00A550),
            border: Border.all(
              color: Color(0xfe00A550),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          actionText,
          style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildHorizontalList() {
    final recommendations = [
      {
        "image":
            "assets/img/Ratenggaro-village-in-Sumba-Explore-Sumba-island-villages-in-Indonesia-10.jpg",
        "title": "Sumba Island",
        "location": "East Nusa Tenggara",
        "rating": "4.9",
      },
      {
        "image": "assets/img/bali.png",
        "title": "            Bali Island",
        "location": "Bali",
        "rating": "4.8",
      },
      {
        "image": "assets/img/lombok.jpg",
        "title": "Lombok Island",
        "location": "West Nusa Tenggara",
        "rating": "4.7",
      },
    ];

    return SizedBox(
      height: 220, // Sesuaikan ukuran ini dengan kebutuhan
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return _buildRecommendationCard(recommendations[index]);
        },
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, String> recommendation) {
    // Variabel untuk menyimpan status favorit
    bool isFavorite = false;

    return GestureDetector(
      onTap: () {
        // Ubah status favorit saat diklik
        isFavorite = !isFavorite;
        // Panggil setState agar UI diperbarui
        // Jika menggunakan StatefulWidget, kamu bisa panggil setState di sini
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        width: 207,
        height: 249,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                recommendation["image"]!,
                width: 210,
                height: 249,
                fit: BoxFit.cover,
              ),
            ),

            // Overlay untuk teks di bagian bawah
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      recommendation["title"]!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),

                    // Lokasi
                    Row(
                      children: [
                        Image.asset('assets/img/Map Pin.png',
                            width: 12, height: 12),
                        SizedBox(width: 4),
                        Text(
                          recommendation["location"]!,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),

                    // Rating
                    Row(
                      children: [
                        SvgPicture.asset('assets/img/star.svg',
                            width: 12, height: 12),
                        SizedBox(width: 4),
                        Text(
                          recommendation['rating']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Lingkaran dengan ikon favorit di atas gambar
            Positioned(
              top: 10,
              right: 10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Lingkaran
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
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  // Ikon favorit
                  SvgPicture.asset(
                    'assets/img/favorite.svg',
                    width: 24,
                    height: 24,
                    color: isFavorite
                        ? Colors.red
                        : Colors
                            .black, // Mengubah warna berdasarkan status favorit
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularActivities() {
    final popularActivities = [
      {
        "image": "assets/img/91.png",
        "title": "Raja Ampat",
        "location": "West Papua",
        "rating": "5.0",
        "price": "\$250.00",
      },
      {
        "image":
            "assets/img/Lombok-to-Komodo-Island-4-Days-3-Night-Amazing-Trip.png",
        "title": "Komodo Island",
        "location": "East Nusa Tenggara",
        "rating": "4.9",
        "price": "\$300.00",
      },
      {
        "image": "assets/img/gili-islands-digital-nomads.png",
        "title": "Gili Islands",
        "location": "Lombok",
        "rating": "4.8",
        "price": "\$180.00",
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: popularActivities.length,
      itemBuilder: (context, index) {
        return _buildPopularActivityCard(popularActivities[index]);
      },
    );
  }

  Widget _buildPopularActivityCard(Map<String, String> activity) {
    return Container(
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
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ]),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              activity["image"]!,
              fit: BoxFit.cover,
              width: 111,
              height: 135, // Sesuaikan ukuran sesuai kebutuhan
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Mulai dari kiri
              children: [
                Row(
                  children: [
                    Text(
                      activity["title"]!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      'assets/img/favorite.svg',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset('assets/img/star.svg'),
                    Text(
                      activity['rating']!,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  activity["price"]!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "A resort is a place used for vacation, relaxation, or as a day....",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Order extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/img/91.png",
            width: 393,
            height: 400,
          ),
          Container(
            width: 71,
            height: 15,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
