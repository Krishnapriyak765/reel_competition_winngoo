import 'package:flutter/material.dart';

class UploadSuccessMessage extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const UploadSuccessMessage({
    super.key,
    this.message = "Your video has been successfully uploaded!",
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.green),
            onPressed: onDismiss, // Call the dismiss callback
          ),
        ],
      ),
    );
  }
}
