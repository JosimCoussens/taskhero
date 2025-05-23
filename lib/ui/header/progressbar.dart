import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/leveling/xp_service.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppParams.level,
      builder: (context, level, _) {
        return ValueListenableBuilder<int>(
          valueListenable: AppParams.xp,
          builder: (context, userXp, _) {
            final maxXp = XpService.requiredXp();
            final progress = (userXp / maxXp).clamp(0.0, 1.0);
            final nextLevel = level + 1;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      level.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ProgressBarMain(progress: progress),
                          ProgressPercentage(progress: progress),
                        ],
                      ),
                    ),
                    Text(
                      nextLevel.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ProgressBarMain extends StatelessWidget {
  const ProgressBarMain({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(8),
      value: progress,
      minHeight: 18,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
    );
  }
}

class ProgressPercentage extends StatelessWidget {
  const ProgressPercentage({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${(progress * 100).toStringAsFixed(1)}%',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
