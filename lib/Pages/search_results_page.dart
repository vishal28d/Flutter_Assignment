import 'package:flutter/material.dart';
import 'package:my_travaly/Pages/detail_page.dart';
import 'package:my_travaly/Widgets/hotel_card.dart';
import '../services/api_service.dart';

class SearchResultPage extends StatefulWidget {
  final String query;
  final String visitorToken;

  const SearchResultPage({
    Key? key,
    required this.query,
    required this.visitorToken,
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late Future<List<dynamic>> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = _searchHotels(widget.query);
  }

  Future<List<dynamic>> _searchHotels(String query) async {
  if (query.trim().isEmpty) return [];

  final q = query.trim();

  try {
  
    final hotels = await ApiService.fetchHotels(
      visitorToken: widget.visitorToken,
      country: "India",
      city: q,
    );

  
    final filtered = hotels.where((hotel) {
      final name = (hotel["propertyName"] ?? "").toLowerCase();
      final city = (hotel["propertyAddress"]["city"] ?? "").toLowerCase();
      return name.contains(q.toLowerCase()) || city.contains(q.toLowerCase());
    }).toList();

    return filtered;
  } catch (e) {
    debugPrint("Search error: $e");
    return [];
  }
}


  Widget _buildHotelCard(dynamic hotel) {
  final imageUrl = hotel["propertyImage"] ?? "";
  final name = hotel["propertyName"] ?? "Unknown Hotel";
  final address = hotel["propertyAddress"]?["city"] ?? "Unknown City";
  final price = hotel["staticPrice"]?["displayAmount"] ?? "N/A";
  final rating = hotel["googleReview"]?["data"]?["overallRating"] ?? "N/A";

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPage(hotel: hotel),
        ),
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
            imageUrl,
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
        subtitle: Text("$address\n⭐ $rating | ₹$price"),
        isThreeLine: true,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Results for \"${widget.query}\"",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No results found"));
          }

          final hotels = snapshot.data!;
          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) => HotelCard(hotel: hotels[index],),
          );
        },
      ),
    );
  }
}
