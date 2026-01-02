import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeritageDetails extends StatefulWidget {
  const HeritageDetails({Key? key}) : super(key: key);

  @override
  State<HeritageDetails> createState() => _HeritageDetailsState();
}

class _HeritageDetailsState extends State<HeritageDetails> {
  String activeTab = "story";

  final Map<String, String> contentMap = {
    "story":
        "This heritage place has a deep cultural story that reflects history, traditions, and architecture. "
        "It has been preserved for generations and represents an important cultural landmark.",
    "cost": "Entry cost:\n\n• Adults: 10 USD\n• Kids: Free",
    "weather": "☀️ Sunny\n🌡 25°C\n💨 Light wind",
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// IMAGE
            SizedBox(
              height: 350,
              width: width,
              child: const Image(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                ),
                fit: BoxFit.cover,
              ),
            ),

            /// BACK BUTTON
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

            /// CARD OVER IMAGE
            Container(
              margin: const EdgeInsets.only(top: 300),
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE + HEART ICON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Zainab",
                        style: GoogleFonts.dmSerifText(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFF373854),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// TABS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTab("Story"),
                      buildTab("Cost"),
                      buildTab("Weather"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// CONTENT
                  Text(
                    contentMap[activeTab] ?? "",
                    style: GoogleFonts.atkinsonHyperlegible(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TAB WIDGET
  Widget buildTab(String title) {
    final key = title.toLowerCase();
    final isActive = activeTab == key;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          activeTab = key;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? const Color.fromARGB(255, 84, 85, 131) : Colors.black,
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




