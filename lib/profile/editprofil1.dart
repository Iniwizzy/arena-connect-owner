import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() => runApp(EditProfile1Screen());

class EditProfile1Screen extends StatefulWidget {
  const EditProfile1Screen({super.key});

  @override
  _EditProfile1ScreenState createState() => _EditProfile1ScreenState();
}

class _EditProfile1ScreenState extends State<EditProfile1Screen> {
  final Color darkBlue = const Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = const Color.fromRGBO(72, 157, 214, 1);
  final Color greyColor = const Color(0xFFA7ADC3);
  String? selectedGender;
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

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
            Navigator.pushNamed(context, '/profil1');
          },
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: darkBlue,
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 29,
                          backgroundImage: AssetImage('images/galeri6.jpg'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _showProfilePhotoOptions(context);
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
                          'Brian',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'brianss123@gmail.com',
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
          // const Spacer(),
          Expanded(
            child: Container(
              height: 500,

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
                  _buildCustomDropdownField(),
                  const SizedBox(height: 16),
                  _buildCustomDatePickerField(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightBlue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      _showConfirmationDialog(
                          context); // Tampilkan popup konfirmasi
                    },
                    child: Center(
                      child: Text(
                        "Perbarui Profil",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Center(
            child: Text(
              'Simpan Perubahan',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin menyimpan perubahan?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: darkBlue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup dialog
                    },
                    child: Text(
                      'Kembali',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: lightBlue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Lakukan aksi simpan di sini
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

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
                leading: Icon(Icons.camera_alt, color: darkBlue),
                title: const Text('Ambil Foto'),
                onTap: () {
                  // Handle photo capture
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: darkBlue),
                title: const Text('Ambil dari Galeri'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: darkBlue),
                title: const Text('Hapus Foto'),
                onTap: () {
                  // Handle photo deletion
                },
              ),
            ],
          ),
        );
      },
    );
  }

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

  Widget _buildTextField({required String label, required IconData icon}) {
    return TextField(
      style: TextStyle(color: greyColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.7),
        ),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: darkBlue,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }

  Widget _buildCustomDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: darkBlue,
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
                  iconSize: 0,
                  hint: Text(
                    'Jenis Kelamin',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                  dropdownColor: darkBlue,
                  items: [
                    DropdownMenuItem(
                      value: 'Laki-Laki',
                      child: Text('Laki-Laki',
                          style: GoogleFonts.poppins(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: 'Perempuan',
                      child: Text('Perempuan',
                          style: GoogleFonts.poppins(color: Colors.white)),
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
                fontSize: 14, // Set font size same as Nama Depan, etc.
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
