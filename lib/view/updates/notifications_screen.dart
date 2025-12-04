// screens/notifications_screen.dart
import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class NotificationsScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const NotificationsScreen({
    super.key,
    required this.cartItems,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Simulated notification data based on cart items
  final List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _generateNotifications();
  }

  void _generateNotifications() {
    // Clear existing notifications
    _notifications.clear();

    // Generate notifications for each cart item
    for (final item in widget.cartItems) {
      final now = DateTime.now();
      
      // Notification 1: Item added to cart
      _notifications.add({
        'id': 'cart-${item.id}',
        'title': 'Added to Cart',
        'message': '${item.name} has been added to your renting cart',
        'time': now.subtract(const Duration(minutes: 5)),
        'isRead': false,
        'icon': Icons.shopping_cart,
        'color': Colors.blue,
        'cartItemId': item.id,
      });

      // Notification 2: Rental dates selected
      _notifications.add({
        'id': 'dates-${item.id}',
        'title': 'Dates Selected',
        'message': '${item.name}: ${item.startDate.day}/${item.startDate.month} - ${item.endDate.day}/${item.endDate.month}',
        'time': now.subtract(const Duration(hours: 2)),
        'isRead': true,
        'icon': Icons.calendar_today,
        'color': Colors.green,
        'cartItemId': item.id,
      });

      // Notification 3: Price alert for expensive items
      if (item.price > 15) {
        _notifications.add({
          'id': 'price-${item.id}',
          'title': 'Premium Device',
          'message': '${item.name} is priced at RM${item.price.toStringAsFixed(2)}/day',
          'time': now.subtract(const Duration(days: 1)),
          'isRead': false,
          'icon': Icons.attach_money,
          'color': Colors.orange,
          'cartItemId': item.id,
          'price': item.price,
        });
      }

      // Notification 4: Rental period info
      final rentalDays = item.rentalDays;
      if (rentalDays > 7) {
        _notifications.add({
          'id': 'long-rental-${item.id}',
          'title': 'Long Rental Period',
          'message': '${item.name} is rented for $rentalDays days',
          'time': now.subtract(const Duration(days: 2)),
          'isRead': true,
          'icon': Icons.timer,
          'color': Colors.purple,
          'cartItemId': item.id,
          'days': rentalDays,
        });
      }
    }

    // Add some system notifications
    _notifications.addAll([
      {
        'id': 'system-1',
        'title': 'Welcome to PinjamTech!',
        'message': 'Start renting devices with our easy-to-use platform',
        'time': DateTime.now().subtract(const Duration(days: 3)),
        'isRead': true,
        'icon': Icons.notifications,
        'color': Colors.red,
      },
      {
        'id': 'system-2',
        'title': 'Weekend Special',
        'message': 'Get 10% off on all rentals this weekend',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'isRead': false,
        'icon': Icons.local_offer,
        'color': Colors.pink,
      },
    ]);

    // Sort by time (newest first)
    _notifications.sort((a, b) => b['time'].compareTo(a['time']));
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 30) {
      final months = difference.inDays ~/ 30;
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (final notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isRead'] = true;
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  int get unreadCount {
    return _notifications.where((n) => !n['isRead']).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            IconButton(
              icon: const Icon(Icons.mark_email_read),
              onPressed: _markAllAsRead,

              
              tooltip: 'Mark all as read',
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : _buildNotificationsList(),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return _buildNotificationCard(notification, index);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification, int index) {
    final isUnread = !notification['isRead'];
    final icon = notification['icon'] as IconData;
    final color = notification['color'] as Color;
    final timeAgo = _getTimeAgo(notification['time'] as DateTime);

    return Dismissible(
      key: Key(notification['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _deleteNotification(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${notification['title']} dismissed'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _notifications.insert(index, notification);
                });
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: isUnread ? Colors.blue[50] : null,
        child: ListTile(
          onTap: () {
            _markAsRead(index);
            if (notification['cartItemId'] != null) {
              _showCartItemDetails(notification['cartItemId'] as String);
            }
          },
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      notification['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (isUnread)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                notification['message'] as String,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                // Show cart badge if related to cart item
                if (notification['cartItemId'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart, size: 12, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                // Show price if available
                if (notification['price'] != null)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'RM${notification['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Trailing action button
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            onSelected: (value) {
              if (value == 'mark_read') {
                _markAsRead(index);
              } else if (value == 'delete') {
                _deleteNotification(index);
              }
            },
            itemBuilder: (context) => [
              if (isUnread)
                const PopupMenuItem<String>(
                  value: 'mark_read',
                  child: ListTile(
                    leading: Icon(Icons.check_circle, size: 20),
                    title: Text('Mark as read'),
                  ),
                ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete, size: 20, color: Colors.red),
                  title: Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          const Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Add items to your cart to receive notifications about your rentals',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _showCartItemDetails(String cartItemId) {
    final cartItem = widget.cartItems.firstWhere(
      (item) => item.id == cartItemId,
      orElse: () => CartItem(
        id: 'unknown',
        name: 'Unknown Item',
        price: 0,
        image: '',
        description: '',
        condition: '',
        category: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        brand: '',
        maxRentalDays: 0,
      ),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cart Item Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(cartItem.image),
                radius: 30,
              ),
              title: Text(cartItem.name),
              subtitle: Text('RM ${cartItem.price.toStringAsFixed(2)}/day'),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Rental Period', 
                '${cartItem.startDate.day}/${cartItem.startDate.month} - ${cartItem.endDate.day}/${cartItem.endDate.month}'),
            _buildDetailRow('Total Days', '${cartItem.rentalDays} days'),
            _buildDetailRow('Total Price', 'RM ${cartItem.totalPrice.toStringAsFixed(2)}'),
            _buildDetailRow('Condition', cartItem.condition),
            _buildDetailRow('Category', cartItem.category),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to cart screen
              Navigator.pushNamed(context, '/renting-cart');
            },
            child: const Text('View in Cart'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}