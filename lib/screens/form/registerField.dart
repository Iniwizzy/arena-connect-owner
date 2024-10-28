import 'package:flutter/material.dart';
import 'package:arena_connect/config/theme.dart';

class RegisterField extends StatefulWidget {
  const RegisterField({Key? key}) : super(key: key);

  @override
  _RegisterFieldState createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  Map<String, bool> selectedFacilities = {
    'Toilet': false,
    'WiFi': false,
    'Parkir Mobil': false,
    'Parkir Motor': false,
    'Musolla': false,
  };

  // Fungsi untuk menampilkan bottom sheet untuk memilih fasilitas
  void _showFacilitiesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pilih Fasilitas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              ...selectedFacilities.keys.map((facility) {
                return CheckboxListTile(
                  title: Text(facility),
                  value: selectedFacilities[facility],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedFacilities[facility] = value ?? false;
                    });
                  },
                );
              }).toList(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Simpan'),
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
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Aksi ketika ikon kembali diklik
            // Navigator.pop(context); // Menavigasi kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Tambah Lapangan",
              style: superFont2.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 27),
            buildInputField(labelText: "Nama Lapangan"),
            const SizedBox(height: 24),
            buildInputField(labelText: "Jenis Lapangan"),
            const SizedBox(height: 24),
            buildInputField(labelText: "Deskripsi"),
            const SizedBox(height: 24),

            // Input Fasilitas dengan onTap
            GestureDetector(
              onTap: () => _showFacilitiesBottomSheet(context),
              child: AbsorbPointer(
                child: buildInputField(
                  labelText: "Fasilitas",
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: selectedFacilities.entries
                  .where((entry) => entry.value)
                  .map((entry) => Chip(label: Text(entry.key)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInputField({
  required String labelText,
  TextInputType inputType = TextInputType.text,
}) {
  return TextFormField(
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: tertiary,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: tertiary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
    style: superFont4,
  );
}
