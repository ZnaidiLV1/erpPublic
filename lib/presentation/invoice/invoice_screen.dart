import 'package:flutter/material.dart';

import 'components/add_invoice.dart';
import 'components/invoice_body.dart';
import 'components/invoice_details.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  int index = 0;

  void _changeScreen(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        InvoiceBody(
            onAddPressed: () => _changeScreen(1),
            onItemPressed: () => _changeScreen(2)),
        AddInvoice(onCancelPressed: () => _changeScreen(0)),
        InvoiceDetails(onCancelPressed: () => _changeScreen(0))
      ],
    );
  }
}
