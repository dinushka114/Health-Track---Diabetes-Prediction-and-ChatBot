import 'package:flutter/material.dart';

Widget buildTitle(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      title,
      style: Theme.of(context).textTheme.displaySmall,
      textAlign: TextAlign.start,
    ),
  );
}

Widget buildCardRow(
  BuildContext context, {
  required IconData icon1,
  required String text1,
  required VoidCallback onTap1,
  required IconData icon2,
  required String text2,
  required VoidCallback onTap2,
}) {
  return Card(
    color: Colors.teal.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInfoItem(icon1, text1, onTap1),
          buildInfoItem(icon2, text2, onTap2),
        ],
      ),
    ),
  );
}

Widget buildInfoItem(IconData icon, String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Colors.teal.shade700),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget buildRowOneCard(
  BuildContext context, {
  required IconData icon1,
  required String text1,
  required VoidCallback onTap1,
}) {
  return Card(
    color: Colors.teal.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buildInfoItem(icon1, text1, onTap1)],
      ),
    ),
  );
}

Widget _buildCard(
  BuildContext context, {
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
