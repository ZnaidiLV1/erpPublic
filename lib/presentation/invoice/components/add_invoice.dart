import 'package:flutter/material.dart';

class AddInvoice extends StatefulWidget {
  final VoidCallback onCancelPressed;
  const AddInvoice({super.key, required this.onCancelPressed});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(onPressed: widget.onCancelPressed, icon: const Icon(Icons.close)),
            ),
          ],
        ),
        const Text("Add"),
      ],
    );
  }
}


