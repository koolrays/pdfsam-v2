/*
 * Created on 12-Oct-2007
 * Copyright (C) 2006 by Andrea Vacondio.
 *
 * This program is free software; you can redistribute it and/or modify it under the terms of the 
 * GNU General Public License as published by the Free Software Foundation; 
 * either version 2 of the License.
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program; 
 * if not, write to the Free Software Foundation, Inc., 
 *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */
package org.pdfsam.console.business.dto.commands;

import java.io.File;

import org.pdfsam.console.business.dto.PdfFile;


/**
 * Split parsed command dto filled by parsing service and used by worker service
 * @author Andrea Vacondio
 *
 */
public class SplitParsedCommand extends AbstractParsedCommand {

	private static final long serialVersionUID = -2409191188152350607L;

    public static final String S_BURST = "BURST";
    public static final String S_SPLIT = "SPLIT";    
    public static final String S_NSPLIT = "NSPLIT";    
    public static final String S_EVEN = "EVEN";    
    public static final String S_ODD = "ODD";
    public static final String S_SIZE = "SIZE";
    
	public static final String F_ARG = "f";
	public static final String P_ARG = "p";
	public static final String S_ARG = "s";
	public static final String N_ARG = "n";
	public static final String B_ARG = "b";
	public static final String O_ARG = "o";
    
    private File outputFile;
    private String outputFilesPrefix = "";
    private PdfFile inputFile;
    private String splitType = "";
    private Integer[] splitPageNumbers = new Integer[0];
    private Long splitSize;
    
    public SplitParsedCommand(){
    	
    }
    
	public SplitParsedCommand(File outputFile, String outputFilesPrefix, PdfFile inputFile,
			String splitType, Integer[] splitPageNumbers, Long splitSize) {
		super();
		this.outputFile = outputFile;
		this.outputFilesPrefix = outputFilesPrefix;
		this.inputFile = inputFile;
		this.splitType = splitType;
		this.splitPageNumbers = splitPageNumbers;
		this.splitSize = splitSize;
	}
	
	public SplitParsedCommand(File outputFile, String outputFilesPrefix, PdfFile inputFile,
			String splitType, Integer[] splitPageNumbers, Long splitSize, boolean overwrite, boolean compress, File logFile, char outputPdfVersion) {
		super(overwrite, compress, logFile, outputPdfVersion);
		this.outputFile = outputFile;
		this.outputFilesPrefix = outputFilesPrefix;
		this.inputFile = inputFile;
		this.splitType = splitType;
		this.splitPageNumbers = splitPageNumbers;
		this.splitSize = splitSize;

	}
	
	/**
	 * @return the outputFilesPrefix
	 */
	public String getOutputFilesPrefix() {
		return outputFilesPrefix;
	}

	/**
	 * @param outputFilesPrefix the outputFilesPrefix to set
	 */
	public void setOutputFilesPrefix(String outputFilesPrefix) {
		this.outputFilesPrefix = outputFilesPrefix;
	}

	/**
	 * @return the inputFile
	 */
	public PdfFile getInputFile() {
		return inputFile;
	}

	/**
	 * @param inputFile the inputFile to set
	 */
	public void setInputFile(PdfFile inputFile) {
		this.inputFile = inputFile;
	}

	/**
	 * @return the splitType
	 */
	public String getSplitType() {
		return splitType;
	}

	/**
	 * @param splitType the splitType to set
	 */
	public void setSplitType(String splitType) {
		this.splitType = splitType;
	}

	/**
	 * @return the splitPageNumbers
	 */
	public Integer[] getSplitPageNumbers() {
		return splitPageNumbers;
	}

	/**
	 * @param splitPageNumbers the splitPageNumbers to set
	 */
	public void setSplitPageNumbers(Integer[] splitPageNumbers) {
		this.splitPageNumbers = splitPageNumbers;
	}

	/**
	 * @return the outputFile
	 */
	public File getOutputFile() {
		return outputFile;
	}

	/**
	 * @param outputFile the outputFile to set
	 */
	public void setOutputFile(File outputFile) {
		this.outputFile = outputFile;
	}

	/**
	 * @return the splitSize
	 */
	public Long getSplitSize() {
		return splitSize;
	}

	/**
	 * @param splitSize the splitSize to set
	 */
	public void setSplitSize(Long splitSize) {
		this.splitSize = splitSize;
	}

	public String getCommand() {
		return COMMAND_SPLIT;
	}
	
	public String toString(){
		StringBuffer retVal = new StringBuffer();
		retVal.append(super.toString());
		retVal.append((outputFile== null)?"":"[outputDir="+outputFile.getAbsolutePath()+"]");
		retVal.append((inputFile== null)?"":"[inputFile="+inputFile+"]");
		retVal.append("[pageSelection="+outputFilesPrefix+"]");
		retVal.append("[splitType="+splitType+"]");
		retVal.append("[splitSize="+splitSize+"]");
		if(splitPageNumbers != null){
			for(int i = 0; i<splitPageNumbers.length; i++){
				retVal.append("[splitPageNumbers["+i+"]="+splitPageNumbers[i]+"]");				
			}
		}
		retVal.append("[command="+getCommand()+"]");
		return retVal.toString();
	}
}
