package RichOutput;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.text.BadLocationException;
import javax.swing.text.html.HTMLDocument;
import javax.swing.text.html.HTMLEditorKit;

import org.rosuda.JGR.JGR;
import org.rosuda.JGR.util.ErrorMsg;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngine;
import org.rosuda.REngine.REngineException;
import org.rosuda.deducer.RConnector;
import org.w3c.dom.Document;


/**
 * Provides hooks for deducer to use.
 *
 */
public class RichOutputConnector implements RConnector{

	REngine engine = JGR.getREngine();
        private int ElementCount = 0;
	public void execute(String cmd) {
		execute(cmd,true);
	}

	public void execute(String cmd, boolean addToHist) {
		execute(cmd,addToHist,cmd.length()>40 ? cmd.substring(0, 38) : cmd,null);
	}
	
	/**
	 * No dialogs use this function directly yet as xml models have not been implemented.
	 */
	public void execute(String cmd,boolean addToHist,String title,Document xmlDialogState){
		OutputElement el = new OutputElement();
                el.setTitle(title);
		el.setRcall(cmd);
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();
		el.setDate(dateFormat.format(date));
		el.setXML(xmlDialogState);
                ElementCount++;
                NumberFormat nf = new DecimalFormat("00000");
                String formattedElementCount=(nf.format(ElementCount));
                String ElementID = "OutputElement" + formattedElementCount;
		el.setId(ElementID);
                String code =  "<a id=\"" + ElementID + "\" name=\"" + ElementID + "\"></a>";
                el.setOutput(code);
		HTMLDocument doc = (HTMLDocument) OutputController.console.outputDoc;
                HTMLEditorKit ed = (HTMLEditorKit) OutputController.output.getEditorKit();
                try {
                    ed.insertHTML(doc, doc.getLength(), code, 0, 0, null);
                } catch (BadLocationException ex) {
                } catch (IOException ex) {
                    }
                OutputController.record.add(el);
		JGR.MAINRCONSOLE.execute(cmd,addToHist);
	}

	public REXP eval(String cmd) {
		try {
			return engine.parseAndEval(cmd);
		} catch (REngineException e) {
			new ErrorMsg(e);
			return null;
		} catch (REXPMismatchException e) {
			new ErrorMsg(e);
			return null;
		}
	}

	public REXP idleEval(String cmd) {
		try {
			int lock = engine.tryLock();
			if(lock==0)
				return null;
			else{
				REXP e = engine.parseAndEval(cmd);
				engine.unlock(lock);
				return e;
			}
				
		} catch (REngineException e) {
			new ErrorMsg(e);
			return null;
		} catch (REXPMismatchException e) {
			new ErrorMsg(e);
			return null;
		}
	}

	public REngine getREngine() {
		// TODO Auto-generated method stub
		return engine;
	}

}
