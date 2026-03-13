import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_card.dart';
import 'package:plexuspules/core/widgets/common_search_bar.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();
  
  final List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _fetchPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _fetchPage();
    }
  }

  Future<void> _fetchPage() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> newItems = List.generate(_pageSize, (index) {
      final id = (_page - 1) * _pageSize + index + 1;
      return {
        'name': 'Device-$id',
        'ipAddress': '192.168.1.$id',
        'location': id % 2 == 0 ? 'Singapore Data Center' : 'New York Node',
        'status': id % 3 == 0 ? DeviceStatus.offline : DeviceStatus.online,
        'icon': id % 2 == 0 ? Icons.router_outlined : Icons.storage_outlined,
      };
    });

    if (mounted) {
      setState(() {
        _items.addAll(newItems);
        _isLoading = false;
        _page++;
        // Stop after 5 pages (50 items) for this mock implementation
        if (_page > 5) {
          _hasMore = false;
        }
      });
    }
  }

  void _resetPagination(String filter) {
    setState(() {
      _selectedFilter = filter;
      _items.clear();
      _page = 1;
      _hasMore = true;
      _isLoading = false;
    });
    _fetchPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(AppSizes.p20),
              child: const CommonSearchBar(hintText: 'Search device or IP...'),
            ),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onSelect: () => _resetPagination('All'),
                  ),
                  AppSizes.gap12,
                  _FilterChip(
                    label: 'Online',
                    isSelected: _selectedFilter == 'Online',
                    onSelect: () => _resetPagination('Online'),
                  ),
                  AppSizes.gap12,
                  _FilterChip(
                    label: 'Offline',
                    isSelected: _selectedFilter == 'Offline',
                    onSelect: () => _resetPagination('Offline'),
                  ),
                ],
              ),
            ),

            AppSizes.gap20,

            // Device List
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(
                  AppSizes.p20,
                  0,
                  AppSizes.p20,
                  AppSizes.p40, // Added bottom padding
                ),
                itemCount: _items.length + (_hasMore ? 1 : 0),
                separatorBuilder: (context, index) => AppSizes.gap16,
                itemBuilder: (context, index) {
                  if (index < _items.length) {
                    final device = _items[index];
                    return DeviceCard(
                      name: device['name'],
                      ipAddress: device['ipAddress'],
                      location: device['location'],
                      status: device['status'],
                      icon: device['icon'],
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSizes.p20),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const SizedBox.shrink(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (theme.brightness == Brightness.light
                  ? Colors.white
                  : theme.colorScheme.surface),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (theme.brightness == Brightness.light
                    ? AppColors.cardBorder
                    : theme.colorScheme.outlineVariant),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (theme.brightness == Brightness.light
                    ? AppColors.textSecondary
                    : theme.colorScheme.onSurfaceVariant),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
