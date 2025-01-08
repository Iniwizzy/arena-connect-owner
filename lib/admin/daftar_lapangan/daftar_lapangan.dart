import 'package:arena_connect/admin/config/theme.dart';
import 'package:arena_connect/admin/model/res_field.dart';
import 'package:flutter/material.dart';
import 'package:arena_connect/api/api.dart';
import 'package:http/http.dart' as http;

class ListFields extends StatefulWidget {
  const ListFields({super.key});

  @override
  State<ListFields> createState() => _ListFieldsState();
}

class _ListFieldsState extends State<ListFields> {
  bool isLoading = false;
  List<Field> listField = [];
  List<Field> filteredField = [];
  // List<FieldCentre> listFieldCentre = [];
  // List<FieldCentre> filteredFieldCentre = [];
  String searchQuery = '';

  Future<void> getField() async {
    try {
      setState(() {
        isLoading = true;
      });

      String? token = await ApiService().getToken();
      String? userId = await ApiService().getUserId();

      debugPrint('User ID: $userId');

      if (token == null) {
        throw Exception('Token not found');
      }

      http.Response res = await http.get(
        Uri.parse("$baseUrl/fields"),
        headers: {'Authorization': 'Bearer $token'},
      );

      List<Field>? data = resFieldFromJson(res.body).data;

      // Filter lapangan berdasarkan field_centre_id yang sama dengan userId
      List<Field> userFields = data?.where((field) {
            // Konversi userId ke integer untuk perbandingan yang tepat
            int? userIdInt = int.tryParse(userId ?? '');
            debugPrint(
                'Comparing field.fieldCentreId: ${field.fieldCentreId} with userId: $userIdInt');
            return field.fieldCentreId == userIdInt;
          }).toList() ??
          [];

      debugPrint('Filtered fields length: ${userFields.length}');

      setState(() {
        isLoading = false;
        listField = userFields;
        filteredField = listField;
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  // get index => null;

  @override
  void initState() {
    super.initState();
    getField();
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredField = listField
          .where((field) =>
              field.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> filteredFieldUser = filteredField
    //     .where((field) => field.name == field.fieldCentreId)
    //     .toList();
    // debugPrint(filteredFieldUser as String?);
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
                  itemCount: filteredField.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // padding: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
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
                                        image: NetworkImage(filteredField[index]
                                            .fieldCentre
                                            .images[1]),
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
                                    filteredField[index].name,
                                    style: lampiranStyle,
                                  ),
                                  Text(
                                    filteredField[index].fieldCentre.address,
                                    style: ketStyle,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            _getIconForFieldType(filteredField[
                                                    index]
                                                .type), // Langsung gunakan string type
                                            const SizedBox(width: 8),
                                            Text(
                                              filteredField[index]
                                                  .type, // Langsung gunakan string type
                                              style: facilityStle.copyWith(
                                                  fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mulai Rp.${filteredField[index].fieldCentre.priceFrom}/Jam',
                                        style: const TextStyle(
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
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
                                  // const SizedBox(height: 5),
                                  // Center(
                                  //   child: SizedBox(
                                  //     width: 200,
                                  //     child: SizedBox(
                                  //       height: 40,
                                  //       child: ElevatedButton(
                                  //         onPressed: () {},
                                  //         style: shortButton3,
                                  //         child: Text(
                                  //           'Lihat Status Lapangan',
                                  //           style: buttonTextStyle,
                                  //           textAlign: TextAlign.center,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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

  Widget _getIconForFieldType(String type) {
    switch (type.toLowerCase()) {
      case 'Futsal':
        return const Icon(Icons.sports_soccer, size: 10);
      case 'Basket':
        return const Icon(Icons.sports_basketball, size: 10);
      case 'Voli':
        return const Icon(Icons.sports_volleyball, size: 10);
      case 'Badminton':
        return const Icon(Icons.sports_tennis, size: 10);
      default:
        return const Icon(Icons.sports, size: 10);
    }
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
                Navigator.pushNamed(context, '/tambahlapangan');
              },
            ),
          ),
        ],
      ),
    );
  }
}
