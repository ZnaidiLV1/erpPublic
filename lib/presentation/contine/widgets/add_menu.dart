import 'package:flutter/material.dart';

class AddMenuForm extends StatefulWidget {
  const AddMenuForm({Key? key}) : super(key: key);

  @override
  State<AddMenuForm> createState() => _AddMenuFormState();
}

class _AddMenuFormState extends State<AddMenuForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: 429,
        height: 1024,
        color: Colors.white,
        child: Column(
          children: [
            // Header with title and close button
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ajouter un menu',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Color.fromRGBO(46, 38, 61, 0.6),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable form content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date input
                      _buildLabel("Date de menu*"),
                      const SizedBox(height: 20),
                      _buildDateField("Choisir date"),
                      const SizedBox(height: 30),

                      // Meal name input
                      _buildLabel("Nom du repas*"),
                      const SizedBox(height: 20),
                      _buildTextField("Entrez nom de repas"),
                      const SizedBox(height: 20),

                      // Meal photo
                      Text(
                        "Photo de repas *",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF303972),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildImageUpload(
                          "hand-drawn-meal-prep-illustration_23-2149326634.png"),
                      const SizedBox(height: 20),

                      // Meal time
                      _buildLabel("Heure de la repas*"),
                      const SizedBox(height: 20),
                      _buildTimeField("Choisir Heure"),
                      const SizedBox(height: 30),

                      // Morning snack name
                      _buildLabel("Nom du collation matin*"),
                      const SizedBox(height: 20),
                      _buildTextField("Entrez nom de collation matin"),
                      const SizedBox(height: 20),

                      // Morning snack photo
                      Text(
                        "Photo de collation matin *",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF303972),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildImageUpload("images (14).jpg"),
                      const SizedBox(height: 20),

                      // Morning snack time
                      _buildLabel("Heure de la collation matin*"),
                      const SizedBox(height: 20),
                      _buildTimeField("Choisir Heure"),
                      const SizedBox(height: 30),

                      // Afternoon snack name
                      _buildLabel("Nom du collation aprés-midi*"),
                      const SizedBox(height: 20),
                      _buildTextField("Entrez nom de gouter aprés-midi"),
                      const SizedBox(height: 20),

                      // Afternoon snack photo
                      Text(
                        "Photo de collation aprés-midi *",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF303972),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildImageUpload("monbento-gouter-equilibre.png"),
                      const SizedBox(height: 20),

                      // Afternoon snack time
                      _buildLabel("Temps de la collation aprés-midi*"),
                      const SizedBox(height: 20),
                      _buildTimeField("Choisir l'heure"),
                      const SizedBox(height: 30),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cancel button
                          Container(
                            width: 156,
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () {
                                // Cancel action
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFF70C4CF)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Text(
                                'Annuler',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFF70C4CF),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          // Add button
                          Container(
                            width: 153,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF70C4CF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Text(
                                'Ajouter',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFF303972),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return Container(
      width: 378,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 21),
      alignment: Alignment.centerLeft,
      child: Text(
        hintText,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.4,
          color: Color(0xFF6C757D),
        ),
      ),
    );
  }

  Widget _buildDateField(String hintText) {
    return Container(
      width: 378,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF303972)),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 21),
      child: Row(
        children: [
          Text(
            hintText,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.4,
              color: Color(0xFF303972),
            ),
          ),
          Spacer(),
          Icon(
            Icons.calendar_today,
            color: Color(0xFF303972),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String hintText) {
    return Container(
      width: 378,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 21),
      child: Row(
        children: [
          Text(
            hintText,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.4,
              color: Color(0xFF303972),
            ),
          ),
          Spacer(),
          Icon(
            Icons.access_time,
            color: Color(0xFF303972),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildImageUpload(String imageName) {
    return Container(
      width: 175,
      height: 117,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFC1BBEB),
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage(imageName),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
