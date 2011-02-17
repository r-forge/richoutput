package RichOutput;

import java.awt.Component;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextPane;

import org.rosuda.JGR.JGRConsole;
import org.rosuda.JGR.JGR;
import org.rosuda.JGR.toolkit.ConsoleOutput;
import org.rosuda.JGR.toolkit.PrefDialog;
import org.rosuda.JGR.toolkit.SyntaxInput;
import org.rosuda.JGR.util.ErrorMsg;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.deducer.Deducer;


/**
 * Overrides the console, and controls the main
 * OutputRecord of the session.
 *
 */
public class OutputController {

	public static ConsoleOutput output; 
	public static SyntaxInput input;
	public static JGRConsole console;
        public static Results1 elements = new Results1();
	public static Titles titles;
	public static OutputRecord record;
	
	public static HistoryWindow mainHistoryWindow;
//        public static Titles titles = new Titles();

	public static void replaceConsole(){
		
		record = new OutputRecord();
//                record.listen();
		
		console = JGR.MAINRCONSOLE;
		
		Component oldSplitPane = console.getContentPane().getComponent(1);
		console.getContentPane().remove(oldSplitPane);
		//System.out.println(console.getContentPane().getComponent(0).toString());
		//System.out.println(console.getContentPane().getComponent(1).toString());
		
		final JSplitPane consolePanel = new JSplitPane(
				JSplitPane.VERTICAL_SPLIT);
                final JSplitPane titlePanel = new JSplitPane(
                                JSplitPane.HORIZONTAL_SPLIT);
                input = new SyntaxInput("console", true);
		console.input = input;
		console.inputDoc = input.getDocument();
		input.addKeyListener(new InputListener());
		input.setWordWrap(false);
		input.addFocusListener(console);
		
		output = new HTMLConsoleOutput();
		console.output = output;
		console.outputDoc = output.getDocument();
		output.setEditable(false);
		output.addFocusListener(console);
		output.addKeyListener(console);
		output.setDragEnabled(true);

                elements.setContentType("text/html");

//                JScrollPane titleScroll = new JScrollPane(titles);
//                titleScroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

                JScrollPane sp1 = new JScrollPane(output);
		sp1.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

                final JTabbedPane tabbedPane = new JTabbedPane();
                tabbedPane.addTab("Console View", sp1);
                JScrollPane tabbedScroll = new JScrollPane(elements);
		tabbedScroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
                tabbedPane.addTab("Element View", tabbedScroll);
                consolePanel.setTopComponent(tabbedPane);

		JScrollPane sp2 = new JScrollPane(input);
		sp2.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		consolePanel.setBottomComponent(sp2);
		consolePanel.setDividerLocation(((int) ((double) console.getHeight() * 0.70)));
                consolePanel.setOneTouchExpandable(true);
                titles = new Titles();
                titlePanel.setLeftComponent(titles);
                titlePanel.setRightComponent(consolePanel);
                titlePanel.setDividerLocation(((int) ((double) console.getWidth() * 0.20)));
                titlePanel.setOneTouchExpandable(true);
		console.getContentPane().add(titlePanel);
		console.addComponentListener(new ComponentAdapter() {
			public void componentResized(ComponentEvent evt) {
				super.componentResized(evt);
				if (JGR.getREngine() != null && JGR.STARTED) {
					try {
						JGR.eval("options(width=" + console.getFontWidth() + ")");
					} catch (REngineException e) {
						new ErrorMsg(e);
					} catch (REXPMismatchException e) {
						new ErrorMsg(e);
					}
				}
				consolePanel
						.setDividerLocation(((int) ((double) console.getHeight() * 0.70)));
			}

		});
	
		/*
                 * Routing output through RichOutputConnector
                 */
                Deducer.setRConnector(new RichOutputConnector());

                /*
                 * Adding preferences panel
                 */
                DeducerRichPrefs.initialize();
                PanelRichPrefs richPrefs = new PanelRichPrefs();
                PrefDialog.addPanel(richPrefs, richPrefs);

//		mainHistoryWindow = new HistoryWindow(console);
//		mainHistoryWindow.setVisible(true);

//                codeSpy = new HTMLViewer();

	}
	
	

	static class InputListener implements KeyListener{
		boolean wasHistEvent = false;
		public void keyPressed(KeyEvent ke) {
			if (ke.getSource().equals(output) && !ke.isMetaDown()
					&& !ke.isControlDown() && !ke.isAltDown())
				input.requestFocus();
			if (ke.getKeyCode() == KeyEvent.VK_UP) {
				if (input.mComplete != null && input.mComplete.isVisible())
					input.mComplete.selectPrevious();
				else if (console.currentHistPosition > 0)
					if (input.getCaretPosition() == 0
							|| input.getCaretPosition() == input.getText().length()) {
						input.setText(JGR.RHISTORY.get(--console.currentHistPosition)
								.toString());
						input.setCaretPosition(input.getText().length());
						wasHistEvent = true;
					}
			} else if (ke.getKeyCode() == KeyEvent.VK_DOWN)
				if (input.mComplete != null && input.mComplete.isVisible())
					input.mComplete.selectNext();
				else if (input.getCaretPosition() == 0
						|| input.getCaretPosition() == input.getText().length()) {
					if (console.currentHistPosition < JGR.RHISTORY.size() - 1) {
						input.setText(JGR.RHISTORY.get(++console.currentHistPosition)
								.toString());
						input.setCaretPosition(input.getText().length());
					} else if (JGR.RHISTORY.size() > 0
							&& console.currentHistPosition < JGR.RHISTORY.size()) {
						input.setText("");
						console.currentHistPosition++;
					}
					wasHistEvent = true;
				}
		}

		/**
		 * keyReleased: handle key event, sending the command.
		 */
		public void keyReleased(KeyEvent ke) {
			if (ke.getKeyCode() == KeyEvent.VK_ENTER)
				if (input.mComplete != null && input.mComplete.isVisible()
						&& !(ke.isControlDown() || ke.isMetaDown()))
					input.mComplete.completeCommand();
				else if (ke.isControlDown() || ke.isMetaDown())
					try {
						input.getDocument().insertString(input.getCaretPosition(), "\n", null);
						input.mComplete.setVisible(false);
					} catch (Exception e) {
					}
				else {
					String cmd = input.getText().trim();
					input.setText("");
					input.setCaretPosition(0);
					input.requestFocus();
					Deducer.execute(cmd);
				}
			if (ke.getSource().equals(output) && ke.getKeyCode() == KeyEvent.VK_V
					&& (ke.isControlDown() || ke.isMetaDown())) {
				input.requestFocus();
				input.paste();
				input.setCaretPosition(input.getText().length());
			} else if ((ke.getKeyCode() == KeyEvent.VK_UP || ke.getKeyCode() == KeyEvent.VK_DOWN)
					&& wasHistEvent) {
				wasHistEvent = false;
				input.setCaretPosition(input.getText().length());
			}
		}

		public void keyTyped(KeyEvent arg0) {
			// TODO Auto-generated method stub
			
		}
	}
	
	
}


