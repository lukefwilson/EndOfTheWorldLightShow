public static class GUtils {

  public static float difference(float first, float second) {
    return abs(first - second);
  }

  public static PVector midpoint(float x1, float y1, float x2, float y2) {
    return new PVector(average(x1, x2), average(y1, y2));
  }

  public static float distance(float x1, float y1, float x2, float y2) {
    return sqrt(pow(x2-x1, 2) + pow(y2-y1, 2));
  }

  public static float average(float num1, float num2) {
    return (num1+num2)/2;
  }

  public static boolean objectsAreColliding(GObject obj1, GObject obj2) {
    // Check if one object is on the left side of the other
    if (obj1.getLeft() > obj2.getRight() || obj2.getLeft() > obj1.getRight()) {
      return false;
    }

    // Check is one object is below the other
    if (obj1.getTop() > obj2.getBottom() || obj2.getTop() > obj1.getBottom()) {
      return false;
    } 

    return true;
  }
}

