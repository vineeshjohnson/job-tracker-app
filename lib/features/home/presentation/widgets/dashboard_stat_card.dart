import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  final Color color;

  const DashboardStatCard({
    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: color.withOpacity(0.12),

          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Icon(icon, color: color),

            const SizedBox(height: 16),

            Text(
              value,

              style: TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.bold,

                color: color,
              ),
            ),

            const SizedBox(height: 6),

            Text(title, style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }
}
