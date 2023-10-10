import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kulfii_app/app_resources/app_dimension.dart';
import 'package:kulfii_app/app_resources/custom_widgets/custom_textformfield.dart';

class EditAccountInfoScreen extends StatelessWidget {
  EditAccountInfoScreen({super.key});
  String firstName = "";
  String lastName = "";
  String emailId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Edit Profile"),
      ),
      body: ListView(
        children: [
          CustomTextFormField(
            onChanged: (value) {
              firstName = value;
            },
            initialValue: firstName,
            hintText: "First name",
          ),
          SizedBox(
            height: AppDimension.px10,
          ),
          CustomTextFormField(
            onChanged: (value) {
              lastName = value;
            },
            initialValue: lastName,
            hintText: "Last name",
          ),
            SizedBox(
            height: AppDimension.px10,
          ),
          
        ],
      ),
    );
  }
}
