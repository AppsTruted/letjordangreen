import 'package:flutter/material.dart';
import 'package:letjordangreen/features/feature_home/presentation/screens/home_screen.dart';

class NewsCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final String body;
  final VoidCallback? onTap;  // Add this

  const NewsCard({super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.body,
    this.onTap,  // Add this
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 121,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                image,
                width: 92,
                height: 92,
                errorBuilder: (context, error, stackTrace) => SizedBox(
                  width: 92,
                  height: 92,
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        color: HomeScreen.mutedGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.7,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: HomeScreen.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        height: 1.06,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}