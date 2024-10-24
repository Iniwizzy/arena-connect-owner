import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Lapangan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const TambahLapanganScreen(),
    );
  }
}

class TambahLapanganScreen extends StatefulWidget {
  const TambahLapanganScreen({super.key});

  @override
  _TambahLapanganScreenState createState() => _TambahLapanganScreenState();
}

class _TambahLapanganScreenState extends State<TambahLapanganScreen> {
  final _formKey = GlobalKey<FormState>();

  String? namaLapangan;
  String? jenisLapangan;
  String? hargaPerJam;
  String? deskripsi;
  String? fotoLapanganUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Lapangan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Lapangan Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Lapangan',
                  labelStyle: TextStyle(color: Color(0xFFA7ADC3)),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  namaLapangan = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama lapangan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Jenis Lapangan Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Jenis Lapangan',
                  labelStyle: TextStyle(color: Color(0xFFA7ADC3)),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.sports_soccer),
                ),
                onSaved: (value) {
                  jenisLapangan = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jenis lapangan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Harga Per Jam Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Harga per jam',
                  labelStyle: TextStyle(color: Color(0xFFA7ADC3)),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  hargaPerJam = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan harga per jam';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Deskripsi Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Color(0xFFA7ADC3)),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) {
                  deskripsi = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan deskripsi lapangan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Foto Lapangan (Upload)
              const Text('Foto lapangan'),
              const SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Logic untuk upload foto
                  setState(() {
                    fotoLapanganUrl =
                        'https://via.placeholder.com/150'; // Contoh gambar
                  });
                },
                icon: const Icon(Icons.upload),
                label: const Text('Upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF489dd6), // Warna tombol upload (biru muda)
                  foregroundColor: Colors.white, // Warna teks putih
                ),
              ),
              const SizedBox(height: 8.0),

              // Tampilkan gambar jika sudah di-upload
              fotoLapanganUrl != null
                  ? Image.network(fotoLapanganUrl!)
                  : Container(),

              const Spacer(),

              // Tombol Daftar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Logic untuk submit data
                    print("Nama: $namaLapangan");
                    print("Jenis: $jenisLapangan");
                    print("Harga: $hargaPerJam");
                    print("Deskripsi: $deskripsi");
                    print("Foto: $fotoLapanganUrl");
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor:
                      const Color(0xFFA7ADC3), // Warna tombol daftar (abu muda)
                  foregroundColor: Colors.white, // Warna teks putih
                ),
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// 
