package RichOutput;

import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.ListCellRenderer;

class ListRenderer extends JLabel implements ListCellRenderer {
        public ListRenderer() {
            setOpaque(true);
            setFont(new Font("SansSerif", Font.PLAIN, 12));
        }

        public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
            setText(value.toString());
            //Can also have html-formatted text like below, but it doesn't quite work with the background/foreground colors
            //setText("<html><font face=\"Verdana\"><font color=\"black\"><font size=4>"+value.toString()+"</font></font></font></html>");

         Color background;
         Color foreground;

         // check if this cell represents the current DnD drop location
         JList.DropLocation dropLocation = list.getDropLocation();
         if (dropLocation != null
                 && !dropLocation.isInsert()
                 && dropLocation.getIndex() == index) {

             background = Color.BLUE;
             foreground = Color.WHITE;

         // check if this cell is selected
         } else if (isSelected) {
             background = Color.BLUE;
             foreground = Color.WHITE;

         // unselected, and not the DnD drop location
         } else {
             background = Color.WHITE;
             foreground = Color.BLACK;
         };

         setBackground(background);
         setForeground(foreground);

         return this;
        }
    }