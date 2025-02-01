import 'package:flutter/material.dart';

void selectPregnantCount(BuildContext context, String text) {
  int selectedNumber = 1; // Default selected number
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select count of pregancies'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return DropdownButton<int>(
              value: selectedNumber,
              items: List.generate(10, (index) => index + 1)
                  .map((number) => DropdownMenuItem<int>(
                        value: number,
                        child: Text(number.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedNumber = value!;
                  text = value.toString();
                });
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // print('Selected number for $title: $selectedNumber');
              // Add your desired action here
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
