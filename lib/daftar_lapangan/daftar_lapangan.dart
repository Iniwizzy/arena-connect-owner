import 'package:arena_connect/config/theme.dart';
import 'package:arena_connect/model/res_field_centres.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';

class ListFields extends StatefulWidget {
  const ListFields({super.key});

  @override
  State<ListFields> createState() => _ListFieldsState();
}

class _ListFieldsState extends State<ListFields> {
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

  // get index => null;

  @override
  void initState() {
    super.initState();
    getFieldCentres();
  }

  // Future<void> getFieldCentres() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     String? token = await ApiService().getToken();
  //     if (token == null) throw Exception('Token not found');

  //     final response = await http.get(
  //       Uri.parse("$baseUrl/field_centres"),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );

  //     if (response.statusCode == 200) {
  //       List<FieldCentre>? data = resFieldCentresFromJson(response.body).data;
  //       setState(() {
  //         listFieldCentre = data ?? [];
  //         filteredFieldCentre = listFieldCentre;
  //       });
  //     } else {
  //       throw Exception('Failed to load field centres');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //         backgroundColor: Colors.red, // Changed to red for error indication
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredFieldCentre = listFieldCentre
          .where((fieldCentre) => fieldCentre.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        padding: const EdgeInsets.only(top: 30, left: 15),
        height: 100,
        color: const Color.fromRGBO(18, 33, 92, 1),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Daftar Lapangan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
          children: [
            searchBar(),
            const SizedBox(height: 3),
          ],
        ),
      ),
      Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: primary))
              : ListView.builder(
                  itemCount: filteredFieldCentre.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // padding: const EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        height: 320,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jamsewa');
                              },

                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
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
                                  )
                                ],
                              ),
                              // child: Column(
                              //   children: [ ClipRRect(
                              //   borderRadius: const BorderRadius.only(
                              //     topLeft: Radius.circular(8),
                              //     topRight: Radius.circular(8),
                              //   ),
                              //     image: DecorationImage(
                              //       image: NetworkImage(
                              //           filteredFieldCentre[index]
                              //               .images[0]),
                              //       fit: BoxFit.cover,
                              //     ),)];
                              //       // : Container(
                              //       //     height: 150,
                              //       //     width: double.infinity,
                              //       //     color: Colors.grey[300],
                              //       //     child: const Icon(Icons.image_not_supported),
                              //       //   ),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredFieldCentre[index].name,
                                    style: lampiranStyle,
                                  ),
                                  Text(
                                    filteredFieldCentre[index].address,
                                    style: ketStyle,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: filteredFieldCentre[index]
                                        .facilities
                                        .map((facility) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            if (facility == 'Futsal') ...[
                                              const Icon(Icons.sports_soccer,
                                                  size: 10),
                                              const SizedBox(width: 5),
                                            ] else if (facility ==
                                                'Badminton') ...[
                                              const Icon(
                                                  MingCute.badminton_line,
                                                  size: 10),
                                              const SizedBox(width: 5),
                                            ] else if (facility ==
                                                'Volley') ...[
                                              const Icon(
                                                  Icons
                                                      .sports_volleyball_outlined,
                                                  size: 10),
                                              const SizedBox(width: 5),
                                            ] else if (facility ==
                                                'Basketball') ...[
                                              const Icon(
                                                  Icons
                                                      .sports_basketball_outlined,
                                                  size: 10),
                                              const SizedBox(width: 5),
                                            ],
                                            Text(facility,
                                                style: facilityStle,
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mulai Rp.${filteredFieldCentre[index].priceFrom.toString()}/Jam',
                                        style: const TextStyle(
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.grey, size: 18),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Center(
                                    child: SizedBox(
                                      width: 200,
                                      child: SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: shortButton3,
                                          child: Text(
                                            'Lihat Status Lapangan',
                                            style: buttonTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
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
                    );
                  }))
    ]));
  }

  Widget searchBar() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                hintText: 'Cari lapangan yang dikelola',
                hintStyle: cariStyle,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 149, 149, 149),
                    width: 0.8,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 0.8),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.grey),
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pushNamed(context, '/daftarlapangan');
              },
            ),
          ),
        ],
      ),
    );
  }
}
