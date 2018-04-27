//
//  Texture.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Texture {

	// MARK: - Instance Variables

	/// Stored image for the texture.
	private PImage _image;

	// MARK: - Properties

	/// Stored image for the texture.
	public PImage image() { return _image; }

	/// Sets the stored image for the texture.
	public void setImage(PImage image) { _image = image; }

	/// Sets the stored image for the receiver using a name for the image.
	public void setImageNamed(String name) {
		// Call the real method.
		setImageNamedWithExtension(name, null);
	}

	/// Sets the image stored for the receiver using a name and extension for the image.
	public void setImageNamedWithExtension(String name, String extension) {
		// Set the image using the loadImage method from processing.
		setImage(loadImage(name, extension));
	}

	// MARK: - Initialization

	public Texture(PImage image) {
		setImage(image);
	}

	public Texture(String name) {
		setImageNamed(name);
	}

	public Texture(String name, String extension) {
		setImageNamedWithExtension(name, extension);
	}
}
