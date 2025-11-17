class CartService {
  CartService._private();
  static final CartService instance = CartService._private();

  final List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => List.unmodifiable(_items);

  void addItem(Map<String, String> item) {
    _items.add(item);
  }

  void removeAt(int index) {
    _items.removeAt(index);
  }

  void clear() {
    _items.clear();
  }
}
