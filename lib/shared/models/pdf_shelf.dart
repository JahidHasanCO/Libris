class PdfShelf {
  PdfShelf({
    required this.pdfId,
    required this.shelfId,
    this.id,
  });

  factory PdfShelf.fromMap(Map<String, dynamic> map) {
    return PdfShelf(
      id: map['id'] as int?,
      pdfId: map['pdf_id'] as int,
      shelfId: map['shelf_id'] as int,
    );
  }
  final int? id;
  final int pdfId;
  final int shelfId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pdf_id': pdfId,
      'shelf_id': shelfId,
    };
  }
}
