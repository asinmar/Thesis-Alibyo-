// import 'package:flutter/material.dart';
// import '../model/resident.dart';
// import '../model/residentt.dart';

// class DisplayData extends StatefulWidget {
//   final List<Residentt> res;

//   DisplayData(this.res);
//   @override
//   _DisplayDataState createState() => _DisplayDataState();
// }

// class _DisplayDataState extends State<DisplayData> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: widget.res.length,
//         itemBuilder: (context, int index) {
//           return Card(
//             elevation: 5,
//             child: Container(
//               padding: EdgeInsets.all(15),
//               child: ListTile(
//                 title: Text(widget.res[index].name),
//                 subtitle: Text(widget.res[index].status),
//               ),
//             ),
//           );
//         });
//   }
// }
