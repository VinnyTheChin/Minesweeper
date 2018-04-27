//
//  SpriteNode.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class SpriteNode extends Node {

	// MARK: - Instance Variables

	/// The sprite’s color.
	private color _backgroundColor;

	/// The texture used to draw the sprite.
	private Texture _texture;

	/// Corner radius of the receiver.
	private float _cornerRadius;

	// MARK: - Properties

	/// The sprite’s color.
	public color backgroundColor() { return _backgroundColor; }

	/// Sets the sprite’s color.
	public void setBackgroundColor(color backgroundColor) { _backgroundColor = backgroundColor; }

	/// The texture used to draw the sprite.
	public Texture texture() { return _texture; }

	/// The texture used to draw the sprite.
	public void setTexture(Texture texture) {
		_texture = texture;

		if (texture != null) {
			frame().size.width = texture.image().width;
			frame().size.height = texture.image().height;
		}
	}

	/// Corner radius of the receiver.
	public float cornerRadius() { return _cornerRadius; }

	/// Sets the corner radius of the receiver.
	public void setCornerRadius(float cornerRadius) { _cornerRadius = cornerRadius; }

	// MARK: - Initialization

	private SpriteNode() {
		super();
		setBackgroundColor(color(0, 0, 0, 0));
		setCornerRadius(0.0);
	}

	public SpriteNode(Rect frame, color backgroundColor) {
		this();
		setFrame(frame);
		setBackgroundColor(backgroundColor);
	}

	public SpriteNode(Texture texture) {
		this();
		setTexture(texture);
	}

	// MARK: - Drawing

	public void draw(int currentTime) {
		super.draw(currentTime);

		// Configure the color.
		noStroke();
		fill(backgroundColor());

		// Draw the rectangle.
		rect(frame().x(), frame().y(), frame().width(), frame().height(), cornerRadius(), cornerRadius(), cornerRadius(), cornerRadius());

		// Make sure the texture is non-nil.
		if (texture() != null) {
			// Draw the texture image.
			image(this.texture().image(), frame().x(), frame().y(), frame().width(), frame().height());
		}
	}
}
