import 'package:flutter/material.dart';

class AlertBannerChild extends StatelessWidget {
  final String message;

  const AlertBannerChild({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          color: Colors.transparent,
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
