import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/colors.dart';

class InvoiceDetails extends StatefulWidget {
  final VoidCallback onCancelPressed;

  const InvoiceDetails({super.key, required this.onCancelPressed});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: widget.onCancelPressed,
                  icon: const Icon(Icons.close)),
            ],
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Facture nº #AB2324-01",
                    style: TextStyle(
                        color: HexColor("#333843"),
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  Text(
                    "Payé le 10 Juin 2025",
                    style: TextStyle(
                        color: HexColor("#667085"),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#4CB6AC"),
                  minimumSize: const Size(200, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Iconsax.send_1, color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Envoyer la facture",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(150, 48),
                  side: BorderSide(color: HexColor("#4CB6AC"), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  "Imprimer",
                  style: TextStyle(color: HexColor("#4CB6AC")),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              width: 600,
              height: 850,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: HexColor("#F9FAFC"),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/invoice_logo.png",
                          height: 56,
                          width: 56,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Le Prince",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#E87117")),
                            ),
                            Text(
                              "leperince@email.com",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#5E6470")),
                            ),
                            Text(
                              "+216  73222555",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#5E6470")),
                            ),
                            Text(
                              "+216  73222555",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#5E6470")),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Adresse professionnelle",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#5E6470")),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "789/1 Sector-2c, 38200 Zouhour, Sousse",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#5E6470")),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 30),
                      child: Container(
                        height: 650,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: HexColor("#D7DAE0"), width: 0.5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Facturé à",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Marwa Jbarra",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#1A1C21")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Sahloul4 - Sousse",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "+216 554446666",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Facturé N°",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "INV-057",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#1A1C21")),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Montant en (DT)",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "450 DT",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#E87117")),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dtae d’émission",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "10 Juin 2025",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#1A1C21")),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date de limite de paiement",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#5E6470")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "10 Juin 2025",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#1A1C21")),
                                    ),
                                  ],
                                ),
                                const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    "Service détaie",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#5E6470")),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#5E6470")),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    "Frais",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#5E6470")),
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    "Remise",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#5E6470")),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Termes et conditions",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor("#5E6470")),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "Veuillez effectuer le paiement dans les 15 jours suivant la réception de cette facture",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#1A1C21")),
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
