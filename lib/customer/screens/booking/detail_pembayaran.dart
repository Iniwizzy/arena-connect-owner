import 'dart:async';
import 'dart:io';
import 'package:arena_connect/customer/models/res_bank.dart';
import 'package:arena_connect/customer/screens/booking/bukti_booking_lap.dart';
import 'package:arena_connect/customer/screens/booking/pembayaran.dart';
import 'package:arena_connect/customer/screens/field-search/select_schedule.dart';
import 'package:arena_connect/customer/screens/history/history.dart';
import 'package:arena_connect/customer/screens/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/customer/config/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:arena_connect/api/api.dart';
import 'package:arena_connect/customer/models/booking.dart';

class PaymentScreen extends StatefulWidget {
  final int paymentId;
  final int totalPayment;
  final BookingData bookingData;
  final String orderId;
  final int bankId;
  final List<Bank> banks;

  const PaymentScreen({
    super.key,
    required this.paymentId,
    required this.totalPayment,
    required this.bookingData,
    required this.orderId,
    required this.bankId,
    required this.banks,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File? receipt;
  bool isUploading = false;
  bool isUploadButtonEnabled = true;
  Duration _remainingTime = const Duration(minutes: 60, seconds: 0);
  Timer? _timer;

  String getBankName(int bankId) {
    final bank = widget.banks.firstWhere((bank) => bank.id == bankId,
        orElse: () => Bank(
            id: 0,
            userId: 0,
            bankName: "Unknown",
            accountNumber: "",
            fieldCentreId: 0,
            createdAt: null,
            updatedAt: null));
    return '${bank.bankName} - ${bank.accountNumber}';
  }

  Future<void> rejectPayment() async {
    var response = await ApiService().updatePayment(
      paymentId: widget.paymentId,
      userId: widget.bookingData.userId,
      bookingId: widget.bookingData.id,
      totalPayment: widget.totalPayment.toString(),
      status: 'Ditolak',
      orderId: widget.orderId,
      bankId: widget.bankId,
    );

    if (response['success']) {
      debugPrint('Pembayaran ditolak: ${response['data']}');
      Navigator.pushNamed(context, '/homepage');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pembayaran ditolak karena waktu habis'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      debugPrint('Gagal mengubah status pembayaran: ${response['errors']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Gagal mengubah status pembayaran: ${response['errors']}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        } else {
          _timer?.cancel();
          rejectPayment();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> pickReceipt() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        receipt = File(image.path);
        isUploadButtonEnabled = true; // Enable tombol kirim saat gambar dipilih
      });
      debugPrint('Image path: ${image.path}');
      debugPrint('Image size: ${await image.length()} bytes');
      debugPrint('Image mime type: ${image.mimeType}');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    setState(() {
      isUploading = true;
    });

    var response = await ApiService().uploadReceipt(
      paymentId: widget.paymentId,
      bankId: widget.bankId,
      userId: widget.bookingData.userId,
      bookingId: widget.bookingData.id,
      totalPayment: widget.totalPayment.toString(),
      status: 'Proses',
      orderId: widget.orderId,
      receiptPath: imageFile.path,
    );

    setState(() {
      isUploading = false;
    });

    if (response['success']) {
      setState(() {
        isUploadButtonEnabled = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Pembayaran berhasil diupload! Tunggu verifikasi dari admin, ya 😊'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 6),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BuktiBookingLapangan(
            paymentId: response['data']['id'],
          ),
        ),
      );
    } else {
      debugPrint('Gagal mengupload bukti pembayaran: ${response['errors']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Gagal mengupload bukti pembayaran: ${response['errors']}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget buildCircleIcon(IconData icon, String label,
      {Color? backgroundColor, Color? iconColor = Colors.white}) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? const Color(0xFF12215c),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: 28,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: buttonFont6,
      ),
    ]);
  }

  File? image;
  bool imageSelected = false;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
        imageSelected = true; // Set flag menjadi true jika gambar sudah dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'images/top-wave-cropped.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pembayaran(
                                    paymentId: widget.paymentId,
                                    totalPayment: widget.totalPayment,
                                    bookingData: widget.bookingData,
                                    orderId: widget.orderId),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 40),
                            child: buildCircleIcon(
                                Icons.calendar_month_outlined, "Pilih Jadwal"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: CustomPaint(
                          painter: DashedLinePainter(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: buildCircleIcon(
                              Icons.list_alt_rounded,
                              "Detail Booking",
                              backgroundColor: primary,
                              iconColor: white,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: CustomPaint(
                          painter: DashedLinePainter(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 40),
                            child: buildCircleIcon(
                                Icons.payments_outlined, "Pembayaran",
                                backgroundColor: white, iconColor: primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 185,
                left: 8,
                right: 8,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Menunggu Pembayaran',
                                style: superFont2,
                              ),
                              Icon(Icons.access_time, color: primary),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Selesaikan pembayaran sebelum',
                                style: regulerFont1.copyWith(
                                    color: secondary, fontSize: 12),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFA8E911),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Text(
                                    '${_remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                    style:
                                        regulerFont1.copyWith(color: primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          CustomPaint(
                            painter:
                                DashedLinePainter(color: Colors.grey.shade400),
                            size: Size(MediaQuery.of(context).size.width, 1),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BAYAR MELALUI: ${getBankName(widget.bankId)}',
                                      style: superFont4,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Order ID: ${widget.orderId}',
                                      style: regulerFont1.copyWith(
                                          color: secondary, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: superFont3.copyWith(color: primary),
                              ),
                              Text(
                                'Rp${widget.totalPayment}',
                                style: superFont2.copyWith(color: primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 485,
                left: 8,
                right: 8,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20), // Margin lebih kecil
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Menampilkan gambar jika sudah dipilih
                          if (image != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      20), // Spasi antara gambar dan tombol kirim
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200, // Menjaga agar gambar proporsional
                              ),
                            ),

                          // Menampilkan tombol kirim jika gambar sudah dipilih

                          Container(
                            margin: const EdgeInsets.only(
                                top: 10), // Menambahkan jarak dari elemen atas
                            alignment:
                                Alignment.centerRight, // Posisi tombol di kanan
                            child: image !=
                                    null // Periksa apakah gambar sudah diinput
                                ? ElevatedButton.icon(
                                    onPressed: isUploadButtonEnabled
                                        ? () async {
                                            await uploadImage(
                                                image!); // Logika pengiriman
                                          }
                                        : null,
                                    label: Text(
                                      'Kirim',
                                      style: superFont3.copyWith(color: white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 18.0),
                                      backgroundColor: isUploadButtonEnabled
                                          ? secondary
                                          : Colors.grey, // Ubah warna tombol
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),

                          // Tombol upload hanya tampil jika gambar belum dipilih
                          if (!imageSelected)
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.upload,
                                      color: primary, size: 27),
                                  onPressed: () async {
                                    await getImage(); // Pilih gambar
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Upload Bukti Pembayaran',
                                      style: superFont2),
                                ),
                              ],
                            ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget scheduleChooseIcon() {
    return IconButton(
      icon: const Icon(Icons.calendar_month_outlined),
      color: primary,
      onPressed: null,
      disabledColor: Colors.white,
    );
  }

  Widget bookingDetailIcon() {
    return IconButton(
      icon: const Icon(Icons.list_alt_rounded),
      color: primary,
      onPressed: null,
      disabledColor: Colors.white,
    );
  }

  Widget paymentIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: IconButton(
            icon: const Icon(Icons.payments_outlined),
            color: primary,
            onPressed: null,
            disabledColor: primary,
          ),
        ),
      ],
    );
  }

  Widget buildDashedLine() {
    return Transform.translate(
      offset: const Offset(0, -10),
      child: SizedBox(
        width: 60,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                10,
                (index) => const SizedBox(
                  width: 3,
                  height: 2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
