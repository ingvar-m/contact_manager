import 'package:contact_manager/data/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../providers/contact_provider.dart';
import '../widgets/action_button.dart';
import '../widgets/data_field.dart';
import '../widgets/phone_field.dart';

class UpdateContactPage extends ConsumerStatefulWidget {

  final Contact contact;

  const UpdateContactPage(this.contact, {super.key});

  @override
  ConsumerState<UpdateContactPage> createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends ConsumerState<UpdateContactPage> {

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.contact.firstName);
    _lastNameController = TextEditingController(text: widget.contact.lastName);
    _phoneController = TextEditingController(text: widget.contact.phone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Update contact",
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
                      text: 'Update',
                      onPressed: () async {
                        if(!_phoneController.text.isEmpty && !_firstNameController.text.isEmpty) {
                          final repo = ref.read(contactsRepositoryProvider);
                          widget.contact.firstName = _firstNameController.text;
                          widget.contact.lastName = _lastNameController.text;
                          widget.contact.phone = _phoneController.text;
                          await repo.updateContact(widget.contact);
                          ref.invalidate(contactsListProvider);
                          if(context.mounted) Navigator.pop(context);
                        }
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

