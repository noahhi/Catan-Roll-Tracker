import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Button {
  int x;
  int y;
  int buttonWidth;
  int buttonHeight;
  String prompt;
  int scale;
  color col;
  boolean hasImage;
  PImage image;
  boolean outline;

  Button(int x, int y, int buttonWidth, int buttonHeight, String prompt) {
    if (PHONE) {
      scale = 3; //set to 3 for phone
    } else {
      scale = 1;
    }
    this.x = x;
    this.y = y;
    this.buttonWidth = buttonWidth*scale;
    this.buttonHeight = buttonHeight*scale;
    this.prompt = prompt;
    col = color(0, 0, 0);
    hasImage = false;
    outline = false;
    image = null;
  }

  Button(int x, int y, int buttonWidth, int buttonHeight, String prompt, boolean scaled) {
    scale = 1;
    if (scaled) {
      scale = scale * 3;
    }
    this.x = x;
    this.y = y;
    this.buttonWidth = buttonWidth*scale;
    this.buttonHeight = buttonHeight*scale;
    this.prompt = prompt;
  }

  void display() {
    rectMode(CENTER);
    if (outline) {
      strokeWeight(3);
    }
    fill(col);
    rect(x, y, buttonWidth, buttonHeight);
    fill(200, 0, 0);
    if (!hasImage) {
      text(prompt, x, y);
    }
    fill(col);
    stroke(200, 40, 60);
    if (hasImage) {
      imageMode(CENTER);
      image(image, x, y, buttonWidth, buttonHeight);
      imageMode(CORNER);
      if (outline) {
        fill(col, 70);
        rect(x, y, buttonWidth, buttonHeight);
        fill(col);
      }
    }
    strokeWeight(1);
  }

  void highlight() {
    if (hasImage) {
      outline = true;
    } else {
      col = color(80);
    }
  }

  void unhighlight() {
    if (hasImage) {
      outline = false;
    } else {
      col = color(0);
    }
  }

  void updatePrompt(String newPrompt) {
    prompt = newPrompt;
  }

  void addImage(PImage img) {
    image = img;
    this.hasImage = true;
  }

  String getPrompt() {
    return prompt;
  }

  int getVal() {
    Pattern p = Pattern.compile("([0-9]+):");
    Matcher m = p.matcher(prompt);
    String val = "-1";
    if (m.find()) {
      val = m.group(1);
    } else {
      System.out.print("No Match");
    }
    return Integer.parseInt(val);
  }

  boolean mouseOver() {
    if (mouseX >= x-(buttonWidth/2) && mouseX <= x+(buttonWidth/2) && 
      mouseY >= y-(buttonHeight/2) && mouseY <= y+(buttonHeight/2)) {
      return true;
    } else {
      return false;
    }
  }
}
