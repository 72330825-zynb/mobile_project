import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'final_class.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final String supabaseBaseUrl =
      "https://vetdooxhwfezufdzzean.supabase.co/storage/v1/object/public/places_images";

  @override
  void initState() {
    super.initState();
    loadPlace();
  }

  // ================= LOAD PLACE =================
  Future<void> loadPlace() async {
    try {
      final res =
          await http.get(Uri.parse("$baseUrl/final/${widget.placeId}"));

      if (res.statusCode == 200) {
        setState(() {
          place = PlaceDetailsModel.fromMap(jsonDecode(res.body));
          loading = false;
        });
      } else {
        loading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      loading = false;
    }
  }

  // ================= OPEN MENU LINK =================
  Future<void> openMenuLink(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || place == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                  // ================= IMAGE =================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '$supabaseBaseUrl/${place!.image}',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ================= TITLE =================
                  Text(
                    place!.title,
                    style: GoogleFonts.dmSerifText(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ================= RATING + FAVORITE =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < place!.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                      Icon(
                        place!.favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color(0xFF373854),
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ================= COMMENT + MENU =================
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.comment),
                            hintText: 'Comment',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      GestureDetector(
                        onTap: () {
                          openMenuLink(place!.menu);
                        },
                        child: Container(
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
