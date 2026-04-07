import 'package:contact_manager/presentation/constants/app_colors.dart';
import 'package:contact_manager/presentation/pages/create_contact_page.dart';
import 'package:contact_manager/presentation/widgets/contact_item.dart';
import 'package:contact_manager/presentation/widgets/contact_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/contact_provider.dart';

class MyContactsPage extends ConsumerWidget {
  const MyContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsListProvider);
    final groupedContacts = ref.watch(groupedContactsProvider);
    final letters = groupedContacts.keys.toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateContactPage()),
          );
        },
        child: Icon(Icons.person_add),
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secondaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContactSearchBar(),
              const SizedBox(height: 28,),
              Text(
                "My contacts",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: letters.length,
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 2,
                    color: AppColors.secondaryColor,
                  ),
                  itemBuilder: (context, index) {
                    final letter = letters[index];
                    final contactsInGroup = groupedContacts[letter]!;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              letter,
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: contactsInGroup.map((contact) {
                                return ContactItem(contact: contact);
                              }).toList()
                            )
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
