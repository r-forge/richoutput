package DeducerANOVA;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Arrays;
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
import org.rosuda.deducer.GDPreviewJPanel;
import org.rosuda.deducer.models.ModelPlotPanel;
import org.rosuda.deducer.widgets.*;

public class ANOVA extends SimpleRDialog implements ActionListener {
     private VariableSelectorWidget variableSelector;
     private JButton OptionButton;
     private JButton PlotButton;
     private JButton CallButton;
     private SingleVariableWidget DV;
     private VariableListWidget Between;
     private VariableListWidget Within;
     private JButton ReshapeButton;
     private SingleVariableWidget SubjectID;
     private CheckBoxesWidget Rownames;
     private JButton UpdateButton;
     private JPanel PreviewPanel;
     private JPanel PlotPanel;
     public JTabbedPane StatsTabbedPane;
     private String tmp = Deducer.getUniqueName("tmp");
     private ANOVAoptions Options;
     private ANOVAplot Plot;
     private DeducerReshape.WideToLong2 ReshapeDialog;     
     private JPanel ANOVAplot;
     private String SubjID = Deducer.getUniqueName("SubjID");
     private String wid = "";
     private JButton DrawPlot;
     
     public ANOVA(String data){
         initGUI();
         variableSelector.setDefaultModel(data);
     }
     public ANOVA(){
         initGUI();
     }
     
     public void initGUI(){
        super.initGUI();                       
        variableSelector = new VariableSelectorWidget();
		this.add(variableSelector, new AnchorConstraint(10, 150, 700, 10, 
				AnchorConstraint.ANCHOR_ABS, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_ABS));
		variableSelector.setPreferredSize(new java.awt.Dimension(216, 379));
		variableSelector.setTitle("Data"); 
                variableSelector.getJComboBox().addActionListener(new ChangeData()); // listener to variableSelector. When data changes, updates preview.
        OptionButton = new JButton("Options");
                OptionButton.addActionListener(this);
                OptionButton.setActionCommand("Options");
                OptionButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(OptionButton, new AnchorConstraint(720, 145, 780, 35, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                Options = new ANOVAoptions(this);
        PlotButton = new JButton("Plot");
                PlotButton.addActionListener(this);
                PlotButton.setActionCommand("Plot");
                PlotButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(PlotButton, new AnchorConstraint(790, 145, 850, 35, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));  
                Plot = new ANOVAplot(this); 
        CallButton = new JButton("View Call");
                CallButton.addActionListener(this);
                CallButton.setActionCommand("Call");
                CallButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(CallButton, new AnchorConstraint(860, 145, 920, 35, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL)); 
        DV = new SingleVariableWidget("Dependent Variable",variableSelector);
                this.add(DV, new AnchorConstraint(10, 400, 130, 180, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));                
        Between = new VariableListWidget("Between-Ss Variables",variableSelector);
                this.add(Between, new AnchorConstraint(140, 400, 380, 180, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                Between.setPreferredSize(new java.awt.Dimension(276, 63));
        Within = new VariableListWidget("Within-Ss Variables",variableSelector);
                this.add(Within, new AnchorConstraint(390, 400, 630, 180, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                        AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
                Within.setPreferredSize(new java.awt.Dimension(276, 63));
        ReshapeButton = new JButton("Reshape Data");
                ReshapeButton.addActionListener(this);
                ReshapeButton.setActionCommand("Reshape");
                ReshapeButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(ReshapeButton, new AnchorConstraint(640, 400, 700, 200, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));                
        SubjectID = new SingleVariableWidget("Subject ID", variableSelector);
                this.add(SubjectID, new AnchorConstraint(710, 400, 830, 180, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                            AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
        String[] RowString = {"Use Rownames","dummy"};
        Rownames = new CheckBoxesWidget(RowString);
                Rownames.setDefaultModel("Use Rownames");                    
                Rownames.removeButton(1);
                this.add(Rownames, new AnchorConstraint(840, 400, 900, 200, 
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
        UpdateButton = new JButton("Update Preview");
                UpdateButton.addActionListener(this);
                UpdateButton.setActionCommand("Update");
                getRootPane().setDefaultButton(UpdateButton);
                UpdateButton.setPreferredSize(new java.awt.Dimension(84, 50));
                this.add(UpdateButton, new AnchorConstraint(920, 620, 980, 450, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));  
        DrawPlot = new JButton("Draw Plot");
                DrawPlot.addActionListener(this);
                DrawPlot.setActionCommand("Draw");
                this.add(DrawPlot, new AnchorConstraint(920, 320, 980, 200, 
                                    AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                                    AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL)); 
                
        PreviewPanel = new JPanel();
                PreviewPanel.setBorder(BorderFactory.createTitledBorder(BorderFactory.createEtchedBorder(BevelBorder.LOWERED), 
                            "Preview", TitledBorder.LEADING, TitledBorder.DEFAULT_POSITION));                 
                PreviewPanel.setLayout(new BorderLayout()); 
                StatsTabbedPane = new JTabbedPane();                
//                    PlotPanel = new JPanel(); 
//                        StatsTabbedPane.addTab("Plot",new JScrollPane(PlotPanel));
//                    aov = new StyledPane();
//                        StatsTabbedPane.addTab("ANOVA",new JScrollPane(aov));
//                    Levene = new StyledPane();
//                        StatsTabbedPane.addTab("HOV",new JScrollPane(Levene));
//                    descriptives = new StyledPane();
//                        StatsTabbedPane.addTab("Descriptives",new JScrollPane(descriptives));
//                    posthoc = new StyledPane();
//                        StatsTabbedPane.addTab("Post-hoc Tests",new JScrollPane(posthoc));
//                    modelSummary = new StyledPane();
//                        StatsTabbedPane.addTab("Model Summary",new JScrollPane(modelSummary));
                PreviewPanel.add(StatsTabbedPane);               
                this.add(PreviewPanel, new AnchorConstraint(10, 990, 900, 410, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
        this.setTitle("Analysis of Variance");
                setOkayCancel(true,true,this);   //put Run, Reset, Cancel buttons in place, and register this as it's listener
                addHelpButton("pmwiki.php");     //Add help button pointing to main manual page
                this.setSize(1000, 600);           
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
         Vector UseRownames = (Vector) Rownames.getModel();         
         String error = "";
         if(DV.getSelectedVariable() == null) 
             return("Error: Please select a Dependent Variable");         
         else if(Between.getVariables().length + Within.getVariables().length < 1)
             return("Error: Please select at least one Between-Subjects or Within-Subjects Variable");
         else if(SubjectID.getSelectedVariable() == null && !UseRownames.contains("Use Rownames"))
             return("Error: Please specify a subject ID variable or check the \"Use Rownames\" box");
         return(error);
     }
     
     private String excludeDataCmd(){
        String dv = DV.getSelectedVariable();
        String data = variableSelector.getSelectedData();
        wid = getSubjID();            
        String btw = "NULL";
            if(Between.getVariables().length>0) btw = ".("+implode(Between.getVariables(),",")+")";
        String win = "NULL";
            if(Within.getVariables().length>0) win = ".("+implode(Within.getVariables(),",")+")";
        String exc = data+"."+tmp + " <-na.exclude("+data+"[,as.character(c(.("+wid+"),.("+dv+"),"+btw+","+win+"))])\n"; // Excluding rows with NAs.                                                      
        return(exc);
     }
     
     private String getSubjID(){
         String data = variableSelector.getSelectedData();         
         if(SubjectID.getSelectedVariable() != null)
                wid = SubjectID.getSelectedVariable();            
             else {
                if(!wid.contentEquals(SubjID)) {
                    Deducer.eval("if(!\"SubjID\" %in% names("+data+")) "+data+"$"+SubjID+" <- as.factor(rownames("+data+"))\n"); // If no SubjID var yet, set it equal to rownames
                    wid=SubjID;
                }
             }
         return(wid);
     }
     
     public String getPlotCall(){
         String PlotCall = "NULL";
         String x = "NULL";
             if(Plot.getxVar() != null) x = Plot.getxVar();
         if(!x.contentEquals("NULL")) {    
            String xwithin = Plot.connectDots();
            String dv = DV.getSelectedVariable();
            String split = "NULL";
                 if(Plot.getSplitVar() != null) split = Plot.getSplitVar();
            String xLabel = "NULL";
                 if(!Plot.getXLabel().isEmpty()) xLabel = "\""+Plot.getXLabel()+"\"";
            String yLabel = "NULL";
                 if(!Plot.getYLabel().isEmpty()) yLabel = "\""+Plot.getYLabel()+"\"";
            String SplitLabel = "NULL";
                 if(!Plot.getSplitLabel().isEmpty()) SplitLabel = "\""+Plot.getSplitLabel()+"\"";                              
            wid = getSubjID();                              
            String btw = "NULL";
                 if(Between.getVariables().length>0) btw = ".("+implode(Between.getVariables(),",")+")";
            String win = "NULL";
                 if(Within.getVariables().length>0) win = ".("+implode(Within.getVariables(),",")+")";
            String data = variableSelector.getSelectedData();
                        
            PlotCall = "ggplot() + theme_bw()"
                + " + geom_errorbar(aes(y = "+dv+", x = "+x+", linetype = "+split+", group = "+split+"),"
                + " data="+data+"."+tmp+", width = 0.4, fun.data = mean_cl_normal, conf.int = 0.95, stat = 'summary',"
                + " position = position_dodge(width = 0.5))"
                + " + geom_point(aes(x = "+x+", y = "+dv+", shape = "+split+", group = "+split+"),"
                + "   data="+data+"."+tmp+", size = 3.0, fun.data = mean_cl_normal, conf.int = 0.95,stat = 'summary', position = position_dodge(width = 0.5))";

            if(xwithin.contentEquals("TRUE")) {
                PlotCall += " + geom_line(aes(x = "+x+ ", y = "+dv+", linetype = "+split+", group = "+split+"),"
                        +"   data="+data+", fun.data = mean_cl_normal, conf.int = 0.95,stat = 'summary', position = position_dodge(width = 0.5))";
                        }
            if(!xLabel.contentEquals("NULL")) PlotCall += " + scale_x_discrete(name = "+xLabel+")";
            if(!yLabel.contentEquals("NULL")) PlotCall += " + scale_y_continuous(name = "+yLabel+")";
            if(!SplitLabel.contentEquals("NULL")) PlotCall += " + scale_linetype(name = "+SplitLabel+") + scale_shape(name = "+SplitLabel+")";                                   
            /*
             * Line below is temporary just to see if a straight plot command works.
             */
//            PlotCall = "plot("+data+"$"+x+","+data+"$"+dv+")\n";
         }
         return(PlotCall);
     }
     
     public String generateCommand(){          
         String command = checkErrors();
         if(command.startsWith("Error")) return(command);            
         else { 
         /*
          * Assemble all the R code for ANOVA
          */         
             String data = variableSelector.getSelectedData();
             String dv = DV.getSelectedVariable();
             Vector CheckedOptions = Options.getOptions();             
             wid = getSubjID();            
             String btw = "NULL";
                 if(Between.getVariables().length>0) btw = ".("+implode(Between.getVariables(),",")+")";
             String win = "NULL";
                 if(Within.getVariables().length>0) win = ".("+implode(Within.getVariables(),",")+")";
             String type = "3";
                 if(CheckedOptions.contains("Type II SS (default is Type III)")) type = "2";
             String detailed = "FALSE";
                 if(CheckedOptions.contains("Detailed output (SS, LR, AIC, etc.)")) detailed = "TRUE";
             String descriptives = "FALSE";
                 if(CheckedOptions.contains("Descriptive statistics")) descriptives = "TRUE";
             String Tukey = "FALSE";
                 if(CheckedOptions.contains("Tukey HSD (Btw-Ss only)") && win.contentEquals("NULL")) Tukey = "TRUE";

             command += tmp+"<- ezANOVA(data = "+data+"\n"+
                     " ,dv = "+dv+"\n"+
                     " ,wid = "+wid+"\n"+
                     " ,between = "+btw+"\n"+
                     " ,within = "+win+"\n"+
                     " ,type = "+type+"\n"+
                     " ,detailed = "+detailed+"\n"+
                     " ,return_aov = "+Tukey+")\n";
              if(descriptives.contentEquals("TRUE")) {
//                  command += tmp + "$descriptives <- descriptives(data = "+data+", dv = .("+dv+"), between = "+btw+", within = "+win+")\n";
                  command += tmp + "$descriptives <- ezStats(data = "+data+"\n"+
                     " ,dv = "+dv+"\n"+
                     " ,wid = "+wid+"\n"+
                     " ,between = "+btw+"\n"+
                     " ,within = "+win+"\n"+
                     " ,type = "+type+")\n";                     
              }             
              if(Tukey.contentEquals("TRUE")) {
                  command += tmp + "$Tukey <- TukeyHSD("+tmp+"$aov)\n";
                  command += tmp + "[[\"aov\"]] <- NULL\n"; // Removes the aov element from the tmp list
              }

//              command += tmp + "$\"Model Details\" <- as.data.frame(as.matrix(c(\"Data:\",\"Dependent variable:\",\"Subject ID:\",\""+
//                      "Between-subjects factor(s):\",\"Within-subjects factor(s):\",\"SS Type:\",\""+data+"\",\""+dv+"\",\""+wid+"\",\""+
//                      btw+"\",\""+win+"\",\""+type+"\",),ncol=2))";
//              
         return(command);
         }
     }
     
     public void addTab(String title, String contents){
         StatsTabbedPane.addTab(title, new JScrollPane(new StyledPane(contents)));
     }
     
     public void runPreview(){
         String command = generateCommand();
         if(command.startsWith("Error")) {
             JOptionPane.showMessageDialog(this, command);            
         } else{             
             /*
              * TODO: Find a way to identify an error in the execution of the R code and display that, too.
              */             
             StatsTabbedPane.removeAll();             
             Deducer.eval(generateCommand());              
            try {
                int Length = Deducer.eval("length("+tmp+")").asInteger();
                for(int i=0;i<Length;i++) {
                    String title = Deducer.eval("names("+tmp+")["+(i+1)+"]").asString();
//                    String title = ""+ i;

                    String[] output = Deducer.eval("capture.output(result.format("+tmp+"[["+(i+1)+"]]))").asStrings();
                    StringBuilder result = new StringBuilder();
                    for(int j=0;j<output.length;j++){
                        result.append(output[j]).append("\n");
                    }
//                    String contents = "testing!";
                    JTextArea printout = new JTextArea();
                    printout.setText(result.toString());
                    StatsTabbedPane.addTab(title,new JScrollPane(printout));
                }
                
                
   //             StatsTabbedPane.addTab("Plot", new ModelPlotPanel("plot(Adler$instruction,Adler$rating)"));

   //             PlotPanel.removeAll();
   //             PlotPanel.add(new ModelPlotPanel(getPlotCall()));             
                
   //             PlotPanel.removeAll();
   //             PlotPanel.add(ANOVAplot);                          
                   /*
                    * TODO:  Use Deducer.eval("if(exists("+tmp+"[[\'anova\']]))" to see if each component of the output is available,
                    * then send that on to the appropriate StyledPane with setText(Deducer.eval("h.df("+[item]+")").
                    */
                   
   //                    else StatsTabbedPane.addTab(TabNames[i], new StyledPane(Deducer.eval("h.df("+tmp+"[["+(i+1)+"]])").asString()));                    
   //                String[] TabNames = Deducer.eval("names("+tmp+")").asStrings();
   //                for(int i=0;i<Length;i++){
   //                    if(TabNames[i].startsWith("plot")) { // One of the output list elements will be the call to produce a plot.
   //                        String call = Deducer.eval(tmp+"[["+(i+1)+"]]").asString();
   //                        PlotPanel = new ModelPlotPanel(call);
   //                    }
   //                    else StatsTabbedPane.addTab(TabNames[i], new StyledPane(Deducer.eval("h.df("+tmp+"[["+(i+1)+"]])").asString()));
            } catch (REXPMismatchException ex) {
                Logger.getLogger(ANOVA.class.getName()).log(Level.SEVERE, null, ex);
            }
                
                          
         }
     }
     
     public void actionPerformed(ActionEvent e) {
                String cmd = e.getActionCommand();      
                if(cmd=="Run"){
                    String command = generateCommand();
                    if(command.startsWith("Error")) 
                        JOptionPane.showMessageDialog(this, command);
                    else {
                        if(Deducer.isLoaded("DeducerRichOutput")) Deducer.execute("cat(h.results("+command+"))");
                        else {
                            Deducer.eval(command);
                            Deducer.execute("print("+tmp+")");
                        }
                    }
                    Deducer.eval("if(exists("+tmp+") rm("+tmp+")"); // Removing tmp results object
                    /*
                     * TODO:  Provide option to keep results object
                     */
                    this.setVisible(false);
                    completed();
                }else if(cmd=="Reset"){
                    StatsTabbedPane.removeAll();
                    reset();
                }else if(cmd=="Cancel"){                    
                    Deducer.eval("if(exists("+tmp+") rm("+tmp+")"); // Removing tmp results object
                     this.setVisible(false); 
                }else if(cmd=="Options"){
                    Options.setLocationRelativeTo(this);
                    Options.run();
                }else if(cmd=="Call"){
                    JFrame f = new JFrame("Call");
                    f.setSize(700, 200);
                    f.setLayout(new BorderLayout());                    
                    JTextArea t = new JTextArea();
                    JScrollPane p = new JScrollPane(t);
                        f.add(p);                        
                        String call = generateCommand();  
                        t.setText(call+"\n");
                    f.setLocationRelativeTo(this);
                    f.setVisible(true);
                }else if(cmd=="Draw"){
                    if(Plot.getxVar() == null) {
                        JOptionPane.showMessageDialog(this, "Please select an x-axis factor in the Plot subdialog");
                    }                                     
                    else {
                        Deducer.eval(excludeDataCmd());
                        Deducer.execute("dev.new()\n"+getPlotCall());
                    }                    
                }else if(cmd=="Plot"){
                    /*
                     * Set up an IF-THEN to avoid the following if no data have been selected
                     */
                    if(variableSelector.getSelectedData() != null){
                        Plot.setData(variableSelector.getSelectedData()); // set data to what is in variableSelector 
//                        Plot.filterFactors(); // Display only FACTORS for selection.
//                        if(Within.getVariables() != null) { // If there is at least one within-Ss factor,
//                            Plot.setxVar(Within.getVariables()[0]); // then pick the first within-Ss factor for x-axis,
//                            if(Between.getVariables() != null) { // and if there is also a btw-Ss factor,
//                                Plot.setSplitVar(Between.getVariables()[0]); // put the btw-Ss factor in the legend.
//                            }
//                        }
//                        else 
//                        if(Between.getVariables().length > 0) { // Otherwise, if there is at least one btw-Ss factor,
//                            Plot.setxVar(Between.getVariables()[0]); // put that on the x-axis,
//                            if(Between.getVariables().length > 1) { // and if there is more than one Btw-Ss factor,
//                                Plot.setSplitVar(Between.getVariables()[0]); // set the 2nd to the legend.
//                            }
//                        }
                    }
                    
                    Plot.setLocationRelativeTo(this);
                    Plot.run();
//                    Plot.setVisible(true);   
                    
                }else if(cmd=="Reshape"){
                    this.setVisible(false);
                    completed();
                    ReshapeDialog = new DeducerReshape.WideToLong2("ANOVA");
                    ReshapeDialog.setData((String) variableSelector.getModel());
                    ReshapeDialog.setLocationRelativeTo(this);
                    ReshapeDialog.run();
                }else if(cmd=="Update"){
                    runPreview();
                    /*
                     * Don't forget to Deducer.makeValidVariableName on the plot textboxes
                     */
                }
        }
     public void setData(String dataname){
         variableSelector.setModel(dataname);
     }
     class ChangeData implements ActionListener{
            public void actionPerformed(ActionEvent e) {
                String data = (String) variableSelector.getModel();
                StatsTabbedPane.removeAll();
                reset();
            }
        }
}
        