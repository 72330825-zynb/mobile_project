import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'heritage_class.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsHerPage extends StatefulWidget {
  final int heritageId;

  const DetailsHerPage({super.key, required this.heritageId});

  @override
  State<DetailsHerPage> createState() => _DetailsHerPageState();
}

class _DetailsHerPageState extends State<DetailsHerPage> {
  String activeTab = "story";
  HeritageDetailsModel? heritage;
  bool loading = true;

  final String baseUrl = "https://mobile-project-1-ab63.onrender.com"; 
  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/details_her/${widget.heritageId}"),
      );

      if (res.statusCode == 200) {
        setState(() {
          heritage = HeritageDetailsModel.fromMap(jsonDecode(res.body));
          loading = false;
        });

        // 🔹 debugPrint للرابط
        debugPrint('IMAGE FROM SERVER: ${heritage!.image}');
      } else {
        debugPrint('Failed to load heritage details: ${res.statusCode}');
        setState(() => loading = false);
      }
    } catch (e) {
      debugPrint('Error fetching heritage details: $e');
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {


       final supabaseBaseUrl =
        'https://vetdooxhwfezufdzzean.supabase.co/storage/v1/object/public/places_images';


    if (loading || heritage == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

   
    final contentMap = {
      "story": heritage!.story,
      "cost": heritage!.cost,
      "weather": heritage!.weather,
    };

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Image.network(
              '$supabaseBaseUrl/${heritage!.image}',
              width: double.infinity,
              height: 120, // نفس ارتفاع الصورة في PlaceCard
              fit: BoxFit.cover,
            
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('IMAGE LOAD ERROR: $error');
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  );
                },
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 300),
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heritage!.title,
                    style: GoogleFonts.dmSerifText(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTab("Story"),
                      buildTab("Cost"),
                      buildTab("Weather"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    contentMap[activeTab] ?? "",
                    style: GoogleFonts.atkinsonHyperlegible(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTab(String title) {
    final key = title.toLowerCase();
    final isActive = activeTab == key;

    return GestureDetector(
      onTap: () => setState(() => activeTab = key),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive
                  ? const Color(0xFF373854)
                  : Colors.black,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF373854),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}