package RichOutput;

import javax.swing.JEditorPane;

import org.rosuda.deducer.models.PreviewComponentFactory;

public class RichModelPreviewFactory extends PreviewComponentFactory{
	public JEditorPane makePreviewComponent(){
		JEditorPane preview = new JEditorPane();
		preview.setContentType("text/html");
		preview.setEditable(false);
		return preview;
	}
}
