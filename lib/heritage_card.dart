import 'package:flutter/material.dart';
import 'heritage.dart';

class HeritageCard extends StatelessWidget {
  final HeritageModel heritage;

  const HeritageCard({required this.heritage, super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseBaseUrl =
        'https://vetdooxhwfezufdzzean.supabase.co/storage/v1/object/public/places_images';

    return Container(
      width: 160,   // نفس عرض PlaceCard
      height: 200,  // نفس ارتفاع PlaceCard
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              '$supabaseBaseUrl/${heritage.image}',
              width: double.infinity,
              height: 120, // نفس ارتفاع الصورة في PlaceCard
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          // العنوان + القلب
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  heritage.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}
