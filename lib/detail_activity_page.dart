import 'package:flutter/material.dart';

class DetailActivityPage extends StatelessWidget {
  // Poin 5c – Data diterima via constructor (Pertemuan 4)
  final String activityName;
  final Color activityColor;
  final IconData activityIcon;
  final int activityIndex;

  const DetailActivityPage({
    super.key,
    required this.activityName,
    required this.activityColor,
    required this.activityIcon,
    required this.activityIndex,
  });

  @override
  Widget build(BuildContext context) {
    // Poin 6 – Responsive
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? screenWidth * 0.2 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: activityColor,
        foregroundColor: Colors.white,
        title: const Text('Detail Aktivitas'),
        // Tombol back otomatis dari Navigator
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hero Icon
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: activityColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: activityColor.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  activityIcon,
                  size: 56,
                  color: activityColor,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Card detail
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Aktivitas',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Poin 5b – Tampilkan nama aktivitas
                  Text(
                    activityName,
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: activityColor,
                            ),
                  ),

                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade200),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.tag, size: 18, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Text(
                        'Aktivitas ke-$activityIndex',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.today_outlined,
                          size: 18, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Text(
                        'Terjadwal hari ini',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tombol kembali – Navigator.pop (Poin 2c)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Kembali ke Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: activityColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
