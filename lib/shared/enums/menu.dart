enum Menu {
  edit('Edit'),
  delete('Delete'),
  moveToPrivate('Move to Private'),
  moveToPublic('Move to Public'),
  removeFromShelf('Remove from Shelf'),
  share('Share');

  const Menu(this.title);

  final String title;
}
