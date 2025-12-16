import 'package:flutter/material.dart';
import 'package:pinchecker/views/add_card_view.dart';
import 'package:pinchecker/views/all_cards_view.dart';
import 'package:pinchecker/views/scan_card_view.dart';
import 'package:pinchecker/views/show_pin_view.dart';

class ViewList extends StatefulWidget {
  const ViewList({super.key});

  @override
  State<ViewList> createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('List View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowPinView()));
            }, child: const Text("SHOW PIN")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCardView()));
            }, child: const Text("ADD CARD")),  
            const SizedBox(height: 10),
            ElevatedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> ScanCardView()));
            }, child: Text("SCAN CARD")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AllCardsView()));
            }, child: Text("Show Your All card detial "))
          ],
        ),
      ),
    );
  }
}