/*
 * org.openmicroscopy.shoola.agents.hiviewer.DatasetAnnotationLoader
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

package org.openmicroscopy.shoola.agents.hiviewer;

//Java imports
import java.util.Map;

//Third-party libraries

//Application-internal dependencies
import org.openmicroscopy.shoola.agents.hiviewer.clipboard.ClipBoard;
import org.openmicroscopy.shoola.env.data.views.CallHandle;
import pojos.DatasetData;

/** 
 * Loads, asynchronously, the annotation linked to the specified dataset.
 * This class calls the <code>loadAnnotations</code> method in the
 * <code>HierarchyBrowsingView</code>.
 * 
 * @author  Jean-Marie Burel &nbsp;&nbsp;&nbsp;&nbsp;
 * 				<a href="mailto:j.burel@dundee.ac.uk">j.burel@dundee.ac.uk</a>
 * @author  <br>Andrea Falconi &nbsp;&nbsp;&nbsp;&nbsp;
 *              <a href="mailto:a.falconi@dundee.ac.uk">
 *                  a.falconi@dundee.ac.uk</a>
 * @version 2.2
 * <small>
 * (<b>Internal version:</b> $Revision$ $Date$)
 * </small>
 * @since OME2.2
 */
public class DatasetAnnotationLoader
    extends CBDataLoader
{

    /** The id of the dataset. */
    private long        datasetID;
    
    /** Handle to the async call so that we can cancel it. */
    private CallHandle  handle;
    
    /**
     * Creates a new instance.
     * 
     * @param clipBoard The {@link ClipBoard} this data loader is for.
     *                   Mustn't be <code>null</code>.
     * @param datasetID The id of the dataset.
     */
    public DatasetAnnotationLoader(ClipBoard clipBoard, long datasetID)
    {
        super(clipBoard);
        this.datasetID = datasetID;
    }
    
    /** 
     * Retrieves all the annotations linked to the specified dataset. 
     * @see CBDataLoader#load()
     */
    public void load()
    {
        handle = hiBrwView.loadAnnotations(DatasetData.class, datasetID, this);
    }

    /** 
     * Cancels the data loading. 
     * @see CBDataLoader#cancel()
     */
    public void cancel() { handle.cancel(); }
    
    /**
     * Feeds the result back to the viewer.
     * @see CBDataLoader#handleResult(Object)
     */
    public void handleResult(Object result) 
    {
        clipBoard.setAnnotations((Map) result);
    }
    
    /**
     * Overridden so that we don't notify the user that the annotation
     * retrieval has been cancelled.
     * @see CBDataLoader#handleCancellation() 
     */
    public void handleCancellation() 
    {
        String info = "The data retrieval has been cancelled.";
        registry.getLogger().info(this, info);
    }
    
}
