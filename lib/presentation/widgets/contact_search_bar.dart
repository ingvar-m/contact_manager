import 'package:contact_manager/presentation/constants/app_colors.dart';
import 'package:contact_manager/presentation/providers/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactSearchBar extends ConsumerStatefulWidget {
  const ContactSearchBar({super.key});

  @override
  ConsumerState<ContactSearchBar> createState() => _ContactSearchBarState();
}

class _ContactSearchBarState extends ConsumerState<ContactSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) =>
      ref
          .read(searchQueryProvider.notifier)
          .state = value,
      decoration: InputDecoration(
          hintText: "Search contacts",
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
          ),
          filled: true,
          fillColor: AppColors.secondaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
              Icons.search,
              size: 24,
              color: AppColors.primaryColor
          ),
          suffixIcon: _controller.text.isNotEmpty ? IconButton(
              onPressed: () {
                _controller.clear();
                ref
                    .read(searchQueryProvider.notifier)
                    .state = '';
              },
              icon: Icon(
                  Icons.clear,
                  color: AppColors.primaryColor
              )
          ) : null,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
      cursorColor: AppColors.primaryColor,
      style: TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400
      ),
    );
  }
}
