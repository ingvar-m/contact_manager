import 'package:contact_manager/data/models/contact_model.dart';
import 'package:contact_manager/presentation/providers/contact_provider.dart';
import 'package:contact_manager/presentation/widgets/action_button.dart';
import 'package:contact_manager/presentation/widgets/data_field.dart';
import 'package:contact_manager/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';

class CreateContactPage extends ConsumerWidget {

  CreateContactPage({super.key});

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "New contact",
          style: TextStyle(
              fontSize: 24,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: AppColors.primaryColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const Spacer(),
            Icon(
              Icons.person_outline,
              size: 128,
              color: AppColors.primaryColor,
            ),
            const Spacer(),
            Column(
              children: [
                DataField(text: "First name", controller: _firstNameController),
                DataField(text: "Last name", controller: _lastNameController),
                const SizedBox(height: 32,),
                PhoneField(text: "Phone", controller: _phoneController),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                      text: 'Save',
                      onPressed: () async {
                        final repo = ref.read(contactsRepositoryProvider);
                        if(!_phoneController.text.isEmpty && !_firstNameController.text.isEmpty) {
                          final newContact = Contact(
                              phone: _phoneController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text
                          );
                          await repo.addContact(newContact);
                          ref.read(contactsListProvider.notifier);
                          ref.invalidate(contactsListProvider);
                        }
                        Navigator.pop(context);
                      }
                  ),
                ),
                const SizedBox(width: 32,),
                Expanded(
                  child: ActionButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
