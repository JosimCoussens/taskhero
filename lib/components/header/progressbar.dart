import 'package:flutter/material.dart';
import 'package:taskhero/constants.dart';

class ProgressBar extends StatefulWidget {
  final int userXp;
  final int maxXp;
  final int level;

  const ProgressBar({
    super.key,
    required this.userXp,
    required this.maxXp,
    required this.level,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late double progress; // late means this variable will be initialized later
  late int nextLevel;

  @override
  void initState() {
    progress = (widget.userXp / widget.maxXp).clamp(0.0, 1.0);
    nextLevel = widget.level + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Row(
          spacing: 5,
          children: [
            Text(
              widget.level.toString(),
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
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
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
