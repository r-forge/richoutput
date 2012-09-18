package DeducerANOVA;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;
import javax.swing.border.BevelBorder;
import javax.swing.border.TitledBorder;
import org.rosuda.JGR.layout.AnchorConstraint;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPInteger;
import org.rosuda.REngine.REXPLogical;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.deducer.Deducer;
import org.rosuda.deducer.models.ModelPlotPanel;
import org.rosuda.deducer.widgets.*;

public class ANOVA2 extends SimpleRDialog implements ActionListener {
     private VariableSelectorWidget variableSelector;
     private JButton OptionButton;
     private JButton PlotButton;
     private SingleVariableWidget DV;
     private VariableListWidget Between;
     private VariableListWidget Within;
     private JButton ReshapeButton;
     private SingleVariableWidget SubjectID;
     private CheckBoxesWidget Rownames;
     private JButton UpdateButton;
     private JSplitPane EastWest;
     private JSplitPane NorthSouth;
     private StyledPane Output; // JTextPane that accepts HTML
     private JPanel PreviewPanel;
     private ModelPlotPanel PlotPanel;
     private JTabbedPane StatsTabbedPane;
     private String tmp = Deducer.getUniqueName("tmp");
     private ANOVAoptions Options;
     private ANOVAplot Plot;
     
    
     public void initGUI(){
        super.initGUI();                       
        variableSelector = new VariableSelectorWidget();
		this.add(variableSelector, new AnchorConstraint(10, 200, 700, 10, 
				AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_ABS));
		variableSelector.setPreferredSize(new java.awt.Dimension(216, 379));
		variableSelector.setTitle("Data"); 
        OptionButton = new JButton("Options");
                OptionButton.addActionListener(this);
                OptionButton.setActionCommand("Options");
                OptionButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(OptionButton, new AnchorConstraint(720, 170, 780, 40, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                Options = new ANOVAoptions();        
        PlotButton = new JButton("Plot");
                PlotButton.addActionListener(this);
                PlotButton.setActionCommand("Plot");
                PlotButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(PlotButton, new AnchorConstraint(790, 170, 850, 40, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));  
                Plot = new ANOVAplot();                    
                    
                    
        DV = new SingleVariableWidget(variableSelector);
                JPanel DVPanel = new JPanel(new GridLayout(0, 1));                              
                DVPanel.setBorder(BorderFactory.createTitledBorder(BorderFactory.createEtchedBorder(BevelBorder.LOWERED), 
                    "Dependent Variable", TitledBorder.LEADING, TitledBorder.DEFAULT_POSITION));                
                DVPanel.add(DV);
                this.add(DVPanel, new AnchorConstraint(10, 500, 150, 230, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));                
        Between = new VariableListWidget("Between-Ss Variables",variableSelector);
                this.add(Between, new AnchorConstraint(160, 500, 400, 230, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                Between.setPreferredSize(new java.awt.Dimension(276, 63));
        Within = new VariableListWidget("Between-Ss Variables",variableSelector);
                this.add(Within, new AnchorConstraint(410, 500, 650, 230, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                Within.setPreferredSize(new java.awt.Dimension(276, 63));
        ReshapeButton = new JButton("Reshape Data");
                ReshapeButton.addActionListener(this);
                ReshapeButton.setActionCommand("Reshape");
                ReshapeButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(ReshapeButton, new AnchorConstraint(660, 500, 720, 380, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));                
        SubjectID = new SingleVariableWidget(variableSelector);
                JPanel IDPanel = new JPanel(new GridLayout(0, 1));                              
                IDPanel.setBorder(BorderFactory.createTitledBorder(BorderFactory.createEtchedBorder(BevelBorder.LOWERED), 
                    "Subject ID", TitledBorder.LEADING, TitledBorder.DEFAULT_POSITION));                
                IDPanel.add(SubjectID);
                this.add(IDPanel, new AnchorConstraint(730, 500, 830, 230, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
        String[] RowString = {"Use Rownames","dummy"};
        Rownames = new CheckBoxesWidget(RowString);
                Rownames.setDefaultModel("Use Rownames");                    
                Rownames.removeButton(1);
                this.add(Rownames, new AnchorConstraint(840, 500, 900, 100, 
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
        UpdateButton = new JButton("Update Preview");
                UpdateButton.addActionListener(this);
                UpdateButton.setActionCommand("Update");
                getRootPane().setDefaultButton(UpdateButton);
                UpdateButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(UpdateButton, new AnchorConstraint(910, 500, 990, 230, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));                
                
        PreviewPanel = new JPanel();
                PreviewPanel.setBorder(BorderFactory.createTitledBorder(BorderFactory.createEtchedBorder(BevelBorder.LOWERED), 
                            "Preview", TitledBorder.LEADING, TitledBorder.DEFAULT_POSITION));                 
                PreviewPanel.setLayout(new BorderLayout());                                  
                PlotPanel = new ModelPlotPanel(null); // begins with a blank plot
                PreviewPanel.add(PlotPanel, new AnchorConstraint(0, 1000, 500, 0, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                StatsTabbedPane = new JTabbedPane();
                /*
                 * Ideally, set StatsTabbedPane up to dynamically build the tabs from the output.                 
                 * use method removeAll() to get rid of all the tabs when the view is refreshed.
                 * Create scrollpanes to put into each tab, and then put the StyledPane into the scrollpane.
                 */ 
                PreviewPanel.add(StatsTabbedPane, new AnchorConstraint(501, 1000, 1000, 0, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));               
                this.add(PreviewPanel, new AnchorConstraint(0, 990, 900, 510, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
        this.setTitle("Analysis of Variance");
                setOkayCancel(true,true,this);   //put Run, Reset, Cancel buttons in place, and register this as it's listener
                addHelpButton("pmwiki.php");     //Add help button pointing to main manual page
                this.setSize(900, 600);           
    }

     private String implode(String[] ary, String delim) {
        String out = "";
        for(int i=0; i<ary.length; i++) {
            out+=ary[i];
            if(i!=ary.length-1) { out += delim; }            
        }
        return out;
    }
     
     public String checkErrors(){
         String error = "";
         if(DV.getSelectedVariable().isEmpty())
             return("Error: Please select a Dependent Variable");
         else if(Between.getVariables().length + Within.getVariables().length < 1)
             return("Error: Please select at least one Between-Subjects or Within-Subjects Variable");
         else if(SubjectID.getSelectedVariable().isEmpty() && Rownames.getBoxes().isEmpty())
             return("Error: Please specify a subject ID variable or check the \"Use Rownames\" box");
         return(error);
     }
     
     public String generateCommand(){
         String command = checkErrors();
         if(command.startsWith("Error")) return(command);            
         else { 
         /*
          * Assemble all the R code for ANOVA
          */         
             Vector CheckedOptions = (Vector) Options.OptionBoxes.getModel();
             String wid = SubjectID.getSelectedVariable();
                 if(!Rownames.getBoxes().isEmpty()) wid = "rownames("+variableSelector.getSelectedData()+"),\n"; 
             String btw = "NULL";
                 if(Between.getVariables().length>0) btw = "between = .("+implode(Between.getVariables(),",")+")";
             String win = "NULL";
                 if(Within.getVariables().length>0) win = "within = .("+implode(Within.getVariables(),",")+")";
             String type = "3";
                 if(CheckedOptions.contains("Type II SS (default is Type III)")) type = "2";
             String detailed = "FALSE";
                 if(CheckedOptions.contains("Detailed output (SS, LR, AIC, etc.)")) detailed = "TRUE";
             String descriptives = "FALSE";
                 if(CheckedOptions.contains("Descriptive statistics")) descriptives = "TRUE";
             String Tukey = "FALSE";
                 if(CheckedOptions.contains("Tukey HSD (Btw-Ss only)")) Tukey = "TRUE";
             String xwithin = "FALSE";
                 Vector withinVec = (Vector) Plot.xWithin.getModel();
                 if(withinVec.contains("Connect points on the x-axis")) xwithin="TRUE";
             command = tmp+"<- DeducerANOVA(data = "+variableSelector.getSelectedData()+",\n"+
                     " ,dv = "+DV.getSelectedVariable()+"\n"+
                     " ,wid = "+wid+"\n"+
                     " ,between = "+btw+"\n"+
                     " ,within = "+win+"\n"+
                     " ,type = "+type+"\n"+
                     " ,detailed = "+detailed+"\n"+
                     " ,descriptives = "+descriptives+"\n"+
                     " ,Tukey = "+Tukey+"\n"+
                     " ,x = "+Plot.xVar+"\n"+
                     " ,split = "+Plot.SplitVar.getSelectedVariable()+"\n"+
                     " ,xwithin = "+xwithin+"\n"+
                     " ,x_lab = "+Plot.xLabel.getValidatedText()+"\n"+
                     " ,y_lab = "+Plot.yLabel.getValidatedText()+"\n"+
                     " ,split_lab = "+Plot.splitLabel.getValidatedText()+")\n";
            }
         return(command);
     }
     
     
     public void runPreview() {
         String command = generateCommand();
         if(command.startsWith("Error")) {
             /*
              * Displays the error in an output window
              */
             StatsTabbedPane.removeAll();
             JTextPane ErrorPane = new JTextPane();
             ErrorPane.setText(command);
             JScrollPane message = new JScrollPane(ErrorPane);
             StatsTabbedPane.addTab("Error",message);             
         } else{
             StatsTabbedPane.removeAll();
             /*
              * TODO: Find a way to identify an error in the execution of the R code and display that, too.
              */
             try {
                Deducer.eval(command); 
                int Length = Deducer.eval("length("+tmp+")").asInteger();
                String[] TabNames = Deducer.eval("names("+tmp+")").asStrings();
                for(int i=0;i<Length;i++){
                    if(TabNames[i].startsWith("plot")) { // One of the output list elements will be the call to produce a plot.
                        String call = Deducer.eval(tmp+"[["+(i+1)+"]]").asString();
                        PlotPanel = new ModelPlotPanel(call);
                    }
                    else StatsTabbedPane.addTab(TabNames[i], new StyledPane(Deducer.eval("h.df("+tmp+"[["+(i+1)+"]])").asString()));                    
                }                
            } catch (REXPMismatchException ex) {
                Logger.getLogger(ANOVA.class.getName()).log(Level.SEVERE, null, ex);
            }                
         }
     }
     
     public void actionPerformed(ActionEvent e) {
                String cmd = e.getActionCommand();      
                if(cmd=="Run"){
                    
                }else if(cmd=="Reset"){
                    
                }else if(cmd=="Cancel"){                    
                    
                }else if(cmd=="Options"){
                    Options.setLocationRelativeTo(this);
                    Options.setVisible(true);
                    
                }else if(cmd=="Plot"){
                    Plot.plotVariableSelector.setModel(variableSelector.getSelectedData()); // set data to what is in variableSelector 
                    Plot.plotVariableSelector.setRFilter("is.factor"); // Display only FACTORS for selection.
                    if(Within.getVariables().length > 0) { // If there is at least one within-Ss factor,
                        Plot.xVar.setModel(Within.getVariables()[0]); // then pick the first within-Ss factor for x-axis,
                        if(Between.getVariables().length > 0) { // and if there is also a btw-Ss factor,
                            Plot.SplitVar.setModel(Between.getVariables()[0]); // put the btw-Ss factor in the legend.
                        }
                    }
                    else if(Between.getVariables().length > 0) { // Otherwise, if there is at least one btw-Ss factor,
                        Plot.xVar.setModel(Between.getVariables()[0]); // put that on the x-axis,
                        if(Between.getVariables().length > 1) { // and if there is more than one Btw-Ss factor,
                            Plot.SplitVar.setModel(Between.getVariables()[1]); // set the 2nd to the legend.
                        }
                    }
                    Plot.setLocationRelativeTo(this);
                    Plot.setVisible(true);   
                    
                }else if(cmd=="Reshape"){
                    
                }else if(cmd=="Update"){
                    /*
                     * Don't forget to Deducer.makeValidVariableName on the plot textboxes
                     */
                }
        }
}
        