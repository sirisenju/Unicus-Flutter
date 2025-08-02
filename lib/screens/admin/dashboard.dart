import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/custom.selected.button.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String selectedListingType = "";
  String selectedPropertyType = "";

  //logout function
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  //image picker
  Future<String?> pickImage() async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      return pickedImage.path;
    }

    final file = File(pickedImage!.path);
    final fileBytes = await file.readAsBytes();
    final filename = file.path.split('/').last;
    print(filename);

    final supabase = Supabase.instance.client;
    final uplaodResposne = await supabase.storage
        .from('property_images')
        .uploadBinary(
        filename,
        fileBytes,
        fileOptions: const FileOptions(
          upsert: true,
        )
    );

    if(uplaodResposne.isEmpty){
      throw Exception('Failed to upload image');
    }

    final imageUrl = supabase.storage.from('property_images').getPublicUrl(filename);
    return imageUrl;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Add Listings", style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),),
        actions: [
          GestureDetector(
            onTap: () {
              logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const CircleAvatar(child: Icon(Icons.logout)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1000,
                  color: Color.fromRGBO(243, 243, 249, 1.0),
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Property Details", style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Fill the following basic property details to list out your properties", style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 110,
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Listing Type", style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    SizedBox(
                                      height: 10,
                                    ),
        
                                    CustomSelectableButtons(
                                      options: ['Rent', 'Sale'],
                                      onSelected: (value) {
                                        setState(() {
                                          selectedListingType = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: (){
                                pickImage();
                              },
                              child: Text("Pick image")
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelTxt: "Size",
                              hintTxt: "Enter size of the property",
                              keyboardType: TextInputType.number,
                              obsureText: false,
                          ),
                          CustomTextField(
                            labelTxt: "Price",
                            hintTxt: "Enter price of the property",
                            keyboardType: TextInputType.number,
                            obsureText: false,
                          ),
                          CustomTextField(
                            labelTxt: "Bedrooms",
                            hintTxt: "Enter Numbers of the Bedrooms",
                            keyboardType: TextInputType.number,
                            obsureText: false,
                          ),
                          Container(
                            height: 110,
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Property Type", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  CustomSelectableButtons(
                                    options: ['House', 'Apartment'],
                                    onSelected: (value) {
                                      setState(() {
                                        selectedPropertyType = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelTxt: "Description",
                              hintTxt: "Enter Description",
                              keyboardType: TextInputType.text,
                              obsureText: false,
                              isTextArea: true,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox(
                                height: 50,

                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(74, 67, 236, 1.0),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                  child: Text("Submit", style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ),

                              ))
                            ],
                          ),
                        ],
                      ),
                  )
                  ,
                )
              ],
            ),
        ),
      ),
    );
  }
}
