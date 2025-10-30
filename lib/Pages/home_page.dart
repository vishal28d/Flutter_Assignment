import 'package:flutter/material.dart';
import 'package:my_travaly/Pages/detail_page.dart';
import 'package:my_travaly/Pages/search_results_page.dart';
import 'package:my_travaly/Widgets/hotel_card.dart';
import '../services/api_service.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String visitorToken = '4501-0fe3-6c8e-9115-078f-a3b6-ed45-eb1d';
  late Future<List<dynamic>> hotelsFuture;
  String _city = "Mumbai";

  @override
  void initState() {
    super.initState();
    hotelsFuture = ApiService.fetchHotels(
        visitorToken: visitorToken, city: _city);
  }

//   Widget _buildHotelCard(dynamic hotel) {
//   final imageUrl = hotel["propertyImage"] ?? "";
//   final name = hotel["propertyName"] ?? "Unknown Hotel";
//   final address = hotel["propertyAddress"]?["city"] ?? "Unknown City";
//   final price = hotel["staticPrice"]?["displayAmount"] ?? "N/A";
//   final rating = hotel["googleReview"]?["data"]?["overallRating"] ?? "N/A";

//   return InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => DetailPage(hotel: hotel),
//         ),
//       );
//     },
//     child: Card(
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             imageUrl,
//             width: 70,
//             height: 70,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) => Image.network(
//               'https://placehold.co/600x400/EEE/31343C',
//               width: 70,
//               height: 70,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         title: Text(
//           name,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text("$address\n ⭐ $rating | $price"),
//         isThreeLine: true,
//       ),
//     ),
//   );
// }


  void _openSearchPage(String query) {
    if (query.trim().isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultPage(
          query: query,
          visitorToken: visitorToken,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Popular Hotels", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) => _openSearchPage(value),
                    decoration: InputDecoration(
                      hintText: "Search by city or hotel name",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
               GestureDetector(
  onTap: () => _openSearchPage(_searchController.text),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],  
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.4),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.search, color: Colors.white),
        SizedBox(width: 8),
        Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  ),
)

              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: hotelsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No hotels found"));
                }

                final hotels = snapshot.data!;
                return ListView.builder(
                  itemCount: hotels.length,
                  itemBuilder: (context, index) =>
                      HotelCard( hotel: hotels[index], ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
