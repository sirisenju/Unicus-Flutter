import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';
import '../../widgets/admin_sidebar.dart';
import '../Models/property.model.dart';
class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {

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

  // To delete
  Future<void> deleteProperty(String id) async {
    try {
      final supabaseClient = Supabase.instance.client;

      print('Deleting property with id: |${id.trim()}|');

      final response = await supabaseClient
          .from('properties')
          .delete()
          .eq('id', id)
          .select();

      print('Delete response: $response');
    } catch (e) {
      print("Error deleting property: $e");
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
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AdminSidebar(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Properties", style: TextStyle(
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

        body: FutureBuilder<List<PropertyModel>>(
          future: _properties,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No properties found'));
            }

            final properties = snapshot.data!;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Image")),
                  DataColumn(label: Text("Location")),
                  DataColumn(label: Text("Description")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Property Type")),
                  DataColumn(label: Text("No. of Bedroom")),
                  DataColumn(label: Text("Size")),
                  DataColumn(label: Text("Actions")),
                ],

                rows: properties.map((property) {
                  return DataRow(
                    cells: [
                      DataCell(
                        property.imageUrl != null
                            ? Image.network(property.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image_not_supported),
                      ),
                      DataCell(Text(property.location ?? 'N/A')),
                      DataCell(Text(property.description ?? 'N/A')),
                      DataCell(Text(property.price?.toString() ?? 'N/A')),
                      DataCell(Text(property.propertyType ?? 'N/A')),
                      DataCell(Text(property.bedrooms?.toString() ?? 'N/A')),
                      DataCell(Text(property.sizeSqft?.toString() ?? 'N/A')),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              tooltip: 'Edit',
                              onPressed: () {
                                print("Edit pressed for property ID: ${property.id}");
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Delete',
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Confirm Delete"),
                                    content: Text("Are you sure you want to delete this item?"),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await deleteProperty(property.id.toString());
                                  setState(() {
                                    _properties = fetchProperties(); // Refresh the table after deletion
                                  });
                                }

                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        )

// BODY ENDS HERE

    );

  }
}
