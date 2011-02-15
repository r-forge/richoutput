package RichOutput;

import java.awt.Dimension;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextPane;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.html.HTMLEditorKit;

public class HTMLViewer extends JFrame {
    private JTextArea textArea;
    private JScrollPane scrollPane;

public HTMLViewer() {
    super("HTMLViewer");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setPreferredSize(new Dimension(800, 600));
    textArea = new JTextArea();
    refresh();
    textArea.setEditable(false);
    scrollPane = new JScrollPane(textArea);
    setContentPane(scrollPane);
    pack();
    setVisible(true);
    }

public void refresh() {
    textArea.setText(OutputController.output.getText());
    }
}