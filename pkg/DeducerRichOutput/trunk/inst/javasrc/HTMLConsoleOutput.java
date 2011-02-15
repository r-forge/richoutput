package RichOutput;

import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import javax.swing.ButtonGroup;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.text.*;
import javax.swing.text.html.HTML;
import javax.swing.text.html.HTMLDocument;
import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.html.StyleSheet;

import org.rosuda.JGR.toolkit.ConsoleOutput;
import org.rosuda.JGR.toolkit.FontTracker;
import org.rosuda.JGR.toolkit.JGRPrefs;

/**
 * This class handles the rich output coming from R.
 * Output is displayed in the console, and passed to the
 * active OutputElement
 *
 */
public class HTMLConsoleOutput extends ConsoleOutput {

        private String code;
        private Boolean continues = false;
        private Boolean waitingForPre = false;
        private Boolean waitingForSlashPre = false;
        private String beginning = "";
        private StringBuilder sb = new StringBuilder();

        public HTMLConsoleOutput() {
		if (FontTracker.current == null)
			FontTracker.current = new FontTracker();
		FontTracker.current.add(this);
		this.setContentType("text/html");
		this.setEditorKit(new HTMLEditorKit());
                
	}

        /**
	 * Open export dialog.
	 */
	public void startExport() {
		new ExportOutput(this);
	}

	public void append(String str,AttributeSet a){
		HTMLDocument doc = (HTMLDocument) this.getDocument();
                HTMLEditorKit ed = (HTMLEditorKit) this.getEditorKit();
                /**
                 * Adding CSS styling.                 
                 */
                StyleSheet styleSheet = ed.getStyleSheet();
                     styleSheet.addRule("body {margin-left:10px; margin-top:10px; margin-right:10px; margin-bottom:10px;}");
                     styleSheet.addRule("body {color:" + DeducerRichPrefs.bodyFontColor + "; font-family:" + DeducerRichPrefs.bodyFontFamily + "; font-size: " + DeducerRichPrefs.bodyFontSize + "px;}");
                     styleSheet.addRule("body {background-color:white;}");
                     // internal borders:
                     styleSheet.addRule("table, td, th {border-top-style: solid; border-top-color: black; border-top-width: " + DeducerRichPrefs.tableBorderThickness + "px;}");
                     // table header and cells
                     styleSheet.addRule("td, th {padding-right: 10px; padding-left: 10px;}");
                     styleSheet.addRule("th {font-style: " + DeducerRichPrefs.THfontStyle + "; font-weight: " + DeducerRichPrefs.THfontWeight + "; text-align: " + DeducerRichPrefs.THtextAlign + "; background-color:" + DeducerRichPrefs.THbackgroundColor + ";}");
                     styleSheet.addRule("td {font-style: normal; font-weight: normal; text-align: " + DeducerRichPrefs.TDtextAlign + ";}");
                     // alternating row colors. Use "<tr class=\"d0\"> and "<tr class=\"d1\"> to activate.
                     styleSheet.addRule("tr.d0 td {background-color: #ffffff; color: black;}"); // white
                     styleSheet.addRule("tr.d1 td {background-color: " + DeducerRichPrefs.alternatingRowColor + "; color: black;}"); // light blue
                     // text elements
                     styleSheet.addRule("div {text-indent: 10 px;}");
                     styleSheet.addRule("p.b {margin-top: 7px; margin-bottom: 7px; font-weight: bold;}");
                     styleSheet.addRule("th.section {padding-top: 10px; padding-bottom: 10px; text-align: center; font-style: normal; font-weight: bold");
                     // pre tag formatting to remove extra line break
                     styleSheet.addRule("pre {margin-bottom: 0px; margin-top: 0px}");

                try{
                    if(a == JGRPrefs.RESULT){
                        if (!str.startsWith("</pre>")) { // doesn't start with </pre> so is not HTML
                             str = str.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;");
                             str = "<font color = \"blue\">" + str + "</font>";
                            }


                        // Using a buffer to store up unclosed </pre> tags
                            // Causes problems if function interrupted before closing tag is printed.
//                        do {
//                            if(waitingForPre) { // HTML code at beginning
//                                if (!str.contains("<pre>")) { // all HTML, no closing tag
//                                    sb.append(str);
//                                    str = ""; // setting str.length() = 0
//                                    }
//                                else {
//                                    int cutPoint = str.indexOf("<pre>")+4;
//                                    sb.append(str.substring(0,cutPoint));
//                                    waitingForPre = false;
//                                    if (cutPoint == str.length()-1) str=""; // end of str
//                                    else str = str.substring(cutPoint+1,str.length()-1);
//                                    }
//                            }
//                            if(waitingForSlashPre) { // plain-text at the beginning
//                                if(!str.contains("</pre>")) { // all plain-text
//                                    str = str.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;");
//                                    sb.append(str);
//                                    str="";
//                                    }
//                                else { // it does contain the </pre> tag
//                                    waitingForSlashPre = false;
//                                    int cutPoint = str.indexOf("</pre>")+5;
//                                    String before = str.substring(0,cutPoint);
//                                    before = before.replaceAll("</pre>", "").replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;");
//                                    sb.append(before);
//                                    if (cutPoint == str.length()-1) str=""; // end of str
//                                    else str = str.substring(cutPoint+1,str.length()-1);
//                                    }
//                            }
//                            if(!str.startsWith("<pre>") && !str.startsWith("</pre>")) { // not HTML
//                                str = str.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;");
//                                sb.append(str);
//                                str="";
//                                }
//                            else if (str.startsWith("<pre>")) { // starts with <pre>; render all up to </pre> into plain-text
//                                if (str.contains("</pre>")) {
//                                    int cutPoint = str.indexOf("</pre>")+5;
//                                    sb.append(str.substring(0,cutPoint)); // keep original text within <pre> block
//                                    if (cutPoint == str.length()-1) str = "";
//                                    else str = str.substring(cutPoint+1,str.length()-1);
//                                }
//                                else { // no closing </pre> tag
//                                    waitingForSlashPre = true;
//                                    sb.append(str);
//                                    str="";
//                                }
//                            }
//                            else { // starts with </pre>
//                                if (str.contains("<pre>")) { // contains closing tag
//                                    int cutPoint = str.indexOf("<pre>")+4;
//                                    String before = str.substring(0,cutPoint);
//                                    sb.append(before); // adds the HTML
//                                    if (cutPoint == str.length()-1) str = "";
//                                    else str = str.substring(cutPoint+1,str.length()-1);
//                                }
//                                else { // no closing <pre> tag. Whole str is HTML
//                                    waitingForPre = true;
//                                    sb.append(str);
//                                    str="";
//                                }
//                            }
//                        } while (str.length() > 0);
//
//                        /*
//                         * If there is an incomplete pair of <pre></pre> tags, wait for the complement to appear before printing
//                         */
//                        if (waitingForPre || waitingForSlashPre) return;
//
//                        else {
//                            str = sb.toString();
//                            sb.setLength(0); // clearing the StringBuilder
//                        }
                        OutputElement el = OutputController.record.getActiveElement();
                            code = "<pre>" + str + "</pre>";
                            if(el!=null) {
                                    el.setOutput(el.getOutput() + code );
                                    ed.insertHTML(doc, doc.getLength(), code, 0, 0, null);
                                    }
                            else {
                                    ed.insertHTML(doc, doc.getLength(), code, 0, 0, null);
                                    }
                            }

                    else if (a == JGRPrefs.CMD) {
                        str = str.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;");
                        if (continues) {
                            str = beginning + str;
                            continues = false;
                            ed.insertHTML(doc, doc.getLength(), "<pre><font color = \"red\">" + str + "</font></pre>", 0, 0, null);
                            }                        
                        else if(str.startsWith("+") || str.startsWith("&gt;")) {
                            beginning = str;
                            continues = true;
                            return;
                            }
                        else {
                            str = str.replaceAll("\n", "<br/>");
                            ed.insertHTML(doc, doc.getLength(), "<pre><font color = \"red\">" + str + "</font></pre>", 0, 0, null);
                        }
                    }
                    else{
                            ed.insertHTML(doc, doc.getLength(), "<pre>" + str + "</pre>", 0, 0, null);
                    }
		}catch(Exception e){JOptionPane.showMessageDialog(null,"error:"+e.toString());
			e.printStackTrace();}        
        int index = OutputController.record.size();
        if (index >= 1) OutputController.titles.setIndex(index-1);
        }

       private void saveToFile(File file, StringBuffer bf) {
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter(file));
			writer.write(bf.toString());
			writer.flush();
			writer.close();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, "Permisson denied");
		} finally {
		}
	}

       private String cssHeader() {
           StringBuilder cssSB = new StringBuilder();
                cssSB.append("<style type=\"text/css\">\n");
                cssSB.append("body {margin-left:10px; margin-top:10px; margin-right:10px; margin-bottom:10px;}\n");
                cssSB.append("body {color:").append(DeducerRichPrefs.bodyFontColor).append("; font-family:").append(DeducerRichPrefs.bodyFontFamily).append("; font-size: ").append(DeducerRichPrefs.bodyFontSize).append("px;}\n");
                cssSB.append("body {background-color:white;}\n");
                cssSB.append("table, td, th {border-top-style: solid; border-top-color: black; border-top-width: ").append(DeducerRichPrefs.tableBorderThickness).append("px;}\n");
                cssSB.append("td, th {padding-right: 10px; padding-left: 10px;}\n");
                cssSB.append("th {font-style: ").append(DeducerRichPrefs.THfontStyle).append("; font-weight: ").append(DeducerRichPrefs.THfontWeight).append("; text-align: ").append(DeducerRichPrefs.THtextAlign).append("; background-color:").append(DeducerRichPrefs.THbackgroundColor).append(";}\n");
                cssSB.append("td {font-style: normal; font-weight: normal; text-align: ").append(DeducerRichPrefs.TDtextAlign).append("; }\n");
                cssSB.append("tr.d0 td {background-color: #ffffff; color: black;}\n");
                cssSB.append("tr.d1 td {background-color: ").append(DeducerRichPrefs.alternatingRowColor).append("; color: black;}\n");
                cssSB.append("div {text-indent: 10 px;}\n");
                cssSB.append("p.b {margin-top: 7px; margin-bottom: 7px; font-weight: bold;}\n");
                cssSB.append("th.section {padding-top: 10px; padding-bottom: 10px; text-align: center; font-style: normal; font-weight: bold}\n");
                cssSB.append("pre {margin-bottom: 0px; margin-top: 0px}\n");
                cssSB.append("</style>\n");
            String cssStyling = cssSB.toString();
            return cssStyling;
       }


       private void exportOutput(File file) {
           HTMLDocument doc = (HTMLDocument) this.getDocument();
           Element[] roots = doc.getRootElements(); // #0 is the HTML element, #1 the bidi-root
           Element head = null;
           for( int i = 0; i < roots[0].getElementCount(); i++ ) {
                Element element = roots[0].getElement( i );
                if( element.getAttributes().getAttribute( StyleConstants.NameAttribute ) == HTML.Tag.HEAD ) {
                    head = element;
                    break;
                }
            }
            try {
                doc.insertAfterStart(head, cssHeader());
            } catch (BadLocationException ex) {
            } catch (IOException ex) {
            }         
           HTMLEditorKit kit = new HTMLEditorKit();            
           BufferedOutputStream out;
                try {
                        out = new BufferedOutputStream(new FileOutputStream (file));                        
                        kit.write(out, doc, doc.getStartPosition().getOffset(), doc.getLength());
                        out.close();
                    } catch (FileNotFoundException e) {
                        JOptionPane.showMessageDialog(null, "Error: File not found.");
                    } catch (IOException e){
                        JOptionPane.showMessageDialog(null, "I/O Exception.");
                    } catch (BadLocationException e){
                        JOptionPane.showMessageDialog(null, "Bad Location Exception in Document.");
                    }
        }

        private void exportCommands(File file) {
            OutputRecord record = OutputController.record;
            StringBuffer bf = new StringBuffer();
//            HTMLDocument doc = new HTMLDocument();
//            HTMLEditorKit kit = (HTMLEditorKit) this.getEditorKit();
            for (int i = 0; i < record.size(); i++) {
                OutputElement el = record.get(i);
                bf.append(el.getRcall()).append("\n");
//                try {
//                try {
//                    kit.insertHTML(doc, doc.getLength(), el.getRcall(), 0, 0, null);
//                } catch (BadLocationException ex) { }
//                } catch (IOException ex) {
//                JOptionPane.showMessageDialog(null, "I/O Exception.");
//                }
            }
            saveToFile(file, bf);
        }

        private void exportResult(File file) {
            OutputRecord record = OutputController.record;
            StringBuffer bf = new StringBuffer();
            bf.append("<HTML><head>").append(cssHeader()).append("</head><body>");
//            HTMLDocument doc = new HTMLDocument();
//            HTMLEditorKit kit = new HTMLEditorKit();
//            String[] nonsense = {"a","b","c"};
            for (int i = 0; i < record.size(); i++) {
                OutputElement el = record.get(i);
                bf.append(el.getOutput()).append("\n");
//                try {
//                try {
//                    kit.insertHTML(doc, doc.getLength(), el.getOutput(), 0, 0, null);
//                } catch (BadLocationException ex) { }
//                } catch (IOException ex) { }
            }
            bf.append("</body></HTML>");
            saveToFile(file, bf);
	}

        class ExportOutput extends JFileChooser implements ActionListener {

		/**
		 * Over-rides ExportOutput in ConsoleOutput to accommodate HTML
		 */

		private HTMLConsoleOutput out;
		private final JRadioButton wholeOutput = new JRadioButton("Complete Output", true);
		private final JRadioButton cmdsOutput = new JRadioButton("Commands", false);
		private final JRadioButton resultOutput = new JRadioButton("Results", false);
		public ExportOutput(HTMLConsoleOutput co) {
			super(JGRPrefs.workingDirectory);
			out = co;

			ButtonGroup bg = new ButtonGroup();
			bg.add(wholeOutput);
			bg.add(cmdsOutput);
			bg.add(resultOutput);

			this.addActionListener(this);

			if (System.getProperty("os.name").startsWith("Window")) {
				JPanel fileview = (JPanel) ((JComponent) ((JComponent) this.getComponent(2)).getComponent(2)).getComponent(2);

				JPanel options = new JPanel(new FlowLayout(FlowLayout.LEFT));
				options.add(new JLabel("Options: "));
				options.add(wholeOutput);
				options.add(cmdsOutput);
				options.add(resultOutput);

				fileview.add(options);
				JPanel pp = (JPanel) ((JComponent) ((JComponent) this.getComponent(2)).getComponent(2)).getComponent(0);
				pp.add(new JPanel());
			} else {
				JPanel filename = (JPanel) this.getComponent(this.getComponentCount() - 1);
				JPanel options = new JPanel(new FlowLayout(FlowLayout.LEFT));
				options.add(new JLabel("Options: "));
				options.add(wholeOutput);
				options.add(cmdsOutput);
				options.add(resultOutput);

				filename.add(options, filename.getComponentCount() - 1);
			}

			this.showSaveDialog(co);
                }

		public void export(File file) {
			if (wholeOutput.isSelected())
				out.exportOutput(file);
			else if (cmdsOutput.isSelected())
				out.exportCommands(file);
			else if (resultOutput.isSelected())
				out.exportResult(file);
		}

		public void actionPerformed(ActionEvent e) {
			String cmd = e.getActionCommand();
			if (cmd == "ApproveSelection")
				export(this.getSelectedFile());
		}
         }
	
}



