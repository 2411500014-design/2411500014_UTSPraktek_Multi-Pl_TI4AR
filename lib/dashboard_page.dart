import 'package:flutter/material.dart';
import 'add_activity_page.dart';
import 'detail_activity_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> _activities = [
    {
      'name': 'Belajar Flutter',
      'icon': Icons.code_rounded,
      'color': const Color(0xFF4A90D9),
    },
    {
      'name': 'Olahraga Pagi',
      'icon': Icons.directions_run_rounded,
      'color': const Color(0xFF50C878),
    },
    {
      'name': 'Membaca Buku',
      'icon': Icons.menu_book_rounded,
      'color': const Color(0xFFE67E22),
    },
    {
      'name': 'Memasak Makan Siang',
      'icon': Icons.restaurant_rounded,
      'color': const Color(0xFFE74C3C),
    },
    {
      'name': 'Belajar Bahasa Inggris',
      'icon': Icons.translate_rounded,
      'color': const Color(0xFF9B59B6),
    },
  ];

  final List<Color> _colorCycle = [
    const Color(0xFF4A90D9),
    const Color(0xFF50C878),
    const Color(0xFFE67E22),
    const Color(0xFFE74C3C),
    const Color(0xFF9B59B6),
    const Color(0xFF1ABC9C),
  ];

  void _navigateToAddActivity() async {
    final String? newActivity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddActivityPage()),
    );

    if (newActivity != null && newActivity.isNotEmpty) {
      setState(() {
        _activities.add({
          'name': newActivity,
          'icon': Icons.star_rounded,
          'color': _colorCycle[_activities.length % _colorCycle.length],
        });
      });
    }
  }

  void _navigateToDetail(Map<String, dynamic> activity, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailActivityPage(
          activityName: activity['name'],
          activityColor: activity['color'],
          activityIcon: activity['icon'],
          activityIndex: index + 1,
        ),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              minimumSize: const Size(80, 40),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String username = args?['username'] ?? 'Pengguna';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded, size: 24),
            const SizedBox(width: 8),
            Text(
              'Daily Activity',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.white, size: 18),
            label: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? 32 : 20,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, $username! 👋',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_activities.length} aktivitas hari ini',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? 32 : 16,
            ),
            child: Text(
              'Daftar Aktivitas',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: _activities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Belum ada aktivitas.\nTambahkan dengan tombol + di bawah.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? 32 : 16,
                      vertical: 8,
                    ),
                    itemCount: _activities.length,
                    itemBuilder: (context, index) {
                      final activity = _activities[index];
                      return _ActivityCard(
                        activity: activity,
                        index: index,
                        onTap: () => _navigateToDetail(activity, index),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddActivity,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;
  final int index;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.activity,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (activity['color'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    color: activity['color'] as Color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['name'] as String,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Aktivitas #${index + 1}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
