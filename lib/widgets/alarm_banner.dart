import 'package:flutter/material.dart';

class AlarmBanner extends StatelessWidget {
  final String message;
  final bool isVisible;

  const AlarmBanner({Key? key, required this.message, this.isVisible = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(sizeFactor: animation, child: child);
      },
      child: isVisible
          ? Container(
              color: Colors.red.shade700,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: SafeArea(
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
