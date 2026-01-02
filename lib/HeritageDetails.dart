import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'heritage_det_class.dart'; // استدعاء class البيانات

class HeritageDesign extends StatefulWidget {
  final int heritageId;

  const HeritageDesign({Key? key, required this.heritageId}) : super(key: key);

  @override
  State<HeritageDesign> createState() => _HeritageDesignState();
}

class _HeritageDesignState extends State<HeritageDesign> {
  late HeritageData heritageData;
  String activeTab = "story";

  @override
  void initState() {
    super.initState();
    heritageData = HeritageData(heritageId: widget.heritageId);
    loadData();
  }

  Future<void> loadData() async {
    await heritageData.fetch();
    setState(() {}); // لتحديث الـ UI بعد تحميل البيانات
  }

  @override
  Widget build(BuildContext context) {
    if (heritageData.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final contentMap = {
      "story": heritageData.story,
      "cost": heritageData.cost,
      "weather": heritageData.weather,
    };

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Image.network(heritageData.mainImage, fit: BoxFit.cover),
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
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heritageData.title,
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
                      fontSize: 18,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF373854) : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          if (isActive)
            Container(
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




