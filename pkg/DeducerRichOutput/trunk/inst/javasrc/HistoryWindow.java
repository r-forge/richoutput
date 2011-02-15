package RichOutput;

import java.awt.BorderLayout;
import java.awt.Window;
import java.awt.event.MouseEvent;
import javax.swing.BorderFactory;

import javax.swing.JList;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;

import org.rosuda.deducer.toolkit.SideWindow;

/**
 * A window attached to the right side of the console containing
 * the command/dialog history. 
 *
 */
public class HistoryWindow extends SideWindow{

	JList lis;

	public HistoryWindow(Window theParent) {
		super(theParent);
		this.setSize(200, 300);
		this.setLayout(new BorderLayout());
                lis = new JList() {
//                    public String getToolTipText(MouseEvent e) {
//                        int index = locationToIndex(e.getPoint());
//                        if (-1 < index) {
//                          String item = (String)getModel().getElementAt(index);
//                          return item;
//                        } else {
//                          return null;
//                        }
//                      }
                };
		this.add(lis);
                lis.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
                lis.setBorder(BorderFactory.createEmptyBorder(10,10,10,10));
                ListRenderer render = new ListRenderer();
                lis.setCellRenderer(render);
		lis.setModel(OutputController.record.getModel());
		offset = 100;
                lis.addListSelectionListener(new ListSelectionListener() {

                    public void valueChanged(ListSelectionEvent e) {
                        if (e.getValueIsAdjusting() == false) {

                            //Selection, scroll to results.
                                int index = lis.getSelectedIndex();
                                OutputElement elem = (OutputElement) OutputController.record.get(index); // Retrieving the selected element from OutputRecord
                                String elementID = elem.getId();
                                Document doc = OutputController.console.outputDoc;
                                String code = null;
                                    try {
                                        code = doc.getText(0, doc.getLength());
                                        int location = code.indexOf(elementID,0);
                                        OutputController.output.scrollToReference(elementID);
                                    } catch (BadLocationException ex) {
                                        }
                            }
                    }

                });

        }

}
