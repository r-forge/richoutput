package RichOutput;

import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.html.HTMLDocument;
import javax.swing.text.html.HTMLEditorKit;

public class Titles extends JPanel {
    private static JList list;
    private static DefaultListModel listModel = OutputController.record.getModel();
    private static final String removeString = "Remove";
    private JButton removeButton;
    private static int elements = OutputController.record.size();

    public Titles() {
        super(new BorderLayout());
        list = new JList(listModel);
        list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        list.setBorder(BorderFactory.createEmptyBorder(10,10,10,10));
        ListRenderer render = new ListRenderer();
        list.setCellRenderer(render);
        list.addMouseListener(new MouseListener() {
            public void mouseClicked(MouseEvent e) {
                int index = list.getSelectedIndex();
                itemSelected(index);
//                 int index = list.getSelectedIndex();
//                        OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
//                        String elementID = elem.getId();
//                        OutputController.output.scrollToReference(elementID);
//                        String out = "<p>call: " + elem.getRcall() + "</p>\n" + elem.getOutput();
//                        OutputController.elements.setText(out);
                OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
                if (!elem.getRcall().isEmpty()) OutputController.input.setText(elem.getRcall());
            }
            public void mousePressed(MouseEvent e) {}
            public void mouseReleased(MouseEvent e) {}
            public void mouseEntered(MouseEvent e) {}
            public void mouseExited(MouseEvent e) {}
        });
        list.addListSelectionListener(new ListSelectionListener() {
            public void valueChanged(ListSelectionEvent e) {
                if (e.getValueIsAdjusting() == false) {

                    if (list.getSelectedIndex() == -1) {
                    //No selection, disable remove button.
                        removeButton.setEnabled(false);

                    } else {
                    //Selection, enable the remove button and scroll to element.
                        removeButton.setEnabled(true);
                        int index = list.getSelectedIndex();
                        itemSelected(index);
//                        int index = list.getSelectedIndex();
//                        OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
//                        String elementID = elem.getId();
//                        OutputController.output.scrollToReference(elementID);
//                        OutputController.elements.setText(elem.getOutput());
                    }
                }
            }
        });
//        updateTitles();
        list.addKeyListener(new KeyListener() {
            public void keyTyped(KeyEvent e) {                
            }
            public void keyPressed(KeyEvent e) {
                int keyCode = e.getKeyCode();
                if (KeyEvent.getKeyText(keyCode) == "Delete") {
                    if (list.getSelectedIndex() == -1) { }  // No selection. Do nothing.
                    else {                                  // Selection. Remove selected item.
                        removeItem();
                        }
                    }
                }
            public void keyReleased(KeyEvent e) {                
            }
        });
        JScrollPane listScrollPane = new JScrollPane(list);

        // Setting up the remove button
        removeButton = new JButton(removeString);
        removeButton.setActionCommand(removeString);
//        removeButton.addActionListener(new RemoveListener());
        removeButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                removeItem();
            }
        });
        if (elements == 0) removeButton.setEnabled(false);

        JPanel buttonPane = new JPanel();
        buttonPane.add(removeButton, BorderLayout.CENTER);
        buttonPane.setBorder(BorderFactory.createEmptyBorder(5,5,5,5));

        // Adding the components to the panel
        add(listScrollPane, BorderLayout.CENTER);
        add(buttonPane, BorderLayout.PAGE_END);
        
    }

    public void setIndex(int index) {
        list.setSelectedIndex(index);
        OutputElement elem = (OutputElement) OutputController.record.get(index);
        OutputController.elements.setText(elem.getOutput());
    }
    
    private void itemSelected(int index) {
        OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
        String elementID = elem.getId();
        OutputController.output.scrollToReference(elementID);        
        OutputController.elements.setText(elem.getOutput());
    }

    private void removeItem() {
         int index = list.getSelectedIndex();
            HTMLDocument doc = (HTMLDocument) OutputController.console.outputDoc;
            OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
            String elementID = elem.getId();
            if (index == listModel.getSize()-1) { // if it's the last element
                try {
                    int startCut = doc.getElement(elementID).getStartOffset();
                    doc.remove(startCut, doc.getLength()-startCut);
                    OutputController.elements.setText(null);
                } catch (BadLocationException ex) {
                    JOptionPane.showMessageDialog(null, ex.toString());
                    }
            }
            else { // if it's not the last element.  This is working great now.
                try {
                    int startCut = doc.getElement(elementID).getStartOffset();
                    OutputElement nextElem = (OutputElement) OutputController.record.get(index+1);
                    String nextElementID = nextElem.getId();
                    int endCut = doc.getElement(nextElementID).getStartOffset(); // delete to beginning of next element
                    doc.remove(startCut, endCut-startCut);
                } catch (BadLocationException ex) {
                    JOptionPane.showMessageDialog(null, ex.toString());
                    }
            }
            OutputController.record.remove(index); // Removing the element from RecordListModel at the location specified in index
            if (listModel.getSize() == 0) { // If no elements remain...
                    removeButton.setEnabled(false); // disable removal
            }
                else { //Select an index.
                    if (index == listModel.getSize()) {index--;} //index decreases by 1 if last element removed
                    list.setSelectedIndex(index);
                    list.ensureIndexIsVisible(index);
                    }
    }

//    class RemoveListener implements ActionListener {
//        public void actionPerformed(ActionEvent e) {
//            int index = list.getSelectedIndex();
//            HTMLDocument doc = (HTMLDocument) OutputController.console.outputDoc;
//            OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
//            String elementID = elem.getId();
//            if (index == listModel.getSize()-1) { // if it's the last element
//                try {
//                    int startCut = doc.getElement(elementID).getStartOffset();
//                    doc.remove(startCut, doc.getLength()-startCut);
//                } catch (BadLocationException ex) {
//                    JOptionPane.showMessageDialog(null, ex.toString());
//                    }
//            }
//            else { // if it's not the last element.  This is working great now.
//                try {
//                    int startCut = doc.getElement(elementID).getStartOffset();
//                    OutputElement nextElem = (OutputElement) OutputController.record.get(index+1);
//                    String nextElementID = nextElem.getId();
//                    int endCut = doc.getElement(nextElementID).getStartOffset(); // delete to beginning of next element
//                    doc.remove(startCut, endCut-startCut);
//                } catch (BadLocationException ex) {
//                    JOptionPane.showMessageDialog(null, ex.toString());
//                    }
//            }
//            OutputController.record.remove(index); // Removing the element from RecordListModel at the location specified in index
//            if (listModel.getSize() == 0) { // If no elements remain...
//                    removeButton.setEnabled(false); // disable removal
//            }
//                else { //Select an index.
//                    if (index == listModel.getSize()) {index--;} //index decreases by 1 if last element removed
//                    list.setSelectedIndex(index);
//                    list.ensureIndexIsVisible(index);
//                    }
//        }
//    }

//    public static void updateTitles() {
//            listModel.clear();
//            int count = OutputRecord.size();
//            if (count > 0) {
//            for (int i = 0; i < count; i++) {
//                OutputElement elem = (OutputElement) OutputRecord.get(i);
//                listModel.addElement(elem.getTitle());
//                }
//            list.setSelectedIndex(count-1);
//            list.ensureIndexIsVisible(count-1);
//            String elementsText = String.valueOf(count);
//            elementCount.setText("Elements: " + elementsText);
//            }
//    }
}
