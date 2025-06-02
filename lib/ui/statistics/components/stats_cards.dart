import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/user_service.dart';

Column statsCards() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildStatsCard(
              'Tasks Done',
              Icons.check_circle,
              Colors.green,
              UserService.getTotalCompleted,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Streak',
              Icons.local_fire_department,
              Colors.orange,
              null,
            ),
          ),
        ],
      ),

      const SizedBox(height: 16),

      Row(
        children: [
          Expanded(
            child: _buildStatsCard(
              'This Week',
              Icons.calendar_today,
              Colors.purple,
              null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Average',
              Icons.trending_up,
              Colors.teal,
              null,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildStatsCard(
  String title,
  IconData icon,
  Color color,
  Function? dataFunction,
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: StylingParams.borderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: StylingParams.borderRadius,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 16),
        dataFunction == null
            ? const Text(
              'N/A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            )
            : FutureBuilder(
              future: dataFunction(),
              builder:
                  (context, snapshot) => Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
            ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
