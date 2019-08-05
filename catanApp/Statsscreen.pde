class Statsscreen extends Screen {

  Button homeButton;

  Statsscreen() {
    homeButton = new Button(width-(width/8), height/13, 90, 60, "Back");
  }

  void show(Game game) {
    homeButton.display();
    ArrayList<Player> players = game.getPlayers();
    for (int i = 0; i<players.size(); i++) {
      Player player = players.get(i);
      float expected = player.getExpectedTotal();
      int actual = player.getActualTotal();
      int robbed = player.getTotalRobbed();
      text("Player : " + player.getName(), width/2, (height/5)*(i+1));
      text("Expected : " + expected, width/2, ((height/5)*(i+1))+(height/20));
      text("Actual : " + actual, width/2, ((height/5)*(i+1))+((height/20)*2));
      text("Robbed : " + robbed, width/2, ((height/5)*(i+1))+((height/20)*3));
    }
  }

  Button getHomeButton() {
    return homeButton;
  }
}
