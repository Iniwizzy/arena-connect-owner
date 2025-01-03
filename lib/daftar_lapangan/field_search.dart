import 'package:arena_connect/config/theme.dart';
// import 'package:arena_connect/screens/field-search/field_center_detail.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/model/res_field_centres.dart';
import 'package:arena_connect/api/api.dart';
import 'package:http/http.dart' as http;

class FieldSearch extends StatefulWidget {
  const FieldSearch({super.key});

  @override
  State<FieldSearch> createState() => _FieldSearchState();
}

class _FieldSearchState extends State<FieldSearch> {
  bool isLoading = false;
  List<FieldCentre> listFieldCentre = [];
  List<FieldCentre> filteredFieldCentre = [];
  String searchQuery = '';

  Future<void> getFieldCentres() async {
    try {
      setState(() {
        isLoading = true;
      });
      String? token = await ApiService().getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      http.Response res = await http.get(
        Uri.parse("$baseUrl/field_centres"),
        headers: {'Authorization': 'Bearer $token'},
      );
      List<FieldCentre>? data = resFieldCentresFromJson(res.body).data;
      setState(() {
        isLoading = false;
        listFieldCentre = data ?? [];
        filteredFieldCentre = listFieldCentre;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredFieldCentre = listFieldCentre
          .where((fieldcentre) => fieldcentre.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getFieldCentres();
  }

  // final List<String> imgList = [
  //   'images/badminton4.jpg',
  //   'images/badminton2.jpg',
  //   'images/futsal1.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(18, 33, 92, 1),
        title: const Text(
          'Daftar Lapangan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Cari Lapangan yang dikelola',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 4),
            //   child: OutlinedButton.icon(
            //     onPressed: () {
            //       _showFilterModal(context);
            //     },
            //     icon: const Icon(Icons.tune),
            //     label: Text(
            //       'Filter',
            //       style: regulerFont1,
            //     ),
            //     style: OutlinedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(6),
            //       ),
            //       side: BorderSide(color: primary),
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: primary),
                    )
                  : ListView.builder(
                      itemCount: filteredFieldCentre.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const FieldCenterDetails()),
                              // );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              elevation: 4.0,
                              child: Column(
                                children: [
                                  Container(
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(8.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            filteredFieldCentre[index]
                                                .images[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filteredFieldCentre[index]
                                                      .address,
                                                  style: regulerFont7,
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  filteredFieldCentre[index]
                                                          .name ??
                                                      'No Name',
                                                  style: superFont3,
                                                ),
                                                const SizedBox(height: 4),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(Icons.star,
                                                        color:
                                                            Colors.orangeAccent,
                                                        size: 20),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                        filteredFieldCentre[
                                                                    index]
                                                                .rating
                                                                .toString() ??
                                                            'N/A',
                                                        style: superFont1),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    _buildChip('Badminton',
                                                        Icons.sports_tennis),
                                                    const SizedBox(width: 8),
                                                    // _buildChip('Futsal',
                                                    //     Icons.sports_soccer),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Mulai',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: secondary),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(width: 6),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      filteredFieldCentre[index]
                                                          .priceFrom
                                                          .toString(),
                                                      style: superFont3,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
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
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 12, // Ukuran ikon
            color: Colors.white,
          ),
          const SizedBox(width: 7), // Jarak antara ikon dan teks
          Text(
            label,
            style: buttonFont6, // Ukuran teks
          ),
        ],
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: superFont2,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 10,
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Aktivitas',
                    style: superFont3,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: shortButtonPrimary,
                        child: Text(
                          'Hari Ini',
                          style: buttonFont5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: shortButtonPrimary,
                        child: Text(
                          'Besok',
                          style: buttonFont5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Aktivitas',
                    style: superFont3,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.sunny_snowing,
                          size: 12,
                        ),
                        label: Text(
                          'Pagi (6-10)',
                          style: buttonFont5,
                        ),
                        style: shortButtonPrimary,
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.sunny,
                          size: 12,
                        ),
                        label: Text(
                          'Siang (11-14)',
                          style: buttonFont5,
                        ),
                        style: shortButtonPrimary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.wb_sunny_outlined,
                          size: 12,
                        ),
                        label: Text(
                          'Sore (15-17)',
                          style: buttonFont5,
                        ),
                        style: shortButtonPrimary,
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.nightlight,
                          size: 12,
                        ),
                        label: Text(
                          'Malam (18-23)',
                          style: buttonFont5,
                        ),
                        style: shortButtonPrimary,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {},
                style: longButton1,
                child: Text('Terapkan', style: buttonFont5),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
