import 'package:flutter/material.dart';

class PrimeCareKanbanCard {
  final String id;
  final String title;
  final String subtitle;

  const PrimeCareKanbanCard({
    required this.id,
    required this.title,
    this.subtitle = '',
  });
}

class PrimeCareKanbanColumn {
  final String id;
  final String title;
  final List<PrimeCareKanbanCard> cards;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const PrimeCareKanbanColumn({
    required this.id,
    required this.title,
    required this.cards,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
}

class KanbanWaitlistBoard extends StatelessWidget {
  final List<PrimeCareKanbanColumn> columns;
  final void Function(String cardId, String oldColumnId, String newColumnId)?
  onCardMoved;

  const KanbanWaitlistBoard({
    super.key,
    required this.columns,
    this.onCardMoved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: columns.length,
        itemBuilder: (context, index) {
          final column = columns[index];
          return DragTarget<String>(
            onAcceptWithDetails: (details) {
              if (onCardMoved != null) {
                // In a robust scenario, encode origin column as well inside the payload
                onCardMoved!(details.data, '', column.id);
              }
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: candidateData.isNotEmpty
                      ? column.backgroundColor.withAlpha(150)
                      : column.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: candidateData.isNotEmpty
                        ? column.textColor
                        : column.borderColor,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      column.title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: column.textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: column.cards.length,
                        itemBuilder: (context, cardIndex) {
                          final card = column.cards[cardIndex];
                          return Draggable<String>(
                            data: card.id,
                            feedback: Material(
                              elevation: 4,
                              child: _buildCardUI(card),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.5,
                              child: _buildCardUI(card),
                            ),
                            child: _buildCardUI(card),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCardUI(PrimeCareKanbanCard card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
          ),
          if (card.subtitle.isNotEmpty)
            Text(
              card.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
            ),
        ],
      ),
    );
  }
}
