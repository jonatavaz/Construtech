import 'package:construtech/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatefulWidget {
  final Color? selectedItemColor;
  final List<CustomBottomAppBarItem> children;
   final int currentIndex; // NOVO: Índice atual selecionado
  final ValueChanged<int> onItemSelected;

  const CustomBottomAppBar({
    Key? key,
    this.selectedItemColor,
    required this.children,
    required this.currentIndex, // Requer o índice atual
    required this.onItemSelected,
  }) : assert(children.length == 5, 'children.length must be 5'),
       super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedItemIndex = 0;

    @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((item) {
          final int itemIndex = widget.children.indexOf(item);
          // Usa widget.currentIndex que vem do pai
          final bool isSelected = itemIndex == widget.currentIndex; 

          return Expanded(
            child: InkWell(
              onTap: item.onPressed == null ? null : () {
                // Notifica o widget pai sobre o item selecionado
                widget.onItemSelected(itemIndex); 
                // E executa a ação original do item (navegação de página)
                item.onPressed?.call();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Icon(
                  isSelected ? item.primaryIcon : item.secondaryIcon,
                  color: isSelected
                      ? widget.selectedItemColor
                      : AppColors.purple,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final String? label;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final VoidCallback? onPressed;

  CustomBottomAppBarItem({
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });

  CustomBottomAppBarItem.empty({
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });
}
