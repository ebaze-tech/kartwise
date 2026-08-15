import 'package:flutter/material.dart';
import 'package:campus_cart/core/theme/theme.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;

  const CustomSearchBar({
    this.hintText = 'Search...',
    required this.onChanged,
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    FocusScope.of(context).unfocus();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: DefaultColors.neutral.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: const Icon(Icons.search, color: DefaultColors.gray),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: DefaultColors.gray,
                    size: 20,
                  ),
                  onPressed: _clearSearch,
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
