//
//  BulletNode.pde
//  1984
//
//  Created by David Moore on 4/24/18.
//

public class BulletNode extends SpriteNode {

  // MARK: - Instance Variables

  /// Amount of damage given to the bullet.
  private float _weight;

  /// Boolean value indicating if the bullet is friendly to PlayerNode.
  private boolean _isFriendly;

  // MARK: - Properties

  /// Amount of damage given to the bullet.
  public float weight() { return _weight; }

  /// Sets the amount of damage given to the bullet.
  public void setWeight(float weight) { _weight = weight; }

  /// Boolean value indicating if the bullet is friendly to PlayerNode.
  public boolean isFriendly() { return _isFriendly; }

  /// Sets the boolean value indicating if the bullet is friendly to PlayerNode.
  public void setIsFriendly(boolean isFriendly) { _isFriendly = isFriendly; }

  // MARK: - Initialization

  public BulletNode(float weight, boolean isFriendly) {
    super();
    setWeight(weight);
    
    // Set the 
    if (weight >= 1.0) {
      setTexture(new Texture("Textures/Missile.png"));
    } else if (isFriendly) {
      setTexture(new Texture("Textures/Bullet Bundle.png"));
    } else {
      setTexture(new Texture("Textures/Single Bullet.png"));
    }
    
    // Update the 'isFriendly' boolean.
    setIsFriendly(isFriendly);
  }

  // MARK: - Updating

  public void update(int currentTime) {
    super.update(currentTime);
    
    if (parent() == null)
      return;
      
    // Check for intersection of nodes contained by the parent.
    for (Node node : parent().children()) {
      // Make sure to avoid testing the receiver.
      if (node.isEqualToNode(this))
        continue;
      
      // Check if the node intersects the receiver.
      if (!node.frame().intersectsRect(frame()))
        continue;
      
      // Declare a boolean which determines if the receiver should remove itself from the parent.
      boolean shouldRemoveFromParent = true;

      // Subtract from the health.
      if (isFriendly() && node instanceof FighterNode) {
        FighterNode fighterNode = (FighterNode)node;
        fighterNode.setHealth(fighterNode.health() - weight());
      } else if (!isFriendly() && node instanceof PlayerNode) {
        PlayerNode playerNode = (PlayerNode)node;
        playerNode.setHealth(playerNode.health() - weight() * 100);
      } else { shouldRemoveFromParent = false; }
      
      // Remove the bullet from the scene, if required.
      if (shouldRemoveFromParent) {
        removeFromParent();
      }
    }
  }
}
