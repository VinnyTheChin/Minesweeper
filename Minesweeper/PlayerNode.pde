//
//  PlayerNode.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public static final String kPlayerHorizontalMoveAction = "PlayerHorizontalMoveActionKey";
public static final String kPlayerVerticalMoveAction = "PlayerVerticalMoveActionKey";

public class PlayerNode extends SpriteNode {

  // MARK: - Instance Variables

  /// Health value of the receiver for gameplay purposes.
  private float _health;

	// MARK: - Properties

  /// Health value of the receiver for gameplay purposes.
  public float health() { return _health; }

  /// Sets the health value of the receiver for gameplay purposes.
  public void setHealth(float health) { _health = health; }

	// MARK: - Initialization

	public PlayerNode(Point origin) {
    super(new Texture("Textures/Player.png"));
    setPosition(origin);
    setHealth(100);
	}

  // MARK: - Lifecycle

  /// Performs any node-specific updates that need to occur before actions are evaluated.
  ///
  /// - Parameter currentTime: The time since starting the program in milliseconds.
  public void update(int currentTime) {
    super.update(currentTime);

    // Check if the player is trying to move off the screen.
    if (frame().y() >= parent().frame().height() || frame().y() <= 0) {
      removeActionForKey(kPlayerHorizontalMoveAction);
    }

    // Check if the player is trying to move off the screen.
    if (frame().x() >= parent().frame().width() || frame().x() <= 0) {
      removeActionForKey(kPlayerVerticalMoveAction);
    }
  }

	// MARK: - User Interaction

  /// Informs the receiver that the user has pressed a key.
  public void keyDownWithEvent(KeyEvent event) {
    super.keyDownWithEvent(event);

    // Switch on the event character, to look for the spacebar.
    switch (event.character()) {
    case ' ':
      // Create a new bullet and update its origin to be just above the ship.
      BulletNode bullet = new BulletNode(0.3, true);
      bullet.frame().origin = new Point(frame().x() + frame().width() / 2 - bullet.frame().width() / 2, frame().y() - bullet.frame().height() - 1);
      bullet.setIsFriendly(true);
      parent().addChild(bullet);

      // Create an action that moves the bullet upwards, forever.
      Action shootAction = ActionMoveByVectorWithDuration(new Vector(0, -parent().frame().height()), 1500);

      // Create a new delegate that will remove the bullet when the action is complete.
      shootAction.setDelegate(new ActionDelegate() {
        public void actionDidFinishWithNode(Action action, Node node) {
          // Remove the node from its parent, thus releasing it from memory.
          node.removeFromParent();
        }
      });

      // Start the action.
      bullet.runAction(shootAction);
      break;
    default:
      break;
    }

    // Switch on the event key code.
    switch (event.code()) {
    case LEFT:
    case RIGHT:
      // Create a move action that is dependent on the left or right key (- or + respectively).
      Action horizontalMoveAction = ActionMoveByVectorWithDuration(new Vector(event.code() == LEFT ? -1 : 1, 0), -3);
      runActionWithKey(horizontalMoveAction, kPlayerHorizontalMoveAction);
      break;
    case UP:
    case DOWN:
      // Create a move action that is dependent on the up or down key (- or + respectively).
      Action verticalMoveAction = ActionMoveByVectorWithDuration(new Vector(0, event.code() == UP ? -1 : 1), -3);
      runActionWithKey(verticalMoveAction, kPlayerVerticalMoveAction);
      break;
    default:
      break;
    }
  }

  /// Informs the receiver that the user has released a key.
  public void keyUpWithEvent(KeyEvent event) {
    super.keyUpWithEvent(event);

    // Remove the action if the codes are appropriate.
    if (event.code() == LEFT || event.code() == RIGHT) {
      removeActionForKey(kPlayerHorizontalMoveAction);
    } else if (event.code() == UP || event.code() == DOWN) {
      removeActionForKey(kPlayerVerticalMoveAction);
    }
  }
}
