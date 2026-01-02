import 'dart:convert';
import 'package:http/http.dart' as http;

class HeritageData {
  final int heritageId;
  final String baseUrl = 'https://mobile-project-1-ab63.onrender.com';

  String title = "";
  String story = "";
  String cost = "";
  String weather = "";
  String mainImage = "";
  bool isLoading = true;

  HeritageData({required this.heritageId});

  /// جلب البيانات من الـ API
  Future<void> fetch() async {
    isLoading = true;
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/heritageDetail?heritage_id=$heritageId'),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)[0];
        title = data['Heritage_Title'] ?? '';
        story = data['Story'] ?? '';
        cost = data['Cost'] ?? '';
        weather = data['Weather'] ?? '';
        mainImage = data['Main_Image'] ?? '';
      }
    } catch (e) {
      print("Error loading heritage details: $e");
    } finally {
      isLoading = false;
    }
  }
}


