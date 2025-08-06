// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// import '../../domain/entities/bead_entity.dart';

// class BeadWidget extends StatelessWidget {
//   final BeadEntity bead;
//   final VoidCallback onTap;

//   const BeadWidget({super.key, required this.bead, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: 300.ms,
//         width: 30,
//         height: 30,
//         margin: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: bead.isActive
//               ? Colors.orangeAccent
//               : bead.isUpper
//                   ? Colors.blueGrey
//                   : Colors.grey.shade300,
//           boxShadow: [
//             if (bead.isActive)
//               const BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 offset: Offset(2, 4),
//               )
//           ],
//         ),
//       ).animate().scale(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../domain/entities/bead_entity.dart';

/// A single bead widget that animates when tapped
class BeadWidget extends StatelessWidget {
  final BeadEntity bead;
  final VoidCallback onTap;

  const BeadWidget({
    super.key,
    required this.bead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = bead.isActive;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 36,
        height: 36,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: isActive
                ? [Colors.orange.shade300, Colors.deepOrange]
                : [Colors.grey.shade300, Colors.grey.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
      ).animate().scale(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1, 1),
          ),
    );
  }
}
