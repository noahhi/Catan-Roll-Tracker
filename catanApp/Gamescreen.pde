public class Gamescreen extends Screen {
  Button homeButton;
  Button rollButton;
  Button addPlayerButton;
  Button addSettlementButton;
  Button statsButton;
  Button playerInfoButton;
  Button moveRobberButton;
  
  PImage catanBoard;
  
  Gamescreen() {
    homeButton = new Button(width-(width/8), height/13, 90, 60, "Home");
    rollButton = new Button(width/2, height/2, 200, 60, "Roll the Dice");
    statsButton = new Button(width/2, height/8, 180, 60, "View Stats");
    addPlayerButton = new Button(width/2, height/4, 200, 60, "Add Player");
    addSettlementButton = new Button(width/2, height/3, 240, 60, "Add Settlement");
    playerInfoButton = new Button(width/2, (height/10)*9, 200, 60, "Player Info");
    moveRobberButton = new Button(width/2, (height/8)*6, 200, 60, "Move Robber");
    catanBoard = loadImage("backgroundIMG2.jpg");
  }

  void show() {
    if (!active) {
      System.out.println("trying to show gamescreen but not active");
    }
    image(catanBoard, 0, 0, width, height);
    rollButton.display();
    addPlayerButton.display();
    homeButton.display();
    addSettlementButton.display();
    statsButton.display();
    playerInfoButton.display();
    moveRobberButton.display();
  }
  
  void displayPlayers(Game game){
    for (Player player : game.getPlayers()){
      System.out.println(player.getName());
    }
  }

  Button getHomeButton() {
    return homeButton;
  }
  
  Button getRollButton() {
    return rollButton;
  }
  
  Button getAddPlayerButton(){
    return addPlayerButton;
  }
  
  Button getSettlementButton(){
    return addSettlementButton;
  }
  
  Button getStatsButton(){
    return statsButton;
  }
  
  Button playerInfoButton(){
    return playerInfoButton;
  }
  
  Button getMoveRobberButton(){
    return moveRobberButton;
  }
}
