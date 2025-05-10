import 'package:flutter/material.dart';

/// A utility function to build a dropdown widget.
Widget buildDropdown<T>({
  required BuildContext context,
  required String label,
  required T? value,
  required List<DropdownMenuItem<T>> items,
  required Function(T?) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Text(label, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            items: items,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    ],
  );
}
