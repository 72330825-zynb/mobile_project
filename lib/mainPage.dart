import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'destination_model.dart';
import 'area.dart';
import 'category.dart';
import 'place.dart';
import 'dropdown.dart';
import 'row_category.dart';
import 'section.dart';
import 'heritage.dart';
import 'heritage_card.dart';
import 'destination.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ===================== AREAS =====================
  List<Area> areas = [];
  Area? selectedArea;

  // ===================== CATEGORIES =====================
  Category? selectedCategory;

  // ===================== PLACES =====================
  List<Place> places = [];
  bool loadingPlaces = false;

  // ===================== HERITAGE =====================
  List<HeritageModel> heritages = [];
  bool loadingHeritage = false;

  // ===================== FEATURED DESTINATIONS =====================
  List<DestinationModel> featuredDestinations = [];
  bool loadingDestination = false;

  @override
  void initState() {
    super.initState();
    loadAreas();
    loadFeaturedDestinations();
  }

  // ===================== LOAD AREAS =====================
  Future<void> loadAreas() async {
    try {
      final res = await http.get(
        Uri.parse('http://192.168.1.108:3000/items'),
      );

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        setState(() {
          areas = data.map((e) => Area.fromMap(e)).toList();
          selectedArea = areas.isNotEmpty ? areas.first : null;
        });
      }
    } catch (e) {
      debugPrint('Error loading areas: $e');
    }
  }

  // ===================== LOAD PLACES =====================
  Future<void> loadPlaces() async {
    if (selectedArea == null || selectedCategory == null) return;

    setState(() => loadingPlaces = true);

    final uri = Uri.parse(
      'http://192.168.1.108:3000/places'
      '?area_id=${selectedArea!.id}'
      '&category_id=${selectedCategory!.id}',
    );

    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        setState(() {
          places = data.map((e) => Place.fromMap(e)).toList();
          loadingPlaces = false;
        });
      } else {
        setState(() => loadingPlaces = false);
      }
    } catch (e) {
      setState(() => loadingPlaces = false);
      debugPrint('Error loading places: $e');
    }
  }

  // ===================== LOAD HERITAGE =====================
  Future<void> loadHeritage() async {
    if (selectedArea == null || selectedCategory == null) return;

    setState(() => loadingHeritage = true);

    final uri = Uri.parse(
      'http://192.168.1.108:3000/heritage'
      '?area_id=${selectedArea!.id}'
      '&category_id=${selectedCategory!.id}',
    );

    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        setState(() {
          heritages =
              data.map<HeritageModel>((e) => HeritageModel.fromMap(e)).toList();
          loadingHeritage = false;
        });
      } else {
        setState(() => loadingHeritage = false);
      }
    } catch (e) {
      setState(() => loadingHeritage = false);
      debugPrint('Error loading heritage: $e');
    }
  }

  // ===================== LOAD FEATURED DESTINATIONS =====================
  Future<void> loadFeaturedDestinations() async {
    setState(() => loadingDestination = true);

    try {
      final res = await http.get(
        Uri.parse('http://192.168.1.108:3000/destination'),
      );

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        setState(() {
          featuredDestinations =
              data.map<DestinationModel>((e) => DestinationModel.fromMap(e)).toList();
          loadingDestination = false;
        });
      } else {
        setState(() => loadingDestination = false);
      }
    } catch (e) {
      setState(() => loadingDestination = false);
      debugPrint('Error loading destinations: $e');
    }
  }

  // ===================== UI =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Where do\nyou want to go?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // AREA DROPDOWN
                AreaDropdown(
                  areas: areas,
                  selectedArea: selectedArea,
                  onSelect: (area) {
                    setState(() => selectedArea = area);
                    loadPlaces();
                    loadHeritage();
                  },
                ),

                // فقط مسافة صغيرة
                const SizedBox(height: 8),

                // CATEGORY ROW
                CategorySelector(
                  onSelectCategory: (cat) {
                    setState(() => selectedCategory = cat);
                    loadPlaces();
                    loadHeritage();
                  },
                ),

                const SizedBox(height: 8), // فراغ صغير فقط

                // PLACES SECTION
                loadingPlaces
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: places
                              .map((p) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: PlaceCard(place: p),
                                  ))
                              .toList(),
                        ),
                      ),

                const SizedBox(height: 20), // فراغ بسيط قبل الهيريتج

                // HERITAGE SECTION
                loadingHeritage
                    ? const Center(child: CircularProgressIndicator())
                    : heritages.isEmpty
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
 // فراغ صغير فقط
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: heritages
                                      .map((h) => Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: HeritageCard(heritage: h),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),

                const SizedBox(height: 35),

                // FEATURED DESTINATIONS
                loadingDestination
                    ? const Center(child: CircularProgressIndicator())
                    : featuredDestinations.isEmpty
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Featured Destination',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: featuredDestinations
                                    .map(
                                      (d) => Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: FeaturedDestinationCard(destination: d),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



