import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/app/data/Databese_Service.dart';
import 'package:project_flutter/app/data/Destination.dart';
import 'package:project_flutter/app/data/cloudinactory_service.dart';
import 'package:project_flutter/app/modules/addDest/controllers/offline.dart';
import 'package:project_flutter/app/modules/admin/views/checkimageurl.dart';
import 'package:project_flutter/app/modules/admin/views/checkimageurl.dart';

class EditProduct extends StatefulWidget {
  final Map<String, dynamic> destinationData;

  EditProduct({required this.destinationData});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final Connectivity _connectivity = Connectivity();
  final DatabaseService _databaseService = DatabaseService();
  final GetStorage _getStorage = GetStorage();

  final OfflineDataSyncService _offlineDataSyncService =
      OfflineDataSyncService();

  late TextEditingController _sumbaIslandController;
  late TextEditingController _locationController;
  late TextEditingController _ratingController;
  late TextEditingController _priceController;
  late List<TextEditingController> _amenitiesControllers;
  late TextEditingController _selfCheckInController;
  late TextEditingController _cleanAccommodationController;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final CloudinaryService _cloudinaryService = CloudinaryService();
  String? imageUrl;
  bool isImageAvailable = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    _sumbaIslandController =
        TextEditingController(text: widget.destinationData['name']);
    _locationController =
        TextEditingController(text: widget.destinationData['location']);
    _ratingController = TextEditingController(
        text: widget.destinationData['rating'].toString());
    _priceController =
        TextEditingController(text: widget.destinationData['price'].toString());
    _selfCheckInController =
        TextEditingController(text: widget.destinationData['selfCheckIn']);
    _cleanAccommodationController = TextEditingController(
        text: widget.destinationData['cleanAccommodation']);
      imageUrl = widget.destinationData['img'];
        
    _amenitiesControllers = List.generate(
      5,
      (index) => TextEditingController(
          text: widget.destinationData['amenities']?[index] ?? ''),
    );
  }

  bool _validateAmenities() {
    for (var controller in _amenitiesControllers) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

  Future<void> _updateToFirebase() async {
    try {
      await _databaseService.updateDestination(
        docId: widget.destinationData['docId'], // Tambahkan ini
        name: _sumbaIslandController.text,
        location: _locationController.text,
        rating: double.parse(_ratingController.text),
        amenities: _amenitiesControllers.map((c) => c.text).toList(),
        price: double.parse(_priceController.text),
        selfCheckIn: _selfCheckInController.text,
        cleanAccommodation: _cleanAccommodationController.text,
        img: imageUrl ?? '',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Data berhasil diperbarui di Firebase Firestore!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data: $e')),
      );
    }
  }

  Future<void> _updateToGetStorage() async {
    try {
      await _getStorage.write('destination', {
        'name': _sumbaIslandController.text,
        'location': _locationController.text,
        'rating': _ratingController.text,
        'amenities': _amenitiesControllers.map((c) => c.text).toList(),
        'price': _priceController.text,
        'selfCheckIn': _selfCheckInController.text,
        'cleanAccommodation': _cleanAccommodationController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan di GetStorage!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }

  Future<void> _submitData() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_validateAmenities()) {
        setState(() {
          _isLoading = true;
        });

        try {
          var connectivityResult = await _connectivity.checkConnectivity();

          if (connectivityResult == ConnectivityResult.none) {
            await _updateToGetStorage();
          } else {
            await _updateToFirebase();
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating data: $e')),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill at least 5 amenities')),
        );
      }
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Take Photo"),
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);

                  if (pickedFile != null) {
                    Navigator.of(context).pop(); // Tutup popup sebelum upload

                    setState(() {
                      _isLoading = true;
                    });

                    String uploadedImageUrl =
                        await _cloudinaryService.uploadImage(pickedFile.path);
                    imageUrl = uploadedImageUrl;

                    // Cek apakah gambar tersedia di URL
                    bool isAvailable = await checkImageUrl(uploadedImageUrl);
                    setState(() {
                      isImageAvailable = isAvailable;
                      _isLoading =
                          false; // Matikan loading setelah selesai upload
                    });
                  } else {
                    Navigator.of(context)
                        .pop(); // Tutup popup jika batal pilih gambar
                    print('Tidak ada gambar yang diambil.');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Choose from Gallery"),
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    Navigator.of(context).pop(); // Tutup popup sebelum upload

                    setState(() {
                      _isLoading = true;
                    });

                    String uploadedImageUrl =
                        await _cloudinaryService.uploadImage(pickedFile.path);
                    imageUrl = uploadedImageUrl;

                    // Cek apakah gambar tersedia di URL
                    bool isAvailable = await checkImageUrl(uploadedImageUrl);
                    setState(() {
                      isImageAvailable = isAvailable;
                      _isLoading =
                          false; // Matikan loading setelah selesai upload
                    });
                  } else {
                    Navigator.of(context)
                        .pop(); // Tutup popup jika batal pilih gambar
                    print('Tidak ada gambar yang dipilih.');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Destination')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit
                                .cover, // Agar gambar memenuhi seluruh area
                          )
                        : null , // Jika belum ada gambar, biarkan kosong
                    color: Colors.grey[
                        300], // Warna latar belakang jika tidak ada gambar
                    borderRadius:
                        BorderRadius.circular(10), // Radius sudut kotak
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () => _showPicker(context),
                      child: SvgPicture.asset(
                        'assets/img/camera.svg',
                        color: const Color.fromARGB(255, 86, 86, 86),
                        width: 64.0,
                        height: 64.0,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _sumbaIslandController,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter destination';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _ratingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a valid rating';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Text(
                  'Amenities (min 5)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ..._amenitiesControllers.map((controller) {
                  return TextFormField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'Amenity'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amenity';
                      }
                      return null;
                    },
                  );
                }).toList(),
                SizedBox(height: 8),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitData,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Update Destination'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
