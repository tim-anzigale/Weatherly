import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherly/core/controllers/geonames_controller.dart';

class CustomSearchBar extends StatefulWidget {
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
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    // Use GetX's "ever" method to listen for changes to the searchResults list
    ever(Get.find<GeoNamesController>().searchResults, (_) {
      if (widget.searchResults.isNotEmpty) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.searchResults.length,
              itemBuilder: (context, index) {
                final city = widget.searchResults[index];
                return ListTile(
                  title: Text(city),
                  onTap: () {
                    widget.onResultSelected(city);
                    widget.controller.clear();
                    _removeOverlay();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
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
                    controller: widget.controller,
                    onChanged: (query) {
                      widget.onChanged(query);
                      if (query.isNotEmpty) {
                        _showOverlay();
                      } else {
                        _removeOverlay();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                if (widget.controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      widget.onClear?.call();
                      widget.controller.clear();
                      _removeOverlay();
                    },
                    child: const Icon(Icons.clear, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
