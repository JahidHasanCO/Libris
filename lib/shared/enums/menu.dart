enum Menu {
  edit('Edit'),
  delete('Delete'),
  moveToPrivate('Move to Private'),
  moveToPublic('Move to Public'),
  share('Share');

  const Menu(this.title);

  final String title;
}
