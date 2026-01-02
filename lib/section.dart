import 'package:flutter/material.dart';
import 'place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    // رابط الصور العام (public bucket)
    final supabaseBaseUrl = 'https://vetdooxhwfezufdzzean.supabase.co/storage/v1/object/public/places_images';

    return Container(
      width: 160,
      height: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              '$supabaseBaseUrl/${place.image}',
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(place.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(Icons.favorite, color: Color(0xFF373854), size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}