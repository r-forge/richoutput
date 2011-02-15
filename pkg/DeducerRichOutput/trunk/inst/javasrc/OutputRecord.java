package RichOutput;

import javax.swing.DefaultListModel;
import javax.swing.event.ListDataEvent;
import javax.swing.event.ListDataListener;

/**
 * A record is a collection of OutputElements. The last element
 * is considered the active element, so if the output record is the main one
 * for the session, results coming from R are funneled to it.
 *
 */
public class OutputRecord {

    private DefaultListModel recordModel = new DefaultListModel();

    public void add(OutputElement elem) {
        recordModel.addElement(elem);
    }
    public void add(int index, OutputElement elem) {
        recordModel.insertElementAt(elem,index);
    }
    public void remove(OutputElement elem) {
        recordModel.removeElement(elem);
    }
    public void remove(int index) {
        recordModel.removeElementAt(index);
    }
    public OutputElement get(int index) {
        return (OutputElement) recordModel.get(index);
    }
    
    public OutputElement getActiveElement(){
    	if(size()==0)
    		return null;
    	else
    		return (OutputElement) recordModel.get(size()-1);
    }
    
    public int size() {
        return(recordModel.getSize());
    }
    
    public DefaultListModel getModel(){
    	return recordModel;
    }
//    public void listen() {
//        recordModel.addListDataListener(new ListDataListener() {
//
//            public void intervalAdded(ListDataEvent e) {
//                OutputElement elem = (OutputElement) get(size()); // get last element
//                OutputController.elements.setText(elem.getOutput());
//            }
//
//            public void intervalRemoved(ListDataEvent e) {
//               }
//
//            public void contentsChanged(ListDataEvent e) {
//               }
//        });
//    }
}
