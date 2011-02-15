package RichOutput;


import javax.swing.JTextPane;
import javax.swing.text.html.HTMLEditorKit;
import javax.swing.text.html.StyleSheet;

public class Elements extends JTextPane {
    public Elements() {
        super();
        setContentType("text/html"); // ready to accept HTML input
        setEditable(false);
        HTMLEditorKit kit = new HTMLEditorKit();
        setEditorKit(kit);
        StyleSheet styleSheet = kit.getStyleSheet();
             styleSheet.addRule("body {margin-left:10px; margin-top:10px; margin-right:10px; margin-bottom:10px;}");
             styleSheet.addRule("body {color:black; font-family:Arial,sans-serif; font-size: 10px;}");
             styleSheet.addRule("body {background-color:white;}");             
             // internal borders:
             styleSheet.addRule("table, td, th {border-right-style: solid; border-right-color: black; border-right-width: 1px;");
             styleSheet.addRule("table, td, th {border-left-style: solid; border-left-color: black; border-left-width: 1px;");
             styleSheet.addRule("table, td, th {border-bottom-style: solid; border-bottom-color: black; border-bottom-width: 1px;");
             styleSheet.addRule("table, td, th {border-top-style: solid; border-top-color: black; border-top-width: 1px;");
             // table header and cells
             styleSheet.addRule("td, th {padding-right: 10px; padding-left: 10px;}");
             styleSheet.addRule("th {font-style: italic; font-weight: normal; text-align: center; background-color:#e8e8e8}");
             styleSheet.addRule("td {font-style: normal; font-weight: normal; text-align: right; }");
             // alternating row colors. Use "<tr class=\"d0\"> and "<tr class=\"d1\"> to activate.
             styleSheet.addRule("tr.d0 td {background-color: #ffffff; color: black;}"); // white
             styleSheet.addRule("tr.d1 td {background-color: #dbe8ff; color: black;}"); // light blue
             // text elements
             styleSheet.addRule("div {text-indent: 10 px;}");
             styleSheet.addRule("p.b {margin-top: 7px; margin-bottom: 7px; font-weight: bold;}");
             styleSheet.addRule("th.section {padding-top: 10px; padding-bottom: 10px; text-align: center; font-style: normal; font-weight: bold");

    }

}


