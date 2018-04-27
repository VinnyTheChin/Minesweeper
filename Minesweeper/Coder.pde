//
//  Coder.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Coder {

	// MARK: - Instance Variables

	private JSONObject values;

	// MARK: - Properties

	// MARK: - Initialization

	public Coder() {
		values = new JSONObject();
	}

	public Coder(String fileName) {
		this(loadJSONObject(fileName));
	}

	public Coder(JSONObject values) {
		this.values = values;
	}

	// MARK: - Save Output

	public void writeToFilePath(String filePath) {
		saveJSONObject(values, filePath);
	}

	// MARK: - Encoding

	private <T extends Codable> Coder encodeObject(T object) {
		// Create a new Coder.
		Coder aCoder = new Coder();

		// Encode the object in a dictionary
		object.encodeWithCoder(aCoder);

		return aCoder;
	}

	public <T extends Codable> void encodeObjectForKey(T object, String key) {
		// Encode the object with a new Coder.
		Coder aCoder = encodeObject(object);

		// Add the JSON values to the receiver's values object.
		values.setJSONObject(key, aCoder.values);
	}

	public void encodeStringForKey(String value, String key) {
		values.setString(key, value);
	}

	public void encodeIntForKey(int value, String key) {
		values.setInt(key, value);
	}

	public void encodeFloatForKey(float value, String key) {
		values.setFloat(key, value);
	}

	public void encodeBoolForKey(boolean value, String key) {
		values.setBoolean(key, value);
	}

	public <T extends Codable> void encodeArrayForKey(List<T> objects, String key) {
		JSONArray array = new JSONArray();

		for (int i = 0; i < objects.size(); i++) {
			T object = (T)objects.get(i);
			Coder aCoder = encodeObject(object);
			array.setJSONObject(i, aCoder.values);
		}

		values.setJSONArray(key, array);
	}

	// MARK: - Decoding

	public <T extends Codable> T decodeObjectForKey(String key) {
		// Create a new Coder for values contained within the values object.
		Coder aCoder = new Coder(values.getJSONObject(key));

		return (T)(new Score(aCoder));
	}

	public String decodeStringForKey(String key) {
		return values.getString(key);
	}

	public int decodeIntForKey(String key) {
		return values.getInt(key);
	}

	public float decodeFloatForKey(String key) {
		return values.getFloat(key);
	}

	public boolean decodeBoolForKey(String key) {
		return values.getBoolean(key);
	}

	public <T extends Codable> ArrayList<T> decodeArrayForKey(String key) {
		JSONArray jsonArray = values.getJSONArray(key);
		ArrayList<T> objects = new ArrayList<T>();

		for (int i = 0; i < jsonArray.size(); i++) {
			Coder aCoder = new Coder(jsonArray.getJSONObject(i));
			T object = (T)new Score(aCoder);
			objects.add(object);
		}

		return objects;
	}
}
