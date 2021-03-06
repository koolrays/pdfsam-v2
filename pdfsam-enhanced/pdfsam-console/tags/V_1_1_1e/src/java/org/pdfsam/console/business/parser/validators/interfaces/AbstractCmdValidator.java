/*
 * Created on 16-Oct-2007
 * Copyright (C) 2007 by Andrea Vacondio.
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
package org.pdfsam.console.business.parser.validators.interfaces;

import jcmdline.BooleanParam;
import jcmdline.CmdLineHandler;
import jcmdline.FileParam;
import jcmdline.StringParam;

import org.pdfsam.console.business.dto.commands.AbstractParsedCommand;
import org.pdfsam.console.exceptions.console.ConsoleException;
/**
 * Abstract command validator
 * @author Andrea Vacondio
 *
 */
public abstract class  AbstractCmdValidator implements CmdValidator{

	public AbstractParsedCommand validate(CmdLineHandler cmdLineHandler)
			throws ConsoleException {
		AbstractParsedCommand parsedCommand = validateArguments(cmdLineHandler);
		parsedCommand.setOverwrite(((BooleanParam) cmdLineHandler.getOption("overwrite")).isTrue());
		parsedCommand.setCompress(((BooleanParam) cmdLineHandler.getOption("compressed")).isTrue());
        FileParam logOption = (FileParam) cmdLineHandler.getOption("log");
        if (logOption.isSet()){
        	parsedCommand.setLogFile(logOption.getFile());
        }
        StringParam pdfversionOption = (StringParam) cmdLineHandler.getOption("pdfversion");
        if (pdfversionOption.isSet()){
        	parsedCommand.setOutputPdfVersion(pdfversionOption.getValue().charAt(0));
        }
		return parsedCommand;
	}

	/**
	 * Perform validation for the specific CmdHandler
	 * @param cmdLineHandler
	 * @return the parsed command
	 * @throws ConsoleException
	 */
	protected abstract AbstractParsedCommand validateArguments(CmdLineHandler cmdLineHandler)
			throws ConsoleException ;

}
