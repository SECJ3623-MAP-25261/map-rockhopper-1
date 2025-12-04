// screens/order_listing_screen.dart
import 'package:flutter/material.dart';
import '../../models/profile_model.dart';
import '../../models/order_model.dart';


class OrderListing extends StatefulWidget {
  final List<Order> orders;
  final int? initialIndex;

  const OrderListing({
    super.key,
    required this.orders,
    this.initialIndex,
  });

  @override
  State<OrderListing> createState() => _OrderListingState();
}

class _OrderListingState extends State<OrderListing> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.orders[_currentIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(
            onPressed: _shareOrder,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          // Order Status Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: order.statusColor.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: order.statusColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.statusText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: order.statusColor,
                    ),
                  ),
                ),
                Text(
                  'Order #${order.id.substring(0, 8)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // Order Details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Device Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              order.deviceImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.deviceName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'RM ${order.price.toStringAsFixed(2)}/day',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rental Period: ${order.duration}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Date Information
                  const Text(
                    'Rental Dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Start Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${order.startDate.day}/${order.startDate.month}/${order.startDate.year}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.blue),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'End Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${order.endDate.day}/${order.endDate.month}/${order.endDate.year}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Price Summary
                  const Text(
                    'Price Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildPriceRow('Daily Rate', 'RM ${order.price.toStringAsFixed(2)}'),
                          _buildPriceRow('Rental Days', '${order.duration}'),
                          const Divider(),
                          _buildPriceRow(
                            'Total Amount',
                            'RM ${order.totalPrice.toStringAsFixed(2)}',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Order Timeline
                  const Text(
                    'Order Timeline',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildTimelineItem(
                            'Order Placed',
                            order.orderDate,
                            Icons.shopping_cart,
                            Colors.green,
                          ),
                          _buildTimelineItem(
                            'Payment Confirmed',
                            order.orderDate.add(const Duration(hours: 1)),
                            Icons.payment,
                            Colors.blue,
                          ),
                          if (order.status == OrderStatus.renting ||
                              order.status == OrderStatus.returned)
                            _buildTimelineItem(
                              'Device Shipped',
                              order.startDate.subtract(const Duration(days: 1)),
                              Icons.local_shipping,
                              Colors.orange,
                            ),
                          if (order.status == OrderStatus.returned)
                            _buildTimelineItem(
                              'Device Returned',
                              order.endDate,
                              Icons.check_circle,
                              Colors.purple,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation for multiple orders
          if (widget.orders.length > 1)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentIndex > 0
                        ? () {
                            setState(() {
                              _currentIndex--;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                  Text(
                    '${_currentIndex + 1} of ${widget.orders.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: _currentIndex < widget.orders.length - 1
                        ? () {
                            setState(() {
                              _currentIndex++;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, DateTime date, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareOrder() {
    // Implement share functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Order'),
        content: const Text('Share this order via email, message, or social media.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
}