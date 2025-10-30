import 'package:flutter/material.dart';
import '../Pages/detail_page.dart';

class HotelCard extends StatelessWidget {
  final dynamic hotel;

  const HotelCard({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = hotel["propertyImage"] ?? "";
    final name = hotel["propertyName"] ?? "Unknown Hotel";

    final address = hotel["propertyAddress"]?["city"] ?? "Unknown City";
    final price = hotel["staticPrice"]?["displayAmount"]?.toString() ?? "N/A";
    final rating = hotel["googleReview"]?["data"]?["overallRating"]?.toString() ?? "N/A";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(hotel: hotel)),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl.isNotEmpty ? imageUrl : 'https://placehold.co/600x400/EEE/31343C',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.network(
                'https://placehold.co/600x400/EEE/31343C',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("$address\n⭐ $rating | $price"),
          isThreeLine: true,
        ),
      ),
    );
  }
}
