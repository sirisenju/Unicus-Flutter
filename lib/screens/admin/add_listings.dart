import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/admin_sidebar.dart';
import 'package:flutter_class_git/widgets/custom.selected.button.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart';
// import 'package:image/image.dart' as img;
class AddListings extends StatefulWidget {
  const AddListings({super.key});

  @override
  State<AddListings> createState() => _AddListingsState();
}

class _AddListingsState extends State<AddListings> {

  final TextEditingController _location = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _bedrooms = TextEditingController();
  final TextEditingController _bathrooms = TextEditingController();
  final TextEditingController _description = TextEditingController();
  // final TextEditingController _is_available = TextEditingController();
  final TextEditingController _size_sqft = TextEditingController();

  String selectedListingType = "";
  String selectedPropertyType = "";
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  //logout function
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  //pickImage
  Future<void> pickImage() async{
    try{
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      print("Picked image: ${pickedImage!.path}");
      if(pickedImage != null){
        setState(() {
          _selectedImage = File(pickedImage.path);
          print("Selected image: ${_selectedImage!.path}");
        });
      }
    }
    catch(e){
      print("Error picking image: $e");
    }
  }



  //upload image to storage bucket
  Future<String?> uploadImage(File imageFile) async{

    try{
      final fileBytes = await imageFile.readAsBytes();
      final filename = imageFile.path.split('/').last;

      final supabase = Supabase.instance.client;
      final uplaodResposne = await supabase.storage
          .from('property-images')
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

      final imageUrl = supabase.storage.from('property-images').getPublicUrl(filename);
      return imageUrl;
    }
    catch(e){
      print("Upload error: $e");
    }
  }

  //upload property
  void uploadProperty() async{
    if(_selectedImage == null){
      print("no image selected");
      return;
    }

    final imageUrl = await uploadImage(_selectedImage!);

    if(imageUrl != null){
      //insert to supabase
      final response = await supabase.from('properties').insert({
        'owner_id': Supabase.instance.client.auth.currentUser!.id,
        'location': _location.text,
        'price': int.parse(_price.text),               //  convert to int
        'size_sqft': int.parse(_size_sqft.text),       //  convert to int
        'bedrooms': int.parse(_bedrooms.text),            //  convert to int
        'bathrooms': int.parse(_bathrooms.text),          //  convert to int
        'description': _description.text,
        'property_type': selectedPropertyType,
        // 'listing_type': selectedListingType,
        'image_url': imageUrl,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'is_available': "Yes",
      });

      if(response.error != null){
        print("Error: ${response.error}");
      }
      else{
        print("Success: ${response.data}");
      }
    }
    else{
      print("No image selected");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // sidebar

      drawer: AdminSidebar(),

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
                height: 1200,
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
                      // Container(
                      //   child: _selectedImage! != null ? Image.file(_selectedImage!, height: 100,) :
                      //   Text("No image selected.") ,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        labelTxt: "Size",
                        hintTxt: "Enter size of the property",
                        keyboardType: TextInputType.number,
                        obsureText: false,
                        controller: _size_sqft,

                      ),
                      CustomTextField(
                        labelTxt: "Location",
                        hintTxt: "Enter Location of the property",
                        keyboardType: TextInputType.number,
                        obsureText: false,
                        controller: _location,

                      ),
                      CustomTextField(
                        labelTxt: "Bathroom",
                        hintTxt: "Enter Number Of Bathrooms",
                        keyboardType: TextInputType.number,
                        obsureText: false,
                        controller: _bathrooms,

                      ),
                      CustomTextField(
                        labelTxt: "Price",
                        hintTxt: "Enter price of the property",
                        keyboardType: TextInputType.number,
                        obsureText: false,
                        controller: _price,
                      ),
                      CustomTextField(
                        labelTxt: "Bedrooms",
                        hintTxt: "Enter Numbers of the Bedrooms",
                        keyboardType: TextInputType.number,
                        obsureText: false,
                        controller: _bedrooms,
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
                        controller: _description,
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                //function for uplaoding the property
                                uploadProperty();
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
