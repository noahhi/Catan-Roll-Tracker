public class Screen {
  boolean active;

  Screen() {
    active = false;
  }

  boolean isActive() {
    return active;
  }

  void activate() {
    active = true;
  }

  void deactivate() {
    active = false;
  }
}
