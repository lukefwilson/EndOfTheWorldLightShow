public static final int DEFAULT_LINE_HEIGHT = -1;
public static final int UNSET_SIZE = -1;

public class GLabel extends GObject {
  String text;
  int textAlignX;
  int textAlignY;
  String fontName;
  float fontSize;
  PFont font;
  float lineHeight;

  private boolean fixedHeight;
  private boolean fixedWidth;

  // use this constructor to have a text box with fixed yet mutable height and width
  // call wrapBoundingBox() to start dynamically setting height and width, based on the text 
  GLabel(String initText, float initX, float initY, float initWidth, float initHeight) {
    super(initX, initY, initWidth, initHeight);
    text = initText;
    fixedHeight = true;
    fixedWidth = true;
    setDefaults();
  }

  // use this constructor to have free form text, the height and width are computed
  GLabel(String initText, float initX, float initY) {
    super(initX, initY, UNSET_SIZE, UNSET_SIZE);
    text = initText;
    fixedHeight = false;
    fixedWidth = false;
    setDefaults();
  }

  private void setDefaults() {
    textAlignX = CENTER;
    textAlignY = CENTER;
    lineHeight = DEFAULT_LINE_HEIGHT;
    fontName = "SansSerif";
    fontSize = 16;
    setFont(fontName);
  }

  void display() {
    super.display();
    rectMode(CENTER);
    textAlign(textAlignX, textAlignY);
    textFont(font);
    textSize(fontSize);
    textLeading(getLineHeight());

    if (fixedWidth && fixedHeight) {
      text(text, 0, 0, getWidth(), getHeight());
    } else {
      text(text, 0, 0);
    }    

    resetMatrix();
  }

  String getText() {
    return text;
  }

  void setText(String newText) {
    text = newText;
    updateSize();
  }

  void setFont(String newFontName) {
    fontName = newFontName;
    font = createFont(fontName, 72, true);
    updateSize();
  }

  float getFontSize() {
    return fontSize;
  }

  void setFontSize(float newFontSize) {
    fontSize = newFontSize; 
    updateSize();
  }

  // assumes the current font and size have already been set for generating the line height 
  float getLineHeight() {
    if (lineHeight != DEFAULT_LINE_HEIGHT) return lineHeight;
    return textAscent() + textDescent();
  }

  void setLineHeight(float newLineHeight) {
    lineHeight = newLineHeight;
    updateSize();
  }

  void resetLineHeight() {
    lineHeight = DEFAULT_LINE_HEIGHT;
    updateSize();
  }

  void wrapBoundingBox() {
    fixedWidth = false;
    fixedHeight = false;
    updateSize();
  }

  void setWidth(float newWidth) {
    super.setWidth(newWidth);
    fixedWidth = true;
  }

  void setHeight(float newWidth) {
    super.setHeight(newWidth);
    fixedHeight = true;
  }

  private void updateSize() {
    if (fixedWidth && fixedHeight) return;
    textFont(font);
    textSize(fontSize);
    textLeading(getLineHeight());

    if (!fixedWidth) {
      super.setWidth(textWidth(text));
    }

    if (!fixedHeight) {
      int numLines = text.split("\n", -1).length;
      super.setHeight(numLines * getLineHeight());
    }
  }

  // Not available for now b/c it will affect bounding box
  //  int getTextAlignX() {
  //    return textAlignX;
  //  }
  //
  //  void setTextAlignX(int newTextAlignX) {
  //    textAlignX = newTextAlignX;
  //  }
  //
  //  int getTextAlignY() {
  //    return textAlignY;
  //  }
  //
  //  void setTextAlignY(int newTextAlignY) {
  //    textAlignY = newTextAlignY;
  //  }
}

