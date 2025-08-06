import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_class_git/screens/Models/property.model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/propertycard.dart';
import '../widgets/owned_property_tile.dart';
import '../widgets/categoryitem.dart';
import 'main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});


  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late Future<List<PropertyModel>> _properties;

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  //FETCH DATA FROM SUPABSE
  Future<List<PropertyModel>> fetchProperties() async {
    final supabaseClient = Supabase.instance.client; // Renamed for clarity

    try {
      final response = await supabaseClient.from('properties').select();

      if(response.isNotEmpty){
        print("Data resposne: $response");
        return response.map((item) {
          return PropertyModel.fromJson(item);
        }).toList();
      }else{
        print("No properties found");
        return [];
      }
    } catch (e) {
      print("Error fetching properties: $e");
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _properties = fetchProperties();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Favour', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Here’s an overview of your dashboard', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.notifications_none)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const CircleAvatar(child: Icon(Icons.logout)),
                    )
                  ],
                )
              ],
            ),
            MaterialButton(onPressed: (){
              fetchProperties();
            }, child: Text("Click me"),),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Color(0xFFF0EDFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryItem(label: 'House', icon: Icons.apartment),
                  CategoryItem(label: 'Apartment', icon: Icons.home),
                  CategoryItem(label: 'Factory', icon: Icons.factory),
                  CategoryItem(label: 'Townhouse', icon: Icons.villa),
                  CategoryItem(label: 'Land', icon: Icons.terrain),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Recommendation', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('See All', style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 8),
            //DISPLAYING OUR ITEMS
            Container(
              height: 500,
              child: FutureBuilder<List<PropertyModel>>(
                future: _properties,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final data = snapshot.data;
                  print("Data is: $data");
                  if (data == null || data.isEmpty) {
                    return Center(child: Text('No data available'));
                  }
                  return ListView.builder(
                      itemCount:  data.length,
                      itemBuilder: (context, index){
                        final item = data[index];
                        return Container(
                          child: Column(
                            children: [
                              Text(item.location),
                              Text(item.ownerId),
                              Text(item.description),
                              Text("${item.price}"),
                              Text("${item.propertyType}"),
                              Image(image: NetworkImage(item.imageUrl)),
                              Text("${item.bedrooms}"),
                              Text("${item.bathrooms}"),
                              Text("${item.sizeSqft}"),
                              Text("${item.createdAt}"),
                              Text("${item.updatedAt}"),
                            ],
                          ),
                        );
                      }
                  );
                },
              ),
            ),


            //TODO: MAKE THE PROPERTY DYNAMIC TO TAKE IN THE NECESSARY INFOR TO BUILD
            PropertyCard(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Owned Properties', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('See All', style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 8),
            const OwnedPropertyTile(),
          ],
        ),
      ),
    );
  }
}
