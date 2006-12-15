/*
 * org.openmicroscopy.shoola.agents.imviewer.actions.ViewerAction
 *
 *------------------------------------------------------------------------------
 *  Copyright (C) 2006 University of Dundee. All rights reserved.
 *
 *
 * 	This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 *------------------------------------------------------------------------------
 */

package org.openmicroscopy.shoola.agents.imviewer.actions;




//Java imports
import java.awt.event.ActionEvent;
import javax.swing.AbstractAction;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

//Third-party libraries

//Application-internal dependencies
import org.openmicroscopy.shoola.agents.imviewer.view.ImViewer;

/** 
 * Top class that each action should extend.
 *
 * @author  Jean-Marie Burel &nbsp;&nbsp;&nbsp;&nbsp;
 * 				<a href="mailto:j.burel@dundee.ac.uk">j.burel@dundee.ac.uk</a>
 * @author	Andrea Falconi &nbsp;&nbsp;&nbsp;&nbsp;
 * 				<a href="mailto:a.falconi@dundee.ac.uk">a.falconi@dundee.ac.uk</a>
 * @author	Donald MacDonald &nbsp;&nbsp;&nbsp;&nbsp;
 * 				<a href="mailto:donald@lifesci.dundee.ac.uk">donald@lifesci.dundee.ac.uk</a>
 * @version 3.0
 * <small>
 * (<b>Internal version:</b> $Revision: $ $Date: $)
 * </small>
 * @since OME2.2
 */
public class ViewerAction
    extends AbstractAction
    implements ChangeListener
{

    /** The Model. */
    protected ImViewer  model;
   
    /** The name of the action. */
    private String      name;
    
    /**
     * Subclasses can override the method if necessary.
     * 
     * @param e The event to handle.
     */
    protected void onStateChange(ChangeEvent e) {}
    
    /**
     * Creates a new instance.
     * 
     * @param model The model. Mustn't be <code>null</code>.
     */
    ViewerAction(ImViewer model)
    {
        this(model, null);
    }
    
    /**
     * Creates a new instance.
     * 
     * @param model The model. Mustn't be <code>null</code>.
     * @param name  The name of the action.
     */
    ViewerAction(ImViewer model, String name)
    {
        super();
        if (model == null) throw new NullPointerException("No model.");
        this.model = model;
        this.name = name;
        model.addChangeListener(this);
    }
    
    /**
     * Sets the name of the action.
     * 
     * @param name The action's name.
     */
    void setName(String name) { this.name = name; }
    
    /**
     * Returns the name of the action.
     * 
     * @return See above.
     */
    public String getName() { return name; }
    
    /** 
     * Reacts to state changes in the {@link ImViewer}.
     * @see ChangeListener#stateChanged(ChangeEvent)
     */
    public void stateChanged(ChangeEvent e)
    {
        if (model.getState()  == ImViewer.READY) {
            setEnabled(!(model.getHistoryState() == ImViewer.CHANNEL_MOVIE)); 
        } else setEnabled(false); 
        onStateChange(e);
    }

    /** 
     * Implemented by sub-classes.
     * @see java.awt.event.ActionListener#actionPerformed(ActionEvent)
     */
    public void actionPerformed(ActionEvent e) {}
    
    /**
     * Overridden to return the name of the action.
     * @see java.lang.Object#toString()
     */
    public String toString() { return getName(); }

}
