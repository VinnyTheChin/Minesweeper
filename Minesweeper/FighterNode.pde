//
//  FighterNode.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

import java.util.Arrays;

public enum FighterType {
  FighterTypeEasy,
  FighterTypeMedium,
  FighterTypeHard,
  FighterTypeExtremelyHard
}

/// Collection of fighter type weight values (sorted).
public static float[] FighterTypeWeightValues = {0.01, 0.1, 0.4, 0.8};

public class FighterNode extends SpriteNode {

  // MARK: - Instance Variables

  /// The type of fighter node the receiver represents.
  private FighterType _type;

  /// Weight of the fighter node. This is used as a pooling value for deterministic purposes.
  private float _weight;

  /// Boolean value indicating if the receiver has yet to be configured in terms of movement.
  private boolean isConfigured;

  /// Health value of the receiver for gameplay purposes.
  private float _health;

  // MARK: - Properties

  /// Weight of the fighter node. This is used as a pooling value for deterministic purposes.
  public float weight() { return _weight; }

  /// Sets the weight of the fighter node. This is used as a pooling value for deterministic purposes.
  private void setWeight(float weight) {
    _weight = weight;
    setHealth(weight * 2);
  }

  /// The type of fighter node the receiver represents.
  public FighterType type() {
    return _type;
  }

  /// Sets the type of fighter node the receiver represents.
  public void setType(FighterType type) {
    // Update the type.
    _type = type;

    // Declare the texture name.
    String textureName = null;

    // Declare a weight value.
    float weightValue = FighterTypeWeightValues[type.ordinal()];

    // Switch on the fighter type to determine the texture and weight.
    switch (type) {
    case FighterTypeEasy:
      textureName = "Textures/Fighter Easy.png";
      break;
    case FighterTypeMedium:
      textureName = "Textures/Fighter Medium.png";
      break;
    case FighterTypeHard:
      textureName = "Textures/Fighter Hard.png";
      break;
    case FighterTypeExtremelyHard:
      textureName = "Textures/Fighter Extremely Hard.png";
      break;
    default:
      break;
    }

    // Update the texture.
    if (textureName != null) {
      setTexture(new Texture(textureName));
    } else {
      setTexture(null);
    }

    // Update the weight value.
    setWeight(weightValue);
  }

  /// Health value of the receiver for gameplay purposes.
  public float health() { return _health; }

  /// Sets the health value of the receiver for gameplay purposes.
  public void setHealth(float health) {
    _health = health;

    // Check if the fighter has been killed.
    if (health <= 0) {
      // Increment the scene's weight pool.
      if (parent() != null) {
        MainScene scene = (MainScene)parent();
        scene.setCurrentWeight(scene.currentWeight() + weight() * (1.3 + scene.currentLevel() - 1));

        // Update the score.
        scene.setScore(scene.score() + weight() * 1000);

        // Increase the level, if it was the big fighter.
        if (type() == FighterType.FighterTypeExtremelyHard) {
          scene.setCurrentLevel(scene.currentLevel() + 1);

          // Lower the weight to make the game a little bit easier.
          scene.setCurrentWeight(0.2);
        }
      }

      removeFromParent();
    }
  }

  // MARK: - Initialization

  public FighterNode(FighterType type) {
    super();
    setType(type);
  }

  public FighterNode() {
    // Retrieve a random integer.
    int typeIndex = (int)(random(0, 3) + 0.5);

    // Get the random fighter type using the previously determined index.
    FighterType randomType = FighterType.values()[typeIndex];

    // Set the type.
    setType(randomType);
  }

  // MARK: - Lifecycle

  /// Attempts to shoot a bullet directed towards the PlayerNode in the parent scene.
  public void shootBullet() {
    if (scene() == null)
      return;

    // Cast the scene as MainScene.
    MainScene scene = (MainScene)scene();

    // Retrieve the player from the parent scene.
    PlayerNode player = scene.player();

    // Ensure the player exists.
    if (player == null)
      return;

    BulletNode bullet = new BulletNode(weight(), false);
    bullet.frame().origin = new Point(frame().x() + frame().width() / 2 - bullet.frame().width() / 2, frame().y() + frame().height() / 2 - bullet.frame().height() / 2);
    bullet.setIsFriendly(false);
    parent().addChild(bullet);

    // Create the diff movement vector.
    Vector diff = new Vector(player.frame().x() - frame().x(), player.frame().y() - frame().y());

    // Calculate the length of the vector.
    float diffDistance = sqrt(diff.dx * diff.dx + diff.dy * diff.dy);

    float scalar = 1200 / diffDistance;

    diff.dx *= scalar;
    diff.dy *= scalar;

    // Create an action that moves the bullet towards the player, until its off screen.
    Action shootAction = ActionMoveByVectorWithDuration(diff, (int)(10 * 1200 + 0.5));

    // Create a new delegate that will remove the bullet when the action is complete.
    shootAction.setDelegate(new ActionDelegate() {
      public void actionDidFinishWithNode(Action action, Node node) {
        // Remove the node from its parent, thus releasing it from memory.
        node.removeFromParent();
      }
    });

    // Start the action.
    bullet.runAction(shootAction);
  }

  /// Configures the movement of the receiver.
  public void configureMovement() {
    ArrayList<Vector> vectors = new ArrayList<Vector>();

    switch (type()) {
    case FighterTypeEasy:
      for (int i = 0; i < 10000; i++) {
        vectors.add(new Vector(random(-10, 10), random(0, 10)));
      }

      setPosition(new Point(random(100, parent().frame().width() - 100), -50));
      break;
    case FighterTypeMedium:
      for (int i = 0; i < 1000; i++) {
        vectors.add(new Vector(random(-50, 50), random(0, 100)));
      }

      setPosition(new Point(random(100, parent().frame().width() - 100), -100));
      break;
    case FighterTypeHard:
    case FighterTypeExtremelyHard:
      for (int i = 0; i < 5000; i++) {
        vectors.add(new Vector(0, -10));
      }

      if (type() == FighterType.FighterTypeHard) {
        setPosition(new Point(random(parent().frame().width() / 2 - frame().width() / 2, parent().frame().width() / 2 + frame().width() / 2), parent().frame().height() + frame().height()));
      } else {
        setPosition(new Point(parent().frame().width() / 2 - frame().width() / 2, parent().frame().height() + frame().height()));
      }

      break;
    default:
      break;
    }

    Action[] actions = new Action[vectors.size()];

    for (int i = 0; i < vectors.size(); i++) {
      actions[i] = ActionMoveByVectorWithDuration(vectors.get(i), 500);
    }

    Action movementAction = ActionWithActions(Arrays.asList(actions));

    // Have the node be removed after completing the action.
    movementAction.setDelegate(new ActionDelegate() {
        public void actionDidFinishWithNode(Action action, Node node) {
          // Remove the node from its parent, thus releasing it from memory.
          node.removeFromParent();
        }
     });

    runAction(movementAction);
  }

  /// Performs any scene-specific updates that need to occur before scene actions are evaluated.
  ///
  /// - Parameter currentTime: The time since starting the program in milliseconds.
  public void update(int currentTime) {
    super.update(currentTime);

    // Configure the receiver, if not already done.
    if (!isConfigured && parent() != null) {
      // Call the configuration method.
      configureMovement();

      // Update the configuration boolean.
      isConfigured = true;
    }

    // Shoot the bullet at non-uniform intervals.
    if (random(1000) < (2 + weight())) {
      shootBullet();
    }
  }
}

/// Returns a freshly allocated FighterNode given the limitting weight.
///
/// - Note: This method can and will return NULL.
public FighterNode FighterNodeCreateForLimitingWeight(float limitingWeight) {
  // Retrieve a random integer.
  int index = (int)(random(0, 3) + 0.5);

  // Pick the random weight.
  float aWeight = FighterTypeWeightValues[index];

  // Check if the weight fits within the limit.
  if (limitingWeight - aWeight > 0) {
    return new FighterNode(FighterType.values()[index]);
  } else {
    return null;
  }
}
