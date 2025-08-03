import 'package:flutter/material.dart';
import 'package:flutter_class_git/bottomnav.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});


  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  final List<Map<String, dynamic>> properties = [
    {
      'image': 'assets/house.png',
      'title': '4 bedroom duplex',
      'description': 'Located in Lekki Phase 1'
    },
    {
      'image': 'assets/house.png',
      'title': '4 bedroom duplex',
      'description': 'Located in Lekki Phase 1'
    },
    {
      'image': 'assets/house.png',
      'title': '4 bedroom duplex',
      'description': 'Located in Lekki Phase 1'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                MaterialPageRoute(builder: (_) => BottomNav(initialIndex: 0)
                ),
              );
            },

        ),
        backgroundColor: Colors.white,
        title: Text("Listings", style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w800,
    ),),
        ),

      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(
                  height: 15,
                ),
                Text("Listings", style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: properties.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      final property = properties[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.asset(
                                property['image'],
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    property['description'],
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("You clicked to buy ${property['title']}"),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(74, 67, 236, 1.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 14),
                                      ),
                                      child: Text(
                                        "Buy Property",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );

                    })
              ],
            ),
        )
      ),
    );
  }
}
