package kr.co.common.com.utils;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.PrintServiceAttribute;
import javax.print.attribute.standard.PrinterName;

import org.apache.commons.logging.Log;

public class Zebra {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String txt = " ^XA ^MMT^PW719^LL0400^LS0^FS ^MMT^PW740^LL0400^LS-4^LT24^FS  ^SEE:UHANGUL.DAT^FS  ^CW1,E:KFONT5.FNT^CI26^FS  ^FT30,50^A1N,40,35^FD생 산 전 표^FS  ^FT590,50^A1N,35,30^FDAAA^FS ^FT45,105^A1N,30,30^FD차 종^FS ^FT45,160^A1N,30,30^FD품 번^FS ^FT45,215^A1N,30,30^FD품 명^FS ^FT45,270^A1N,30,30^FD수 량^FS ^FT320,105^A1N,30,30^FD작업장^FS ^FT396,270^A1N,30,30^FD생산일자^FS ^FT525,215^A1N,30,30^FD합격^FS ^FT150,105^A1N,35,30^FDAAA^FS  ^FT150,160^A1N,35,30^FDAAA^FS  ^FT150,215^A1N,35,30^FDAAA^FS  ^FT150,270^A1N,35,30^FDAAA^FS  ^FT430,105^A1N,35,25^FD  ^FS ^FT615,160^A1N,35,30^FD ^FS ^FT530,270^A1N,35,30^FDAAA^FS ^FT605,215^A1N,30,25^FDAAA^FS ^BY2,2,67^FT80,361^BCN,,N,N ^FD || C1.BAR_CD || ^FS ^FT80,385^A1N,25,25^FDAAA^FS ^FO22,8^GB714,0,3^FS  ^FO22,394^GB714,0,3^FS ^FO22,8^GB0,386,3^FS ^FO732,8^GB0,386,3^FS ^FO30,287^GB688,0,3^FS ^FO30,231^GB688,0,2^FS ^FO30,175^GB688,0,3^FS ^FO394,231^GB0,56,3^FS ^FO518,175^GB0,112,3^FS  ^FO590,118^GB0,112,3^FS  ^FO414,64^GB0,57,3^FS    ^FO317,64^GB0,57,3^FS    ^FO715,64^GB0,226,3^FS   ^FO134,64^GB0,226,3^FS   ^FO30,64^GB0,226,3^FS    ^FO30,119^GB688,0,3^FS   ^FO30,64^GB688,0,3^FS    ^PQ1,0,1,Y  ^XZ " ; 
		String print_nm = "zm40";		
		int cnt = 1;
		for(int i=0; i<cnt ; i++){
			try{
				printFile(txt , print_nm);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	};
	
	public static void printFile(String txt , String print_nm){
		try {
			 PrintService psZebra = null;
	           String sPrinterName = null;
	           PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);
	           
	           for (int i = 0; i < services.length; i++) {
	               
	               PrintServiceAttribute attr = services[i].getAttribute(PrinterName.class);
	               sPrinterName = ((PrinterName) attr).getValue();
	               
	               if (sPrinterName.toLowerCase().indexOf( print_nm ) >= 0) {
	                   psZebra = services[i];
	                   break;
	               };
	           };
	           
	           if (psZebra == null) {
	               System.out.println("Zebra printer is not found.");
	               return;
	           };
	           
	           DocPrintJob job = psZebra.createPrintJob();

	           byte[] by = txt.getBytes();
	           
	           DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
	           Doc doc = new SimpleDoc(by, flavor, null);
	           job.print(doc, null);
		    
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
