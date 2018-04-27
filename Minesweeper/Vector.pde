//
//  Vector.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Vector {

	// MARK: - Properties

	/// The x component of the vector.
	public float dx;
	
	/// The y component of the vector.
	public float dy;

	// MARK: - Initialization

	/// Creates a new vector with an x and y component.
	public Vector(float dx, float dy) {
		this.dx = dx;
		this.dy = dy;
	}
}
