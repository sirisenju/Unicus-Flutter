import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/custom.selected.button.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String selectedListingType = "";
  String selectedPropertyType = "";
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
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 800,
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
