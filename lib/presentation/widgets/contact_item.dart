import 'package:contact_manager/data/models/contact_model.dart';
import 'package:contact_manager/presentation/constants/app_colors.dart';
import 'package:contact_manager/presentation/pages/update_contact_page.dart';
import 'package:contact_manager/presentation/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactItem extends ConsumerWidget {
  final Contact contact;

  const ContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onLongPress: () => _showActionMenu(context, ref),
      title: Text(
        contact.fullName,
        style: TextStyle(fontSize: 18, color: AppColors.textColor),
      ),
      subtitle: Text(
        contact.phone,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  void _showActionMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundColor,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                      Icons.delete,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  title: Text(
                      "Delete contact",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  onTap: () async {
                    final repo = ref.read(contactsRepositoryProvider);
                    await repo.deleteContact(contact.key);
                    ref.invalidate(contactsListProvider);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                const Divider(
                  thickness: 2,
                  color: AppColors.secondaryColor,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  title: Text(
                    "Edit contact",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateContactPage(contact)));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
