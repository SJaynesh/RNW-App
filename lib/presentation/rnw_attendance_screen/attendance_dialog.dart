import 'package:flutter/material.dart';

class RNWAttendanceDialog extends StatelessWidget {
  final List<String> punches;

  const RNWAttendanceDialog({super.key, required this.punches});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'In Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Out Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(
              children: List.generate(punches.length ~/ 2, (index) {
                final inTime = punches[index * 2].isNotEmpty
                    ? punches[index * 2]
                    : "--:--";
                final outTime = (index * 2 + 1) < punches.length
                    ? (punches[index * 2 + 1].isNotEmpty
                        ? punches[index * 2 + 1]
                        : "--:--")
                    : "--:--";

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        inTime.isNotEmpty ? inTime : "--:--",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        outTime.isNotEmpty ? outTime : "--:--",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
//Table 
// Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Table Header
//           Table(
//             border: TableBorder.all(color: AppColors.textColor),
//             columnWidths: const {
//               0: FlexColumnWidth(1),
//               1: FlexColumnWidth(1),
//             },
//             children: [
//               TableRow(
//                 decoration: BoxDecoration(color: Colors.grey.shade300),
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text(
//                         'In Time',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.textColor),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text(
//                         'Out Time',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.textColor),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           Table(
//             border: TableBorder.all(color: AppColors.textColor),
//             columnWidths: const {
//               0: FlexColumnWidth(1),
//               1: FlexColumnWidth(1),
//             },
//             children: List.generate(
//               punches.length ~/ 2,
//               (index) {
//                 final inTime = punches[index * 2].isNotEmpty
//                     ? punches[index * 2]
//                     : "--:--";
//                 final outTime = (index * 2 + 1) < punches.length
//                     ? (punches[index * 2 + 1].isNotEmpty
//                         ? punches[index * 2 + 1]
//                         : "--:--")
//                     : "--:--";

//                 return TableRow(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Text(inTime,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                     fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Text(outTime,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                     fontSize: 16, fontWeight: FontWeight.w500)),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16.0),
//         ],
//       ),
//     );