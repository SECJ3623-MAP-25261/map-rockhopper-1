import 'package:flutter/material.dart';
import 'product_list_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [
    'Laptop',
    'Phones',
    'Notebook',
    'Tablet',
    'Camera'
  ];

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListScreen(searchQuery: query.trim()),
        ),
      );
    }
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search devices...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                ),
                onSubmitted: _performSearch,
              ),
            ),
            const SizedBox(height: 8),
            
            // Search Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _performSearch(_searchController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Search History Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Search History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_searchHistory.isNotEmpty)
                  TextButton(
                    onPressed: _clearSearchHistory,
                    child: const Text(
                      'Clear all',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Search History List
            Expanded(
              child: _searchHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'No search history',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.history, color: Colors.grey),
                          title: Text(_searchHistory[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, size: 16),
                            onPressed: () {
                              _searchController.text = _searchHistory[index];
                              _performSearch(_searchHistory[index]);
                            },
                          ),
                          onTap: () {
                            _searchController.text = _searchHistory[index];
                            _performSearch(_searchHistory[index]);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}