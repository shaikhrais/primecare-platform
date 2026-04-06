import 'package:flutter/material.dart';

class NursingNotesScreen extends StatelessWidget {
  const NursingNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nursing Notes',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006948), // Emerald Teal
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  elevation: 0,
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text(
                  'New Note',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Pane: Recent Notes List
                Expanded(
                  flex: 4,
                  child: _buildNotesList(),
                ),
                const SizedBox(width: 32),
                // Right Pane: Active Note Details
                Expanded(
                  flex: 6,
                  child: _buildActiveNote(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6), // surface-container-low
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Color(0xFF3D4A42)),
                hintText: 'Search notes...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF3D4A42),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildNoteListItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteListItem(int index) {
    bool isActive = index == 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? null : Border.all(color: const Color(0xFFBCCAC0).withOpacity(0.4)),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF191C1E).withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jane Smith',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF191C1E),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF006948),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Shift Assessment - Morning',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF3D4A42),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: Color(0xFFBCCAC0)),
              SizedBox(width: 4),
              Text(
                'Oct 24, 2026 • 09:15 AM',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Color(0xFF6D7A72),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveNote() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE6E8EA))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shift Assessment - Morning',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F0EC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Signed',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF006948),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Patient: Jane Smith',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF3D4A42),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.print_outlined, color: Color(0xFF5654A8)),
                )
              ],
            ),
          ),
          // Content
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subjective',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF5654A8), // Navy Indigo
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Patient reports feeling "a bit short of breath" this morning. Denies chest pain. States she slept well through the night.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      height: 1.6,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Objective',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF5654A8),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Vitals: BP 130/80, HR 88, RR 20, O2 Sat 94% on room air.\nLung sounds diminished in bases bilaterally, no wheezes or crackles noted. $+2 edema in lower extremities.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      height: 1.6,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Assessment',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF5654A8),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Stable symptoms of CHF. Current mild exacerbation managed with recent Lasix dose increment.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      height: 1.6,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer Actions
          Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Color(0xFFF2F4F6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Add Addendum',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D4A42),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006948),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text('Co-Sign Note'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
