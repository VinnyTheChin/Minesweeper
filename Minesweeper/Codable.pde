//
//  Codable.pde
//  1984
//
//  Created by David Moore on 4/25/18.
//

public abstract class Codable {
  
  /// Explicit super constructor.
  public Codable() {}
  
  /// Called with a Coder that may be used to decode state and receiver information.
  public Codable(Coder aCoder) {}
  
  /// Called with a Coder that may be used to encode state and receiver information.
  public void encodeWithCoder(Coder aCoder) {}
}
