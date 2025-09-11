import 'package:flutter/material.dart';

class SpeakerCard extends StatelessWidget {
  final String name;
  final String title;
  final String ?bio;
  final String? photoAsset; // 🔹 path to local asset

  const SpeakerCard({
    Key? key,
    required this.name,
    required this.title,
    this.bio,
    this.photoAsset,
  }) : super(key: key);

  String _initials(String text) {
    final parts = text.split(' ');
    final first = parts.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.blueAccent,
              backgroundImage: photoAsset != null ? AssetImage(photoAsset!) : null,
              child: photoAsset == null
                  ? Text(
                      _initials(name),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    )
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              bio ?? '',
              style: const TextStyle(color: Colors.white60, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
