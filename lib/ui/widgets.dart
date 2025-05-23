import 'package:flutter/material.dart';
import 'package:taskhero/core/styles.dart';

class Components {
  Row buttons(
    BuildContext context,
    VoidCallback onCancel,
    VoidCallback onSave,
  ) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            style: Styles().saveButtonStyle,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class WindowHeader extends StatelessWidget {
  final String title;
  const WindowHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87, // Softer than full black
          ),
        ),
        const SizedBox(height: 6),
        const Divider(
          thickness: 1.5,
          color: Colors.black26, // Softer divider for modern look
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}

class InputTextField extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  const InputTextField({
    super.key,
    required this.hintText,
    required this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
