import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmergencyContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Us in Emergency",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "In Case of Emergency",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We're here to assist you 24/7. Reach out to us through any of the following methods:",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            ListTile(
                leading: const Icon(Icons.phone, color: Colors.redAccent),
                title: const Text("Emergency Phone"),
                subtitle: const Text("+94774213504"),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.email, color: Colors.redAccent),
                title: const Text("Email"),
                subtitle: const Text("nilupulmadhusanka2001m31@gmail.com"),
                onTap: () {}),
            const SizedBox(height: 20),
            const Text(
              "Connect on Social Media",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: const Icon(FontAwesomeIcons.facebook,
                        color: Colors.blue),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(FontAwesomeIcons.twitter,
                        color: Colors.lightBlue),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(FontAwesomeIcons.instagram,
                        color: Colors.pink),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(FontAwesomeIcons.whatsapp,
                        color: Colors.green),
                    onPressed: () {}),
              ],
            ),
            const SizedBox(height: 30),
            ListTile(
                leading: const Icon(Icons.location_on, color: Colors.redAccent),
                title: const Text("Visit Us"),
                subtitle: const Text("Kurunegala, Sri Lanka"),
                onTap: () {}),
            const Spacer(),
            const Center(
              child: const Text(
                "Available 24/7 to assist you in any emergency",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
