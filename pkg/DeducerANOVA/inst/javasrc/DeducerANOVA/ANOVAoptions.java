package DeducerANOVA;

import java.awt.Dialog;
import java.util.Arrays;
import java.util.Vector;
import org.rosuda.JGR.layout.AnchorConstraint;
import org.rosuda.deducer.widgets.CheckBoxesWidget;
import org.rosuda.deducer.widgets.SimpleRSubDialog;

/**
 *
 * @author altermattw
 */
public class ANOVAoptions extends SimpleRSubDialog {
        
        public CheckBoxesWidget OptionBoxes;
        
        public ANOVAoptions() {
            super();
            initGUI();
        }
        
        public ANOVAoptions(Dialog owner){
            super(owner);
            initGUI();
        }
        
        public void initGUI(){
            super.initGUI();  
            String[] OptList = new String[] {"Type II SS (default is Type III)",
                                    "Detailed output (SS, LR, AIC, etc.)", 
                                    "Descriptive statistics",
                                    "Tukey HSD (Btw-Ss only)"};
            OptionBoxes = new CheckBoxesWidget("Options",OptList);
                    Object[] DefaultList = {				 
                            "Descriptive statistics",
                            "Tukey HSD (Btw-Ss only)"};
                    Vector v = new Vector(Arrays.asList(DefaultList));
                    OptionBoxes.setDefaultModel(v); 
           
            this.add(OptionBoxes, new AnchorConstraint(10, 990, 700, 10, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL, 
				AnchorConstraint.ANCHOR_REL, AnchorConstraint.ANCHOR_REL));
            this.setTitle("ANOVA Options");
            this.setSize(350, 350);  
        }
        public void setDefaultModel(Vector Model){
            OptionBoxes.setModel(Model);
        }
        public Vector getOptions(){
            Vector v = (Vector) OptionBoxes.getModel();
            return(v);
        }
}
