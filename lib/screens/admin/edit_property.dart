import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/admin_sidebar.dart';
import 'package:flutter_class_git/widgets/custom.selected.button.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart';
import '../Models/property.model.dart';
// import 'package:image/image.dart' as img;
class EditProperty extends StatefulWidget {
  const EditProperty({super.key});

  @override
  State<EditProperty> createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {

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

// loads the page in accordance of id pass by route
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      fetchPropertyById(id);
    });
  }
// fetch property by id
Future<void> fetchPropertyById(String id) async {
    final supabaseClient = Supabase.instance.client;

    try {
      final property = await supabaseClient
          .from('properties')
          .select()
          .eq('id', id)
          .single();

      if (property.isNotEmpty) {
        _description.text = property['description'] ?? '';
        _location.text = property['location'] ?? '';
        _price.text = property['price']?.toString() ?? '';
        _size_sqft.text = property['size_sqft']?.toString() ?? '';
        _bedrooms.text = property['bedrooms']?.toString() ?? '';
        _bathrooms.text = property['bathrooms']?.toString() ?? '';

        setState(() {}); // refresh UI after setting controllers
      }
    } catch (e) {
      print("Error fetching property: $e");
    }
  }


  Future<void> _updateProperty(String id) async {
    try {
      final supabaseClient = Supabase.instance.client;

      await supabaseClient
          .from('properties')
          .update({
        'location': _location.text,
        'price': double.tryParse(_price.text) ?? 0,
        'bedrooms': int.tryParse(_bedrooms.text) ?? 0,
        'bathrooms': int.tryParse(_bathrooms.text) ?? 0,
        'description': _description.text,
        'size_sqft': double.tryParse(_size_sqft.text) ?? 0,
        'is_available': selectedListingType == 'Rent',
        'property_type': selectedPropertyType,
      })
          .eq('id', id)
          .select();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property updated successfully')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      print("Error updating property: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update property')),
      );
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
        title: Text("Edit Listings", style: TextStyle(
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
                                final propertyId = ModalRoute.of(context)!.settings.arguments as String;
                                _updateProperty(propertyId);
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
