import 'dart:io';
import 'package:arena_connect/api/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:arena_connect/profile/galeri.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
// void main() => runApp(const EditProfileScreen());

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String userName = '';
  String userEmail = '';
  File? _profileImage;
  bool isLoading = true;

  final Color darkBlue = const Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = const Color.fromRGBO(72, 157, 214, 1);
  final Color greyColor = const Color(0xFFA7ADC3);
  String? selectedGender;
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final token = await ApiService().getToken();
    if (token != null) {
      final response = await ApiService().getUser(token);
      if (response['success']) {
        setState(() {
          userName = response['data']['name'];
          userEmail = response['data']['email'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: darkBlue,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Bagian informasi profil di atas
          Stack(
            children: [
              Container(
                color: darkBlue,
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    // Avatar dengan ikon kamera di pojok kanan bawah
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 29,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null, // Tampilkan gambar profil jika ada
                          child: _profileImage == null
                              ? const Icon(Icons.person,
                                  size: 40,
                                  color: Color.fromRGBO(18, 33, 92, 1))
                              : null, // Tampilkan ikon default jika tidak ada gambar
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _showProfilePhotoOptions(
                                  context); // Panggil fungsi untuk menampilkan opsi foto
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: lightBlue,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userEmail,
                          style: GoogleFonts.poppins(
                            color: greyColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Form edit profil
          Expanded(
            child: Container(
              // height: 5000,
              // width: 2000,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  _buildTextField(label: "Nama Depan", icon: Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(
                      label: "Nama Belakang", icon: Icons.person_outline),
                  const SizedBox(height: 16),
                  _buildTextField(label: "Nomor HP", icon: Icons.phone),
                  const SizedBox(height: 16),

                  // Dropdown for gender selection
                  _buildCustomDropdownField(),
                  const SizedBox(height: 16),

                  // Date picker for date of birth
                  _buildCustomDatePickerField(),

                  const SizedBox(height: 32),

                  // Tombol Perbarui Profil dengan ukuran lebih kecil
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightBlue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0, // Mengurangi ukuran padding vertikal
                        horizontal: 12.0, // Mengurangi padding horizontal
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Aksi saat tombol ditekan
                    },
                    child: Center(
                      child: Text(
                        "Perbarui Profil",
                        style: GoogleFonts.poppins(
                          fontSize: 14, // Optionally reduce font size
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigation(context),
    );
  }

// Bottom sheet untuk memilih foto profil
  void _showProfilePhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt,
                    color: Color.fromRGBO(18, 33, 92, 1)),
                title: const Text('Ambil Foto'),
                onTap: () async {
                  Navigator.pop(context); // Tutup modal
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    // _updateProfilePhoto(File(pickedFile.path));
                    _cropImage(File(pickedFile.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library,
                    color: Color.fromRGBO(18, 33, 92, 1)),
                title: const Text('Ambil dari Galeri'),
                onTap: () async {
                  Navigator.pop(context); // Tutup modal
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    _cropImage(File(pickedFile.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete,
                    color: Color.fromRGBO(18, 33, 92, 1)),
                title: const Text('Hapus Foto'),
                onTap: () {
                  Navigator.pop(context); // Tutup modal
                  _deleteProfileImage(); // Hapus gambar
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteProfileImage() {
    setState(() {
      _profileImage = null; // Setel kembali ke state awal
    });
  }

  Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // Rasio 1:1
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Gambar',
          toolbarColor: darkBlue,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: lightBlue,
          backgroundColor: Colors.black,
          lockAspectRatio: true, // Kunci rasio aspek 1:1
        ),
        IOSUiSettings(
          title: 'Crop Gambar',
          aspectRatioLockEnabled: true, // Kunci rasio aspek 1:1
        ),
      ],
    );

    if (croppedFile != null) {
      // Perbarui foto profil dengan hasil crop
      setState(() {
        // Simpan hasil cropping ke state untuk ditampilkan
        // ganti `userPhoto` dengan variabel foto profil Anda
        _profileImage = File(croppedFile.path);
      });

      // Jika Anda ingin mengunggah hasil crop ke server, tambahkan logika di sini
      // await _updateProfilePhoto(File(croppedFile.path));
    }
  }

// Fungsi untuk memperbarui foto profil
// void _updateProfilePhoto(File imageFile) async {
//   try {
//     // Simpan file ke state
//     setState(() {
//       // userPhoto = imageFile;
//     });

  // Upload file ke server
//     final token = await ApiService().getToken();
//     if (token != null) {
//       final response = await ApiService().uploadProfilePhoto(token, imageFile);
//       if (response['success']) {
//         // Jika upload berhasil, perbarui state atau tampilkan pesan sukses
//         setState(() {
//           // userPhoto = response['data']['photoUrl'];
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Foto profil berhasil diperbarui')),
//         );
//       } else {
//         // Tampilkan pesan jika upload gagal
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Gagal memperbarui foto profil')),
//         );
//       }
//     }
//   } catch (e) {
//     // Tangani error
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Terjadi kesalahan: $e')),
//     );
//   }
// }

// // Fungsi untuk menghapus foto profil
// void _deleteProfilePhoto() async {
//   try {
//     // Hapus foto dari server
//     final token = await ApiService().getToken();
//     if (token != null) {
//       final response = await ApiService().deleteProfilePhoto(token);
//       if (response['success']) {
//         // Jika penghapusan berhasil, reset foto profil di state
//         setState(() {
//           // userPhoto = null;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Foto profil berhasil dihapus')),
//         );
//       } else {
//         // Tampilkan pesan jika penghapusan gagal
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Gagal menghapus foto profil')),
//         );
//       }
//     }
//   } catch (e) {
//     // Tangani error
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Terjadi kesalahan: $e')),
//     );
//   }
// }

  Widget _BottomNavigation(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10), // Padding vertikal
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(context, '/home', Icons.home, "Beranda", false),
          _bottomNavItem(context, '/pesanan', Icons.book, "Pesanan", false),
          _bottomNavItem(
              context, '/pembayaran', Icons.payments_sharp, "Transaksi", false),
          _bottomNavItem(
              context, '/laporankeuangan', Icons.bar_chart, "Laporan", false),
          _bottomNavItem(context, '/profil', Icons.person, "Profil", true),
        ],
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, String route, IconData icon,
      String label, bool isActive) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF0D2C76) : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins', // Mengatur font menjadi Poppins
              fontSize: 12,
              color: isActive ? const Color(0xFF0D2C76) : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  // Widget untuk membuat TextField
  Widget _buildTextField({required String label, required IconData icon}) {
    return TextField(
      style: TextStyle(color: greyColor), // Set text color to grey
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.7), // White with some opacity
        ),
        prefixIcon:
            Icon(icon, color: Colors.white), // Change icon color to white
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.white, // Change border color to white
          ),
        ),
        filled: true,
        fillColor: darkBlue, // Change fill color to darkBlue
        floatingLabelBehavior:
            FloatingLabelBehavior.never, // Prevent label from floating
      ),
    );
  }

  // Widget for dropdown gender field with clickable icon
  Widget _buildCustomDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: darkBlue, // Set dark blue background for the dropdown field
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedGender,
                  iconSize: 0, // Hide the default arrow icon
                  hint: Text(
                    'Jenis Kelamin',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white
                          .withOpacity(0.7), // Slight transparency for the hint
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white, // White text for dropdown items
                  ),
                  dropdownColor:
                      darkBlue, // Change dropdown background to dark blue
                  items: [
                    DropdownMenuItem(
                      value: 'Laki-Laki',
                      child: Text(
                        'Laki-Laki',
                        style: GoogleFonts.poppins(
                            color: Colors.white), // White text for items
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Perempuan',
                      child: Text(
                        'Perempuan',
                        style: GoogleFonts.poppins(
                            color: Colors.white), // White text for items
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showDropdown(); // Custom function to show dropdown
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Icon(Icons.arrow_drop_down, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show dropdown manually
  void _showDropdown() {
    setState(() {
      FocusScope.of(context).unfocus(); // Close the keyboard
    });
  }

  // Widget for date picker with clickable icon only
  Widget _buildCustomDatePickerField() {
    return Container(
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _dateController,
              readOnly: true,
              style: GoogleFonts.poppins(
                fontSize: 16, // Set font size same as Nama Depan, etc.
                color: greyColor, // Set text color to grey
              ),
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                labelStyle: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14, // Set font size same as Nama Depan, etc.
                ),
                floatingLabelBehavior:
                    FloatingLabelBehavior.never, // Prevent floating
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12), // Same padding as other fields
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: lightBlue, // header background color
                        onPrimary: Colors.white, // header text color
                        onSurface: darkBlue, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: lightBlue, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                  _dateController.text =
                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      12), // Adjusted padding for the icon to be consistent
              child: const Icon(Icons.calendar_today, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
