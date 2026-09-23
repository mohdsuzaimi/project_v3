import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const ProjectV3());
}

class ProjectV3 extends StatelessWidget {
  const ProjectV3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jimmy NFC Card',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
      ),
      home: const BusinessCard(),
    );
  }
}

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key});

  static const Color gold = Color(0xFFD4AF37);

  Future<void> saveContact(BuildContext context) async {
    try {
      final permission = await Permission.contacts.request();

      if (!permission.isGranted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contacts permission is required.'),
            ),
          );
        }
        return;
      }

      final contact = Contact(
        name: Name(
          first: 'JIMMY',
        ),
        phones: [
          Phone(
            number: '011 7352 1488',
            label: Label(PhoneLabel.mobile),
          ),
        ],
      );

      await FlutterContacts.create(contact);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('JIMMY saved to contacts'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to save contact: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AspectRatio(
              aspectRatio: 1.58,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF090909),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: gold.withOpacity(0.8),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gold.withOpacity(0.12),
                      blurRadius: 30,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 22,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SIMPLE J LOGO
                    const SimpleJLogo(),

                    const Text(
                      'JIMMY',
                      style: TextStyle(
                        color: gold,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.2,
                      ),
                    ),

                    const DiamondDivider(),

                    const Text(
                      '011 7352 1488',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 2,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        saveContact(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: gold.withOpacity(0.7),
                            width: 0.8,
                          ),
                        ),
                        child: const Text(
                          'SAVE CONTACT',
                          style: TextStyle(
                            color: gold,
                            fontSize: 9,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// SIMPLE LUXURY J LOGO
// ================================================================

class SimpleJLogo extends StatelessWidget {
  const SimpleJLogo({super.key});

  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: gold.withOpacity(0.7),
          width: 0.8,
        ),
      ),
      child: const Text(
        'J',
        style: TextStyle(
          color: gold,
          fontFamily: 'serif',
          fontSize: 34,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          height: 1,
        ),
      ),
    );
  }
}

// ================================================================
// DIAMOND DIVIDER
// ================================================================

class DiamondDivider extends StatelessWidget {
  const DiamondDivider({super.key});

  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 25,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 0.7,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    gold,
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          CustomPaint(
            size: const Size(20, 20),
            painter: FacetedDiamondPainter(),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Container(
              height: 0.7,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gold,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// FACETED DIAMOND
// ================================================================

class FacetedDiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double centerX = w / 2;

    final Path diamond = Path()
      ..moveTo(centerX, 0)
      ..lineTo(w, h * 0.38)
      ..lineTo(centerX, h)
      ..lineTo(0, h * 0.38)
      ..close();

    final Paint mainPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFEFA8),
          Color(0xFFD4AF37),
          Color(0xFF8A6815),
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, w, h),
      );

    canvas.drawPath(diamond, mainPaint);

    final Path topFacet = Path()
      ..moveTo(centerX, 0)
      ..lineTo(w, h * 0.38)
      ..lineTo(centerX, h * 0.50)
      ..close();

    canvas.drawPath(
      topFacet,
      Paint()..color = const Color(0xFFFFF3C4),
    );

    final Path leftFacet = Path()
      ..moveTo(0, h * 0.38)
      ..lineTo(centerX, h * 0.50)
      ..lineTo(centerX, h)
      ..close();

    canvas.drawPath(
      leftFacet,
      Paint()..color = const Color(0xFFB58A20),
    );

    final Path rightFacet = Path()
      ..moveTo(w, h * 0.38)
      ..lineTo(centerX, h * 0.50)
      ..lineTo(centerX, h)
      ..close();

    canvas.drawPath(
      rightFacet,
      Paint()..color = const Color(0xFFE7C85A),
    );

    canvas.drawPath(
      diamond,
      Paint()
        ..color = const Color(0xFFFFE28A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}