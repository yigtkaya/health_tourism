
import 'package:flutter/material.dart';

class ClinicDetailView extends StatefulWidget {
  final String clinicId;
  const ClinicDetailView({super.key, required this.clinicId});

  @override
  State<ClinicDetailView> createState() => _ClinicDetailViewState();
}

class _ClinicDetailViewState extends State<ClinicDetailView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
                  width: size.width * 1,
                  height: size.height * 0.22,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
      ),
    );
  }
}
