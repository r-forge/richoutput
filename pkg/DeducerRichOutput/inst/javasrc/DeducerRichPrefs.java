package RichOutput;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.prefs.BackingStoreException;
import java.util.prefs.InvalidPreferencesFormatException;
import java.util.prefs.Preferences;
import org.rosuda.JGR.util.ErrorMsg;

public class DeducerRichPrefs {

    public static String bodyFontFamily;
    public static String bodyFontColor;
    public static String bodyFontSize;
    public static String tableBorderThickness;
    public static String THfontStyle;
    public static String THfontWeight;
    public static String THtextAlign;
    public static String THbackgroundColor;
    public static String TDtextAlign;
    public static String alternatingRowColor;

    private static boolean started = false;
    
    public static void initialize() {
		if(!started){
		bodyFontFamily = "Arial";
		bodyFontColor = "black";
                bodyFontSize = "9";
                tableBorderThickness = "0";
                THfontStyle = "italic";
                THfontWeight = "normal";
                THtextAlign = "center";
                THbackgroundColor = "#e8e8e8";
                TDtextAlign = "right";
                alternatingRowColor = "#dbe8ff";
                readPrefs();
		started = true;
		}
	}

    public static void readPrefs() {
        InputStream is = null;
        try {
                is = new BufferedInputStream(new FileInputStream(System
                                .getProperty("user.home")
                                + File.separator + ".DeducerRichPrefs"));
        } catch (FileNotFoundException e) {
        }
        try {
                if (is != null) {
                        Preferences prefs = Preferences
                                        .userNodeForPackage(RichOutput.OutputController.class);
                        try {
                                prefs.clear();
                        } catch (Exception x) {
                                new ErrorMsg(x);
                        }
                        prefs = null;
                        Preferences.importPreferences(is);
                }
        } catch (InvalidPreferencesFormatException e) {
        } catch (IOException e) {
        }

        if (is == null){
                return;
        }
        Preferences prefs = Preferences.userNodeForPackage(RichOutput.OutputController.class);
        bodyFontFamily = prefs.get("bodyFontFamily", "Arial");
        bodyFontColor = prefs.get("bodyFontColor", "black");
        bodyFontSize = prefs.get("bodyFontSize", "9");
        tableBorderThickness = prefs.get("tableBorderThickness", "1");
        THfontStyle = prefs.get("THfontStyle", "italic");
        THfontWeight = prefs.get("THfontWeight", "normal");
        THtextAlign = prefs.get("THtextAlign", "center");
        THbackgroundColor = prefs.get("THbackgroundColor", "#e8e8e8");
        TDtextAlign = prefs.get("TDtextAlign", "right");
        alternatingRowColor = prefs.get("alternatingRowColor", "#dbe8ff");
    }
	

    public static void writePrefs() {
        Preferences prefs = Preferences
                        .userNodeForPackage(RichOutput.OutputController.class);
        try {
                prefs.clear();
        } catch (Exception x) {
        }
        prefs.put("bodyFontFamily", bodyFontFamily);
        prefs.put("bodyFontColor", bodyFontColor);
        prefs.put("bodyFontSize", bodyFontSize);
        prefs.put("tableBorderThickness", tableBorderThickness);
        prefs.put("THfontStyle", THfontStyle);
        prefs.put("THfontWeight", THfontWeight);
        prefs.put("THtextAlign", THtextAlign);
        prefs.put("THbackgroundColor", THbackgroundColor);
        prefs.put("TDtextAlign", TDtextAlign);
        prefs.put("alternatingRowColor", alternatingRowColor);
        try {
                prefs.exportNode(new FileOutputStream(System
                                .getProperty("user.home")
                                + File.separator + ".DeducerRichPrefs"));
        } catch (IOException e) {
        } catch (BackingStoreException e) {
        }
    }
}