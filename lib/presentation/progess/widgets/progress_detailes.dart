import 'package:flutter/material.dart';

class ProgressDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.3, // Ajustez la largeur selon vos besoins
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fiche de progression",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Action de partage
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            const Row(
              children: [
                Chip(
                    label: Text("Classe XIV"),
                    backgroundColor: Color.fromARGB(255, 54, 216, 192)),
                SizedBox(width: 10),
                Chip(
                    label: Text("2-3 ANS"),
                    backgroundColor: Color.fromARGB(222, 219, 146, 175)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Nesrine Dziri",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildDetailRowWithIcon(
                "Animatrice", "assets/images/football.png", "Marwa Jbarra"),
            _buildDetailEnfRowWithIcon("parent", "Hinda Gharbi"),
            _buildDetailRow("Date et heure", "Jan 3, 2024, 15:00 AM"),
            _buildDetailRow("Status", "Terminé", textColor: Colors.green),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.linear_scale,
                    color: const Color.fromARGB(255, 158, 145, 145)),
                SizedBox(width: 10),
                Text("Pourcentage"),
                Spacer(),
                Text("70%"),
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: LinearProgressIndicator(
                value: 0.7,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Développement émotionnel et sensoriel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildExpansionTile(
                "Question 1",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia, justo nec ultricies sollicitudin, nunc felis interdum ante?",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia, justo nec ultricies sollicitudin, nunc felis interdum ante.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia, justo nec ultricies sollicitudin, nunc felis interdum ante."),
            _buildExpansionTile(
                "Question 2",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia, justo nec ultricies sollicitudin, nunc felis interdum ante?",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia, justo nec ultricies sollicitudin, nunc felis interdum ante.",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia, justo nec ultricies sollicitudin, nunc felis interdum ante."),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRowWithIcon(String label, String imageUrl, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black26),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(imageUrl), // Remplace par ton image
              ),
              SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDetailEnfRowWithIcon(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black26),
          ),
          child: Row(
            children: [
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? textColor}) {
    return Row(
      children: [
        Text("$label: "),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildExpansionTile(
      String question, String content, String response, String remark) {
    return ExpansionTile(
      title: Text(question),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content),
              SizedBox(height: 10),
              Text(
                "Réponse",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(response),
              SizedBox(height: 10),
              Text(
                "Remarque",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(remark),
            ],
          ),
        ),
      ],
    );
  }
}
