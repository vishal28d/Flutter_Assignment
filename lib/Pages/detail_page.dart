import 'package:my_travaly/Pages/web_view_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final dynamic hotel;

  const DetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = hotel["propertyName"] ?? "Unknown Hotel";
    final imageUrl = hotel["propertyImage"] ?? "";
    final rating = hotel["googleReview"]?["data"]?["overallRating"]?.toString() ?? "N/A";
    final totalReviews = hotel["googleReview"]?["data"]?["totalUserRating"]?.toString() ?? "0";
    final price = hotel["staticPrice"]?["displayAmount"] ?? "N/A";
    final propertyStar = hotel["propertyStar"]?.toString() ?? "-";
    final propertyType = hotel["propertyType"] ?? "";
    final url = hotel["propertyUrl"] ?? "";

    final address = hotel["propertyAddress"];
    final street = address?["street"] ?? "";
    final city = address?["city"] ?? "";
    final state = address?["state"] ?? "";
    final country = address?["country"] ?? "";

    final policyData = hotel["propertyPoliciesAndAmmenities"]?["data"];
    final cancelPolicy = policyData?["cancelPolicy"] ?? "N/A";
    final refundPolicy = policyData?["refundPolicy"] ?? "N/A";
    final childPolicy = policyData?["childPolicy"] ?? "N/A";
    final damagePolicy = policyData?["damagePolicy"] ?? "N/A";
    final coupleFriendly = policyData?["coupleFriendly"] == true ? "Yes" : "No";
    final wifi = policyData?["freeWifi"] == true ? "Yes" : "No";
    final payAtHotel = policyData?["payAtHotel"] == true ? "Yes" : "No";
    final freeCancellation = policyData?["freeCancellation"] == true ? "Yes" : "No";

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Hotel Image
            Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.network(
                'https://placehold.co/600x400/EEE/31343C?text=No+Image',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Hotel info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          int.tryParse(propertyStar) ?? 0,
                          (i) => const Icon(Icons.star, color: Colors.amber, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
 
                  Row(
                    children: [
                      Text(
                        "$price",
                        style: const TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Icon(Icons.star, color: Colors.amber[700]),
                      Text(" $rating ($totalReviews reviews)"),
                    ],
                  ),
                  const SizedBox(height: 10),

          
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "$street, $city, $state, $country",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
 
                  const Text("Amenities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      _buildTag(Icons.wifi, "Free Wi-Fi: $wifi"),
                      _buildTag(Icons.favorite, "Couple Friendly: $coupleFriendly"),
                      _buildTag(Icons.money, "Pay at Hotel: $payAtHotel"),
                      _buildTag(Icons.cancel, "Free Cancellation: $freeCancellation"),
                    ],
                  ),

                  const SizedBox(height: 16),

               
                  const Text("Policies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildPolicy("Cancellation Policy", cancelPolicy),
                  _buildPolicy("Refund Policy", refundPolicy),
                  _buildPolicy("Child Policy", childPolicy),
                  _buildPolicy("Damage Policy", damagePolicy),

                  const SizedBox(height: 24),

               
                 Center(
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      final String? url = hotel["propertyUrl"];
      if (url != null && url.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewPage(
              url: url,
              title: hotel["propertyName"] ?? "MyTravaly",
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid hotel URL")),
        );
      }
    },
    icon: const Icon(Icons.open_in_browser, color: Colors.white),
    label: const Text(
      "View on MyTravaly",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  ),
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   
  Widget _buildPolicy(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildTag(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}


