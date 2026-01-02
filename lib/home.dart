import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // يحط كل شي قريب من الأسفل
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // النص
                  Text(
                    'Planning your\nnext journey with us!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rem(
                      fontWeight: FontWeight.w600, // SemiExpanded تقريبًا
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15), // مسافة أقصر بين النص والزر
                  // زر Explore Now
                  SizedBox(
                    width: 270, // أقصر على طول الجملة
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: Color(0xFF373854),
                      ),
                      child: Text(
                        'Explore Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40), // مسافة من أسفل الشاشة
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
