import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final List<String> searchResults;
  final ValueChanged<String> onResultSelected;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.hintText = 'Search...',
    required this.searchResults,
    required this.onResultSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              if (controller.text.isNotEmpty)
                GestureDetector(
                  onTap: onClear ?? () => controller.clear(),
                  child: const Icon(Icons.clear, color: Colors.grey),
                ),
            ],
          ),
        ),
        // Display search results dropdown
        if (searchResults.isNotEmpty) 
          Container(
            margin: const EdgeInsets.only(top: 8), // Spacing between the search bar and dropdown
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final city = searchResults[index];
                return ListTile(
                  title: Text(city),
                  onTap: () {
                    onResultSelected(city); // Notify the parent about the selected city
                    controller.clear(); // Clear the input after selection
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
