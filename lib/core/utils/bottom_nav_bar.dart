import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class BottomNavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavShell({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kShadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () => _onTap(0),
            ),
            _NavItem(
              icon: Icons.mail_outline,
              label: 'Inbox',
              isActive: currentIndex == 1,
              onTap: () => _onTap(1),
            ),
            _NavItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              isActive: currentIndex == 2,
              onTap: () => _onTap(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppConstants.spacing8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive
                    ? AppColors.kPrimaryBlue
                    : AppColors.kTextSecondary,
                size: 24,
              ),
              SizedBox(height: AppConstants.spacing4),
              Text(
                label,
                style: isActive
                    ? AppStyles.navLabelActive(context)
                    : AppStyles.navLabel(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
