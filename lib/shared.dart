import 'package:flutter/material.dart';

Future<bool?> confirmDismiss(BuildContext context,String type) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete this $type?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Color(0xFF4447E2)),
            ),
          ),
        ],
      );
    },
  );
}
