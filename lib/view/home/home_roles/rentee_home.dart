// Rentee_home.dart (with dummy data for testing)
import 'package:flutter/material.dart';
import '../message/rentee_chat_list_screen.dart';
import 'package:pinjamtech_app/models/device_model.dart'; // Add this import
import '../../listings/edit_listing.dart'; // For testing edit
import '../../listings/delete_listing.dart'; // For testing delete
import '../../listings/createlist.dart'; // For testing delete
import '../search_screen.dart'; // Add this line
import 'package:pinjamtech_app/view/profile/rentee_profile.dart';


class RenteeHome extends StatefulWidget {
  const RenteeHome({super.key});

  @override
  State<RenteeHome> createState() => _RenteeHomeState();
}

class _RenteeHomeState extends State<RenteeHome> {
  // Dummy data for testing edit and delete
  final List<Device> dummyDevices = [
    Device(
      id: 'test-1',
      name: 'Acer Nitro V15 Gaming Laptop',
      brand: 'Acer',
      pricePerDay: 25.0,
      imageUrl: 'https://cdn.uc.assets.prezly.com/26bcc88a-0478-40a1-8f29-cf52ef86196c/nitro_v15_special_angle_2.png',
      isAvailable: true,
      maxRentalDays: 30,
      condition: 'Excellent',
      description: 'Powerful gaming laptop with RTX 3050, 16GB RAM, 512GB SSD. Perfect for gaming and productivity tasks.',
      category: 'Laptops',
      bookedSlots: [
        DateTime.now().add(const Duration(days: 2)),
        DateTime.now().add(const Duration(days: 3)),
      ],
    ),
    Device(
      id: 'test-2',
      name: 'iPad Air 5th Gen',
      brand: 'Apple',
      pricePerDay: 12.0,
      imageUrl: 'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/ipad-air-select-wifi-blue-202203?wid=940&hei=1112&fmt=png-alpha&.v=1645066731716',
      isAvailable: true,
      maxRentalDays: 60,
      condition: 'Like New',
      description: 'Latest iPad Air with M1 chip, 64GB storage. Perfect for digital art, note-taking, and media consumption.',
      category: 'Tablets',
      bookedSlots: [],
    ),
    Device(
      id: 'test-3',
      name: 'Samsung Galaxy S23 Ultra',
      brand: 'Samsung',
      pricePerDay: 15.0,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Samsung_Galaxy_S25_Ultra_2025_%281%29.jpg/1280px-Samsung_Galaxy_S25_Ultra_2025_%281%29.jpg',
      isAvailable: false,
      maxRentalDays: 30,
      condition: 'Good',
      description: 'Flagship Samsung phone with excellent camera system and powerful performance.',
      category: 'Phones',
      bookedSlots: [
        DateTime.now().add(const Duration(days: 5)),
      ],
    ),
    Device(
      id: 'test-4',
      name: 'Meta Quest 3 VR Headset',
      brand: 'Meta',
      pricePerDay: 20.0,
      imageUrl: 'https://asset.kompas.com/crops/ALq5g9ReY3Vv_tL9E07HvhA48FA=/124x0:1804x1120/750x500/data/photo/2023/10/11/652694f89cee8.jpg',
      isAvailable: true,
      maxRentalDays: 14,
      condition: 'Excellent',
      description: 'Mixed reality headset with high-resolution displays. Perfect for gaming and VR experiences.',
      category: 'XR/VR Box',
      bookedSlots: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateList(),
            ),
          ).then((newDevice) {
            if (newDevice != null && newDevice is Device) {
              setState(() {
                dummyDevices.add(newDevice);
              });
            }
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "PinjamTech",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),

            _buildUserInfo(context),

            const SizedBox(height: 20),
            
            // =============== ADDED SEARCH BAR ===============
            _buildSearchBar(context),
            const SizedBox(height: 20),
            // ================================================

            const Text(
              "Rentee Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),
            ),

            const SizedBox(height: 20),
            const Text(
              "My Active Rentals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.75, // Taller card
  ),
  itemCount: dummyDevices.length,
  itemBuilder: (context, index) {
    return _buildGridDeviceCard(dummyDevices[index]);
  },
),


            const SizedBox(height: 30),
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickActionCircle(Icons.search, "Browse", () {
                  // ADDED: Browse now opens search
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                }),
                _quickActionCircle(Icons.sell, "My Listing", () {}),
                _quickActionCircle(Icons.history, "History", () {}),
                _quickActionCircle(Icons.settings, "Settings", () {}),
              ],
            ),

            const SizedBox(height: 30),
            const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            _activityItem("Rented MacBook Pro", "2 days ago"),
            _activityItem("Returned iPhone 15", "1 week ago"),
            _activityItem("Rented PS5", "2 weeks ago"),
          ],
        ),
      ),
    );
  }

  // =============== ADDED SEARCH BAR METHOD ===============
  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: const IgnorePointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Device",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.filter_list),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------
  //       DEVICE CARD FOR TESTING
  // ------------------------------
  Widget _buildGridDeviceCard(Device device) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditListing(
            device: device,
            bookedSlots: device.bookedSlots,
          ),
        ),
      ).then((updatedDevice) {
        if (updatedDevice != null && updatedDevice is Device) {
          setState(() {
            final index = dummyDevices.indexWhere((d) => d.id == device.id);
            if (index != -1) {
              dummyDevices[index] = updatedDevice;
            }
          });
        }
      });
    },
    onLongPress: () {
      showModalBottomSheet(
        context: context,
        builder: (context) => _buildDeleteBottomSheet(device),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: Image.network(
              device.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey[200],
                  child: const Icon(Icons.device_unknown, size: 50),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME & BRAND
                Text(
                  device.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (device.brand.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    device.brand,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                
                const SizedBox(height: 6),
                
                // PRICE
                Text(
                  "RM ${device.pricePerDay.toStringAsFixed(2)}/day",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                // DEPOSIT (if exists)
                if (device.deposit != null && device.deposit! > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Deposit: RM ${device.deposit!.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange[700],
                    ),
                  ),
                ],
                
                const SizedBox(height: 6),
                
                // STATUS & CATEGORY
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: device.isAvailable ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          device.isAvailable ? "Available" : "Not Available",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        device.category,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  // ------------------------------
  //       DELETE BOTTOM SHEET
  // ------------------------------
  Widget _buildDeleteBottomSheet(Device device) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Listing Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text('Edit Listing'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditListing(
                    device: device,
                    bookedSlots: device.bookedSlots,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Listing'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteListing(
                    device: device,
                  ),
                ),
              ).then((shouldDelete) {
                if (shouldDelete == true) {
                  setState(() {
                    dummyDevices.removeWhere((d) => d.id == device.id);
                  });
                }
              });
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // ------------------------------
  //           USER INFO
  // ------------------------------
  Widget _buildUserInfo(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hello!", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 4),

          Row(
            children: [
              const Text("Jaafar",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  'Rentee',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      subtitle: const Text(
        "Manage your rental items",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RenterChatListScreen()),
              );
            },
            child: Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.chat_bubble_outline, size: 26),
            ),

            
          ),
        GestureDetector(
           onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RenteeProfile()),
              );
            },
          child:Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey[300],
            ),
            child: const Icon(Icons.person, size: 30),
          ),
        )
        ],
      ),
    );
  }

  // ------------------------------
  //       QUICK ACTION CIRCLE
  // ------------------------------
  Widget _quickActionCircle(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
              color: Colors.green.withOpacity(0.1),
            ),
            child: Icon(icon, color: Colors.green, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // ------------------------------
  //        ACTIVITY ITEM
  // ------------------------------
  Widget _activityItem(String title, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, color: Colors.green),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                Text(time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}