package RichOutput;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
import org.rosuda.JGR.util.ErrorMsg;
import org.rosuda.ibase.Common;
import org.rosuda.JGR.toolkit.*;

public class PanelRichPrefs extends PrefDialog.PJPanel implements ActionListener {
    private JPanel BodyPanel;
    private JLabel bodyFontFamilySelectorLabel;
    private JComboBox bodyFontFamilySelector;
    private JLabel bodyFontColorSelectorLabel;
    private JComboBox bodyFontColorSelector;
    private JLabel bodyFontSizeSelectorLabel;
    private JComboBox bodyFontSizeSelector;
    private JPanel TablePanel;
    private JPanel MiscTablePanel;
    private JLabel tableBorderThicknessSelectorLabel;
    private JComboBox tableBorderThicknessSelector;
    private JLabel TDtextAlignSelectorLabel;
    private JComboBox TDtextAlignSelector;
    private JLabel alternatingRowColorSelectorLabel;
    private JButton alternatingRowColorSelector;
    private JPanel TableHeaderPanel;
    private JLabel THfontStyleSelectorLabel;
    private JComboBox THfontStyleSelector;
    private JLabel THfontWeightSelectorLabel;
    private JComboBox THfontWeightSelector;
    private JLabel THtextAlignSelectorLabel;
    private JComboBox THtextAlignSelector;
    private JButton THbackgroundColorSelector;
    private JLabel THbackgroundColorSelectorLabel;

    public PanelRichPrefs() {
        super();
        initGUI();
        reset();
    }

    private void initGUI() {
	try {
            setPreferredSize(new Dimension(540, 400));
            this.setName("Deducer Rich Output");
            this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
            {
                BodyPanel = new JPanel();
                BodyPanel.setLayout(new FlowLayout());
                BodyPanel.setBorder(BorderFactory.createTitledBorder("HTML Body (default font)"));
                this.add(BodyPanel);
                {
                    bodyFontFamilySelectorLabel = new JLabel("Font family:");
                    String[] fontFamilies = { "Arial", "Times New Roman", "Courier" };
                    bodyFontFamilySelector = new JComboBox(fontFamilies);
                    bodyFontFamilySelector.setSelectedIndex(0);
//                    bodyFontFamilySelector.addActionListener(this);
                    BodyPanel.add(bodyFontFamilySelectorLabel);
                    BodyPanel.add(bodyFontFamilySelector);
                }
                {
                    bodyFontColorSelectorLabel = new JLabel("  Font color:");
                    String[] fontColor = { "black", "blue", "red" };
                    bodyFontColorSelector = new JComboBox(fontColor);
                    bodyFontColorSelector.setSelectedIndex(0);
//                    bodyFontColorSelector.addActionListener(this);
                    BodyPanel.add(bodyFontColorSelectorLabel);
                    BodyPanel.add(bodyFontColorSelector);
                }
                {
                    bodyFontSizeSelectorLabel = new JLabel("  Font size:");
                    String[] fontSize = { "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18" };
                    bodyFontSizeSelector = new JComboBox(fontSize);
                    bodyFontSizeSelector.setSelectedIndex(2);
//                    bodyFontSizeSelector.addActionListener(this);
                    BodyPanel.add(bodyFontSizeSelectorLabel);
                    BodyPanel.add(bodyFontSizeSelector);
                }
                TablePanel = new JPanel();
                TablePanel.setLayout(new FlowLayout());
                TablePanel.setBorder(BorderFactory.createTitledBorder("Tables"));
                this.add(TablePanel);
                {
                    TableHeaderPanel = new JPanel();
                    TableHeaderPanel.setLayout(new GridLayout(0,2));
                    TableHeaderPanel.setBorder(BorderFactory.createTitledBorder("Table Headers <TH>"));
                    TablePanel.add(TableHeaderPanel);
                    {
                        THfontStyleSelectorLabel = new JLabel("Font Style:");
                        TableHeaderPanel.add(THfontStyleSelectorLabel);
                        String[] fontStyles = { "normal", "italic" };
                        THfontStyleSelector = new JComboBox(fontStyles);
                        THfontStyleSelector.setSelectedIndex(1);
                        TableHeaderPanel.add(THfontStyleSelector);
                    }{
                        THfontWeightSelectorLabel = new JLabel("Font Weight:");
                        TableHeaderPanel.add(THfontWeightSelectorLabel);
                        String[] fontWeights = { "normal", "bold" };
                        THfontWeightSelector = new JComboBox(fontWeights);
                        THfontWeightSelector.setSelectedIndex(0);
                        TableHeaderPanel.add(THfontWeightSelector);
                    }{
                        THtextAlignSelectorLabel = new JLabel("Text Align:");
                        TableHeaderPanel.add(THtextAlignSelectorLabel);
                        String[] textAligns = { "left", "center", "right" };
                        THtextAlignSelector = new JComboBox(textAligns);
                        THtextAlignSelector.setSelectedIndex(1);
                        TableHeaderPanel.add(THtextAlignSelector);
                    }{
                        THbackgroundColorSelectorLabel = new JLabel("Table header background:");
                        TableHeaderPanel.add(THbackgroundColorSelectorLabel);
                        THbackgroundColorSelector = new JButton();
//                        THbackgroundColorSelector.setBackground(Color.red);
//                        THbackgroundColorSelector.setForeground(Color.blue);
                        THbackgroundColorSelector.addActionListener(this);
                        TableHeaderPanel.add(THbackgroundColorSelector);
                    }
                }
                {
                    MiscTablePanel = new JPanel();
                    MiscTablePanel.setLayout(new GridLayout(0,2));
                    MiscTablePanel.setBorder(BorderFactory.createTitledBorder("Misc. Table Formatting"));
                    TablePanel.add(MiscTablePanel);
                    {
                        tableBorderThicknessSelectorLabel = new JLabel("Table border thickness:");
                        MiscTablePanel.add(tableBorderThicknessSelectorLabel);
                        String[] borderThick = { "0", "1", "2" };
                        tableBorderThicknessSelector = new JComboBox(borderThick);
                        tableBorderThicknessSelector.setSelectedIndex(1);
//                        tableBorderThicknessSelector.addActionListener(this);
                        MiscTablePanel.add(tableBorderThicknessSelector);
                    }
                    {
                        TDtextAlignSelectorLabel = new JLabel("Table element text alignment");
                        MiscTablePanel.add(TDtextAlignSelectorLabel);
                        String[] textAligns = { "left", "center", "right" };
                        TDtextAlignSelector = new JComboBox(textAligns);
                        TDtextAlignSelector.setSelectedIndex(2);
//                        TDtextAlignSelector.addActionListener(this);
                        MiscTablePanel.add(TDtextAlignSelector);
                    }
                    {
                        alternatingRowColorSelectorLabel = new JLabel("Background of alternate rows:");
                        MiscTablePanel.add(alternatingRowColorSelectorLabel);
                        alternatingRowColorSelector = new JButton();
                        alternatingRowColorSelector.addActionListener(this);
                        MiscTablePanel.add(alternatingRowColorSelector);
                    }
                }
            }
            if (!Common.isMac()) {
                alternatingRowColorSelector.setContentAreaFilled(false);
                alternatingRowColorSelector.setOpaque(true);
                THbackgroundColorSelector.setContentAreaFilled(false);
                THbackgroundColorSelector.setOpaque(true);
            } else {
		alternatingRowColorSelector.setText("Color");
		THbackgroundColorSelector.setText("Color");
		}
        } catch (Exception e) {
			new ErrorMsg(e);
		}
    }
    public String hexColor(Color c) {
        String hexColor8 = Integer.toHexString(c.getRGB());
        String hexColor6 = "#" + hexColor8.substring(2);
        return hexColor6;
    }

    public String getColor(JButton b) {
		if (!Common.isMac()) {
			return hexColor(b.getBackground());
		} else
			return hexColor(b.getForeground());
	}

    public void setColor(JButton b, Color c) {
		if (!Common.isMac()) {
			b.setBackground(c);
//                        b.setForeground(c);
		} else
			b.setForeground(c);
//                        b.setBackground(c);
	}

    public void saveAll(){
		DeducerRichPrefs.bodyFontFamily = (String) bodyFontFamilySelector.getSelectedItem();
		DeducerRichPrefs.bodyFontColor = (String) bodyFontColorSelector.getSelectedItem();
		DeducerRichPrefs.bodyFontSize = (String) bodyFontSizeSelector.getSelectedItem();
                DeducerRichPrefs.tableBorderThickness = (String) tableBorderThicknessSelector.getSelectedItem();
                DeducerRichPrefs.THfontStyle = (String) THfontStyleSelector.getSelectedItem();
                DeducerRichPrefs.THfontWeight = (String) THfontWeightSelector.getSelectedItem();
                DeducerRichPrefs.THtextAlign = (String) THtextAlignSelector.getSelectedItem();
                DeducerRichPrefs.THbackgroundColor = getColor(THbackgroundColorSelector);
                DeducerRichPrefs.TDtextAlign = (String) TDtextAlignSelector.getSelectedItem();
                DeducerRichPrefs.alternatingRowColor = getColor(alternatingRowColorSelector);
		DeducerRichPrefs.writePrefs();
	}

	public void reset(){
                bodyFontFamilySelector.setSelectedItem(DeducerRichPrefs.bodyFontFamily);
		bodyFontColorSelector.setSelectedItem(DeducerRichPrefs.bodyFontColor);
                bodyFontSizeSelector.setSelectedItem(DeducerRichPrefs.bodyFontSize);
                tableBorderThicknessSelector.setSelectedItem(DeducerRichPrefs.tableBorderThickness);
                THfontStyleSelector.setSelectedItem(DeducerRichPrefs.THfontStyle);
                THfontWeightSelector.setSelectedItem(DeducerRichPrefs.THfontWeight);
                THtextAlignSelector.setSelectedItem(DeducerRichPrefs.THtextAlign);
                setColor(THbackgroundColorSelector, Color.decode(DeducerRichPrefs.THbackgroundColor));
                TDtextAlignSelector.setSelectedItem(DeducerRichPrefs.TDtextAlign);
                setColor(alternatingRowColorSelector, Color.decode(DeducerRichPrefs.alternatingRowColor));
	}
//
	public void resetToFactory(){
		bodyFontFamilySelector.setSelectedItem("Arial");
		bodyFontColorSelector.setSelectedItem("black");
                bodyFontSizeSelector.setSelectedItem("10");
                tableBorderThicknessSelector.setSelectedItem("1");
                THfontStyleSelector.setSelectedItem("italic");
                THfontWeightSelector.setSelectedItem("normal");
                THtextAlignSelector.setSelectedItem("center");
                setColor(THbackgroundColorSelector, Color.decode("#e8e8e8"));
                TDtextAlignSelector.setSelectedItem("right");
                setColor(alternatingRowColorSelector, Color.decode("#dbe8ff"));
	}

    public void actionPerformed(ActionEvent e) {
        Object src = e.getSource();
        Object cmd = e.getActionCommand();
        Color newColor;
        if (src == alternatingRowColorSelector) {
            newColor = JColorChooser.showDialog(this, "Background for alternating rows", alternatingRowColorSelector.getBackground());
                if (newColor != null)
                    setColor(alternatingRowColorSelector, newColor);
        }
        else if (src == THbackgroundColorSelector) {
            newColor = JColorChooser.showDialog(this, "Background for table header", THbackgroundColorSelector.getBackground());
            if (newColor != null)
                    setColor(THbackgroundColorSelector, newColor);
        }
        if (cmd == "Save All") {
            saveAll();
        }
        else if (cmd == "Cancel") {
            reset();
        }
        else if (cmd == "Reset All") {
            resetToFactory();
        }
    }

    
}