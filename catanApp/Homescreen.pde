public class Homescreen extends Screen {
  PImage catanBoard;
  Button newGameButton;
  Button continueButton;

  Homescreen() {
    catanBoard = loadImage("backgroundIMG2.jpg");
    newGameButton = new Button(width/2, height/3, 180, 70, "New Game");
    continueButton = new Button(width/2, (height/4)*2, 180, 70, "Continue");
  }

  void show() {
    if (!active) {
      System.out.println("trying to show homescreen but not active");
    }
    image(catanBoard, 0, 0, width, height);
    newGameButton.display();
    continueButton.display();
  }

  Button getNewGameButton() {
    return newGameButton;
  }
  
  Button getContinueGameButton() {
    return continueButton;
  }
}
