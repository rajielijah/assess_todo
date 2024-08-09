import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          left: 40,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 16,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        Positioned(
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.orange,
            radius: 16,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 16,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// class AvatarStack extends StatelessWidget {
//   const AvatarStack({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 32, // Set a fixed height to the stack to ensure it displays correctly
//       child: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             child: CircleAvatar(
//               backgroundColor: Colors.blue,
//               radius: 16,
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             left: 24, // Offset to the right to create overlapping effect
//             child: CircleAvatar(
//               backgroundColor: Colors.orange,
//               radius: 16,
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             left: 48, // Further offset to the right to create overlapping effect
//             child: CircleAvatar(
//               backgroundColor: Colors.green,
//               radius: 16,
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
