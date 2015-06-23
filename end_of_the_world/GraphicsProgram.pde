public class GraphicsProgram {

  ArrayList<GObject> screenItems;

  GraphicsProgram() {
    screenItems = new ArrayList<GObject>();
  }

  void display() {
    for (int i = 0; i < screenItems.size (); i++) {
      screenItems.get(i).display();
    }
  }

  // adds new GObjects to screenItems based on their zIndex
  // objects with the same zIndex are displayed based on the order in which they were added
  void addObject(GObject newObject) {
    if (screenItems.indexOf(newObject) == -1) {
      if (screenItems.size() == 0) {
        screenItems.add(newObject);
      } else {
        sortedInsert(newObject);
      }
    }
  }

  void removeObject(GObject object) {
    screenItems.remove(object);
  }

  private void sortedInsert(GObject newObject) {
    for (int i = 0; i < screenItems.size (); i++) {
      GObject item = screenItems.get(i);
      if (compareGObjects(newObject, item) < 0) {
        screenItems.add(i, newObject);
        break;
      }
      if (i == screenItems.size()-1) {
        screenItems.add(newObject);
        break;
      }
    }
  }

  private int compareGObjects(GObject obj1, GObject obj2) {
    return obj1.getZIndex() - obj2.getZIndex();
  }
}

