public class Game {
  ArrayList<Player> players;
  int numPlayers;
  ArrayList<Integer> rolls;
  int[] counts;

  public Game() {
    players = new ArrayList<Player>();
    numPlayers = 0;
    rolls = new ArrayList<Integer>();
    counts = new int[11];
  }

  void addPlayer(Player newPlayer) {
    players.add(newPlayer);
    numPlayers += 1;
  }

  void addRoll(int roll) {
    rolls.add(roll);
    counts[roll-2] += 1;
  }

  int[] getCounts() {
    return counts;
  }
  
  ArrayList<Player> getPlayers(){
    return players;
  }
  
  Player getPlayer(String name){
    for (Player player : players){
      if (player.getName() == name){
        return player;
      }
    }
    return null;
  }

  void printCounts() {
    for (int count : counts) {
      System.out.print(count + ",");
    }
  }
}
