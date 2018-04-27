//
//  MinesweeperScene.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class MinesweeperScene extends Scene {

  /// The node the human player controls.
  private PlayerNode _player;

  /// Map tile node that moves infinitely.
  private SpriteNode _mapTile;

  /// Current weight value of the scene; serves as a deterministic value.
  private float _currentWeight;

  /// Current level of gameplay; related to difficulty.
  private int _currentLevel;

  /// Game score.
  private float _score;

  /// Time of the last creation (i.e., FighterNode).
  private int lastCreationTime;

  // MARK: - Properties

  /// The node the human player controls.
  private void setPlayer(PlayerNode player) {
    _player = player;
  }

  /// Returns the node the human player controls.
  public PlayerNode player() {
    return _player;
  }

  /// Sets the map tile node that moves infinitely.
  private void setMapTile(SpriteNode mapTile) { _mapTile = mapTile; }

  /// SMap tile node that moves infinitely, or at least appears to.
  public SpriteNode mapTile() { return _mapTile; }

  /// Sets the current weight value of the scene; serves as a deterministic value.
  public void setCurrentWeight(float weight) { _currentWeight = weight; }

  /// Current weight value of the scene; serves as a deterministic value.
  public float currentWeight() { return _currentWeight; }

  /// Sets the current level of gameplay; related to difficulty.
  private void setCurrentLevel(int currentLevel) { _currentLevel = currentLevel; }

  /// Current level of gameplay; related to difficulty.
  public int currentLevel() { return _currentLevel; }

  /// The game score.
  public float score() { return _score; }

  /// Sets the game score.
  public void setScore(float score) { _score = score; }

  // MARK: - Initialization

  public MainScene(Rect frame) {
    super(frame);
  }

  // MARK: - Lifecycle

  /// Called immediately after the scene has been initialized.
  public void sceneDidLoad() {
    super.sceneDidLoad();

    // Set the current level for init-purposes.s
    setCurrentLevel(1);

    // Start with a very small weight.
    setCurrentWeight(0.1);

    // Have the map tile be configured.
    configureMapTile();

    // Create a new player and set its position.
    setPlayer(new PlayerNode(new Point(0, 0)));
    player().setPosition(new Point(frame().width() / 2 - player().frame().width() / 2, frame().height() - player().frame().height() - 8));

    // Add the player to the scene.
    addChild(player());
  }

  /// Configures the map tile.
  private void configureMapTile() {
    // Only continue if the map tile hasn't been configured yet.
    if (mapTile() == null) {
      // Create the map node, if needed.
      setMapTile(new SpriteNode(new Texture("Textures/Map Tile - Seamless.png")));

      // Add the map tile to the scene.
      addChild(mapTile());
    }

    Action movementAction = ActionMoveByVectorWithDuration(new Vector(0, mapTile().frame().height() - frame().height()), 1000 * 100);

    // Create a new delegate that will reset the map when the action is complete.
    movementAction.setDelegate(new ActionDelegate() {
      public void actionDidFinishWithNode(Action action, Node node) {
        configureMapTile();
      }
    });

    // Re-set the position.
    mapTile().position().y = frame().height() - mapTile().frame().height();

    // Start the movement action.
    mapTile().runAction(movementAction);
  }

  private void createFighterNode() {
    // Don't attempt to create a new fighter if we have almost no weight remaining.
    if (currentWeight() <= 0)
      return;

    // Attempt to create a new fighter.
    FighterNode fighter = FighterNodeCreateForLimitingWeight(currentWeight());

    // Check if a fighter was not created.
    if (fighter == null)
      return;

    // Update the current weight.
    setCurrentWeight(currentWeight() - fighter.weight());

    fighter.setPosition(new Point(100, 100));

    addChild(fighter);
  }

  /// Performs any scene-specific updates that need to occur before scene actions are evaluated.
  ///
  /// - Parameter currentTime: The time since starting the program in milliseconds.
  public void update(int currentTime) {
    super.update(currentTime);

    // Create fighter nodes whenever the current time is divisible by 50, perfectly. This provides a non-constant timing function.
    if (currentTime - lastCreationTime >= 100 * random(10)) {
      createFighterNode();

      lastCreationTime = currentTime;
    }
  }

  // MARK: - User Interaction

  /// Informs the receiver that the user has pressed a key.
  public void keyDownWithEvent(KeyEvent event) {
    super.keyDownWithEvent(event);

    // Pass the call on to the player.
    player().keyDownWithEvent(event);
  }

  /// Informs the receiver that the user has released a key.
  public void keyUpWithEvent(KeyEvent event) {
    super.keyUpWithEvent(event);

    // Pass the call on to the player.
    player().keyUpWithEvent(event);
  }
}
