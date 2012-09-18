package DeducerANOVA;

import java.awt.Dialog;
import java.awt.GridLayout;
import java.util.Arrays;
import java.util.Vector;
import javax.swing.*;
import javax.swing.border.BevelBorder;
import javax.swing.border.TitledBorder;
import org.rosuda.JGR.layout.AnchorConstraint;
import org.rosuda.deducer.toolkit.DJList;
import org.rosuda.deducer.widgets.*;

/**
 *
 * @author altermattw
 */
public class ANOVAplot extends SimpleRSubDialog {
        
        public VariableSelectorWidget plotVariableSelector;
        public SingleVariableWidget xVar;
        public SingleVariableWidget SplitVar;        
        public TextFieldWidget xLabel;
        public TextFieldWidget yLabel;
        public TextFieldWidget splitLabel;
        public CheckBoxesWidget xWithin;
        
        public ANOVAplot() {
            super();
            initGUI();
        }
        
        public ANOVAplot(Dialog owner){
            super(owner);
            initGUI();
        }
        
        public void initGUI(){
            super.initGUI();
            plotVariableSelector = new VariableSelectorWidget();
                plotVariableSelector.setTitle("Data");
                this.add(plotVariableSelector, new AnchorConstraint(10, 420, 820, 10, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));            
            xVar = new SingleVariableWidget("Factor for x-axis",plotVariableSelector);                                
                this.add(xVar, new AnchorConstraint(10, 990, 160, 490, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));			                
            SplitVar = new SingleVariableWidget("Factor for legend",plotVariableSelector);                
		this.add(SplitVar, new AnchorConstraint(170, 990, 320, 490,
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
            xLabel = new TextFieldWidget("X-axis label:");                
                this.add(xLabel, new AnchorConstraint(330, 990, 480, 490,
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
            yLabel = new TextFieldWidget("Y-axis label:");                
                this.add(yLabel, new AnchorConstraint(490, 990, 640, 490,
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
            splitLabel = new TextFieldWidget("Legend label:");
                this.add(splitLabel, new AnchorConstraint(650, 990, 800, 490,
                                AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
            String[] Connect = {"Connect points on the x-axis","dummy"};
                xWithin = new CheckBoxesWidget(Connect);
                    Object[] DefaultList = {"Connect points on the x-axis"};
                    Vector v = new Vector(Arrays.asList(DefaultList));
                    xWithin.setDefaultModel(v);                                       
                    xWithin.removeButton(1);
                    this.add(xWithin, new AnchorConstraint(810, 420, 960, 10, 
                                    AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
                                    AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL)); 
            this.setTitle("Plotting Options");
            this.setSize(600, 400);  
        }
    public void setData(String dataname){
        plotVariableSelector.setModel(dataname);
    }
    
    public String getxVar(){
        return(xVar.getSelectedVariable());
    }
    
    public void setxVar(String name){
        xVar.setModel(name);
    }
    
    public void setSplitVar(String name){
        SplitVar.setModel(name);
    }
    
    public String getSplitVar(){
        return(SplitVar.getSelectedVariable());
    }
    
    public String getXLabel(){
        return(xLabel.getValidatedText());
    }
    
    public String getYLabel(){
        return(yLabel.getValidatedText());
    }
    
    public String getSplitLabel(){
        return(splitLabel.getValidatedText());
    }
    
    public void filterFactors(){
        plotVariableSelector.setRFilter("is.factor");
    }
    
    public String connectDots(){
        Vector v = (Vector) xWithin.getModel();
        String connect = "FALSE";
        if(v.contains("Connect points on the x-axis")) connect = "TRUE";
        return(connect);
    }
}
