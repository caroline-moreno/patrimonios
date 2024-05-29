import 'package:flutter/material.dart';
import 'package:patrimonios/styles/styles.dart';

class BtnHome extends StatefulWidget {
  final IconData icone;
  final void Function() onTap;
  const BtnHome({super.key, required this.icone, required this.onTap});

  @override
  State<BtnHome> createState() => _BtnHomeState();
}

class _BtnHomeState extends State<BtnHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Cores.cinzaclaro,
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icone,
                  size: 70,
                  color: Cores.vermelho,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
