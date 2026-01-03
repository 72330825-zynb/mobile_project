import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'final_class.dart';

class PlaceDetailPage extends StatefulWidget {
  final int placeId;

  const PlaceDetailPage({super.key, required this.placeId});

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  PlaceDetailsModel? place;
  bool loading = true;

  final String baseUrl = "https://mobile-project-1-ab63.onrender.com";
  final String supabaseUrl =
      "https://vetdooxhwfezufdzzean.supabase.co/storage/v1/object/public/places/";

  @override
  void initState() {
    super.initState();
    loadPlace();
  }

  Future<void> loadPlace() async {
    final res =
        await http.get(Uri.parse("$baseUrl/place_details/${widget.placeId}"));

    if (res.statusCode == 200) {
      setState(() {
        place = PlaceDetailsModel.fromMap(jsonDecode(res.body));
        loading = false;
      });
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || place == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final imageUrl = "$supabaseUrl${place!.image}";

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Cafe / Restaurant'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    place!.title,
                    style: GoogleFonts.dmSerifText(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 20,
                            color: index < place!.rating
                                ? Colors.amber
                                : Colors.grey,
                          ),
                        ),
                      ),
                      Icon(
                        place!.favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.comment),
                            hintText: 'Comment',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Menu",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
