//
//  Score.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Score extends Codable {

  // MARK: - Instance Variables

  /// Name of the player who posted the score.
  private String _name;

  /// Numerical value of the score.
  private float _value;

  // MARK: - Properties

  /// Name of the player who posted the score.
  public String name() { return _name; }

  /// Sets the name of the player who posted the score.
  public void setName(String name) { _name = name; }

  /// Numerical value of the score.
  public float value() { return _value; }

  /// Sets the numerical value of the score.
  public void setValue(float value) { _value = value; }

  // MARK: - Initialization

  public Score(String name, float value) {
    super();
    setName(name);
    setValue(value);
  }

  public Score(Coder aCoder) {
    super(aCoder);
    setName(aCoder.decodeStringForKey("name"));
    setValue(aCoder.decodeFloatForKey("value"));
  }

  // MARK: - Encoding

  public void encodeWithCoder(Coder aCoder) {
    aCoder.encodeStringForKey(name(), "name");
    aCoder.encodeFloatForKey(value(), "value");
  }
}
