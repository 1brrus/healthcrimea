import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double barHeight = 65.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Серая область
            Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(barHeight / 2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      icon: Icons.shopping_basket_outlined,
                      selectedIcon: Icons.shopping_basket,
                      isSelected: currentIndex == 1,
                      onTap: () => onTap(1),
                    ),
                    const SizedBox(width: 70),

                    _NavBarItem(
                      icon: Icons.person_outline,
                      selectedIcon: Icons.person,
                      isSelected: currentIndex == 2,
                      onTap: () => onTap(2),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: -6,
              child: _CentralCartButton(
                isSelected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFE600) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: AnimatedScale(
          scale: isSelected ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isSelected ? selectedIcon : icon,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _CentralCartButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _CentralCartButton({required this.isSelected, required this.onTap});

  @override
  State<_CentralCartButton> createState() => _CentralCartButtonState();
}

class _CentralCartButtonState extends State<_CentralCartButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : (widget.isSelected ? 1.08 : 1.0),
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE600),
            shape: BoxShape.circle,
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFFFFE600).withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            widget.isSelected ? Icons.home : Icons.home_outlined,
            size: 50,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
