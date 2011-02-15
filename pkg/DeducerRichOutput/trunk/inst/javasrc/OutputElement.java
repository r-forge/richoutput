package RichOutput;


import org.w3c.dom.Document;

/**
 * A rich output element.
 *
 */
public class OutputElement {
	private String title; //title of the analysis
	private String Rcall; //the Rcall that produced the output
	private String output;  //output of that command, in html
        private String id; //unique identification label
	private String date; // the date and time when the OutputElement was created
	private Document dialogModel;  //an xml document which can be used to load the associated dialog

	public OutputElement() {
	}

	public String getTitle() {
		return(title);
	}
	public void setTitle(String s) {
		title = s;
	}


	public String getRcall() {
		return(Rcall);
	}
	public void setRcall(String s) {
		Rcall = s;
	}
	public String getOutput() {
		return(output);
	}
	public void setOutput(String o) {
		output = o;
	}
	public String getId() {
		return(id);
	}
	public void setId(String i) {
		id = i;
	}
        public String getDate() {
		return(date);
	}
	public void setDate(String d) {
		date = d;
	}
	public Document getXML(){
		return dialogModel;
	}
	public void setXML(Document xml){
		dialogModel = xml;
	}

	public String toString(){return title;}
}