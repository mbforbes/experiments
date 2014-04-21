import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ZushkaFiles {

    private static final String filename = "eggs.txt";

    public static void main(String[] args) throws FileNotFoundException, IOException {
	File inFile = new File(filename);
	
	//Construct the new file that will later be renamed to the original filename.
	File tempFile = new File(inFile.getAbsolutePath() + ".tmp");
	
	//Construct the reader for the old file
	BufferedReader br = new BufferedReader(new FileReader(filename));
	//Construct the writer for the new file
	BufferedWriter pw = new BufferedWriter(new FileWriter(tempFile));
	
	String line = null;
	
	//Read from the original file and write it all to the new one
	while ((line = br.readLine()) != null) {
	    pw.write(line);
	    pw.newLine();
	}
	
	//Write to the new file the tuple we want to insert
	pw.write("New stuff to file!\n");
	
	pw.close();
	br.close();
	
	//Delete original file
	inFile.delete();
	//Rename new file as the old one
	tempFile.renameTo(inFile);
	
    }
}
