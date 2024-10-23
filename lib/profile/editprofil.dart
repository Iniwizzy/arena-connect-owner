import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color darkBlue = Color.fromRGBO(18, 33, 92, 1);
  final Color lightBlue = Color.fromRGBO(72, 157, 214, 1);
  final Color greyColor = Color(0xFFA7ADC3);
  String? selectedGender; // Stores the selected gender
  DateTime? selectedDate; // Stores the selected date of birth
  final TextEditingController _dateController =
      TextEditingController(); // Controller for date picker

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian informasi profil di atas
            Stack(
              children: [
                Container(
                  color: darkBlue,
                  padding: EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      // Avatar dengan ikon kamera di pojok kanan bawah
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 29,
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person,
                                size: 29, color: Colors.grey),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: lightBlue,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
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

            // Form edit profil
            Container(
              height: 5000,
              width: 2000,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  _buildTextField(label: "Nama Depan", icon: Icons.person),
                  SizedBox(height: 16),
                  _buildTextField(
                      label: "Nama Belakang", icon: Icons.person_outline),
                  SizedBox(height: 16),
                  _buildTextField(label: "Nomor HP", icon: Icons.phone),
                  SizedBox(height: 16),

                  // Dropdown for gender selection
                  _buildCustomDropdownField(),
                  SizedBox(height: 16),

                  // Date picker for date of birth
                  _buildCustomDatePickerField(),

                  SizedBox(height: 32),

                  // Tombol Perbarui Profil dengan ukuran lebih kecil
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightBlue,
                      padding: EdgeInsets.symmetric(
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darkBlue,
        unselectedItemColor: greyColor,
        currentIndex: 4, // Set tab Profil sebagai yang terpilih
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Pemesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: "Pembayaran",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Laporan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
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
          borderSide: BorderSide(
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.arrow_drop_down, color: Colors.white),
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
                contentPadding: EdgeInsets.symmetric(
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
              padding: EdgeInsets.symmetric(
                  horizontal:
                      12), // Adjusted padding for the icon to be consistent
              child: Icon(Icons.calendar_today, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
