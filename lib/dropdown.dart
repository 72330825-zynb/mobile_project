import 'package:flutter/material.dart';
import '../area.dart';

class AreaDropdown extends StatelessWidget {
  final List<Area> areas;
  final Area? selectedArea;
  final Function(Area) onSelect;

  const AreaDropdown({required this.areas, required this.selectedArea, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFDFE8ED),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
      ),
      child: DropdownButton<Area>(
        value: selectedArea,
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        items: areas.map((area) => DropdownMenuItem(
          value: area,
          child: Text(area.name, style: TextStyle(fontSize: 16)),
        )).toList(),
        onChanged: (area) { if (area != null) onSelect(area); },
      ),
    );
  }
}

