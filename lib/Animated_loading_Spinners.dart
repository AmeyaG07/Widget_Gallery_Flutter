import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinnersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> spinnerData = [
    {"widget": SpinKitCircle(color: Colors.blue, size: 50.0), "name": "Circle"},
    {"widget": SpinKitFadingCube(color: Colors.deepPurple, size: 50.0), "name": "Fading Cube"},
    {"widget": SpinKitDoubleBounce(color: Colors.green, size: 50.0), "name": "Double Bounce"},
    {"widget": SpinKitWave(color: Colors.orange, size: 50.0, type: SpinKitWaveType.center), "name": "Wave"},
    {"widget": SpinKitChasingDots(color: Colors.red, size: 50.0), "name": "Chasing Dots"},
    {"widget": SpinKitThreeBounce(color: Colors.purple, size: 50.0), "name": "Three Bounce"},
    {"widget": SpinKitWanderingCubes(color: Colors.cyan, size: 50.0), "name": "Wandering Cubes"},
    {"widget": SpinKitFadingFour(color: Colors.teal, size: 50.0), "name": "Fading Four"},
    {"widget": SpinKitHourGlass(color: Colors.indigo, size: 50.0), "name": "Hour Glass"},
    {"widget": SpinKitPulse(color: Colors.pink, size: 50.0), "name": "Pulse"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Animated Loading Spinners"),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: spinnerData.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  spinnerData[index]["widget"],
                  const SizedBox(height: 10),
                  Text(
                    spinnerData[index]["name"],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
