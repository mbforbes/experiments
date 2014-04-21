import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.Iterator;

import com.badlogic.gdx.utils.Array;
import com.esotericsoftware.kryo.Kryo;
import com.esotericsoftware.kryo.Serializer;
import com.esotericsoftware.kryo.io.Input;
import com.esotericsoftware.kryo.io.Output;
import com.esotericsoftware.kryo.serializers.FieldSerializer;
	
public class KryoTest {
		public static class Container {
			public Array<TestObject> testObjects = new Array<TestObject>();
		}
		public static class TestObject {
			public NoNoargsConstructor noNoargsConstructor;
		}
		public static class NoNoargsConstructor {
			public NoNoargsConstructor(float f){}
		}
		
		public static class ContainerSerializer extends Serializer<Container> {
			@Override
			public void write(Kryo kryo, Output output, Container c) {
				// write length
				output.writeInt(c.testObjects.size);
				
				// write objects
				Serializer<TestObject> testObjSer = (Serializer<TestObject>) kryo.getSerializer(TestObject.class);
				Iterator<TestObject> it = c.testObjects.iterator();
				while (it.hasNext()) {
					testObjSer.write(kryo, output, it.next());
				}
			}
			
			@Override
			public Container read(Kryo kryo, Input input, Class<Container> type) {
				// read length
				int len = input.readInt();
				Array<TestObject> ret = new Array<TestObject>(true, len, TestObject.class);
				Serializer<TestObject> testObjSer = (Serializer<TestObject>) kryo.getSerializer(TestObject.class);
				for (int i = 0; i < len; i++) {
					ret.add(testObjSer.read(kryo, input, TestObject.class));
				}
				Container c = new Container();
				c.testObjects = ret;
				return c;
			}
		}
		
		/**
		 * Minimal demonstration that removeField(...) doens't work with Array.
		 */
		public static void main(String[] args) {
			// Create objects to serialize
			TestObject obj = new TestObject();
			obj.noNoargsConstructor = new NoNoargsConstructor(5.0f);
			Container c = new Container();
			c.testObjects.add(obj);
			
			// Remove field for serialization
			Kryo kryo = new Kryo();
			FieldSerializer<TestObject> ser = new FieldSerializer<TestObject>(kryo, TestObject.class);
			ser.removeField("noNoargsConstructor");		
			kryo.register(TestObject.class, ser);
			kryo.register(Container.class, new ContainerSerializer());
			
			// Serialize to file
			String filename = "test.file";
			Output output;
			try {
				output = new Output(new FileOutputStream(filename));
				kryo.writeObject(output, c);
				output.close();				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			
			// De-serialize from file
			Input input;
			try {
				input = new Input(new FileInputStream(filename));
				Container c2 = kryo.readObject(input, Container.class);
				input.close();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}				
		
			// If we made it here, ohmygosh.
			System.out.println("Success!");			
		}
}
