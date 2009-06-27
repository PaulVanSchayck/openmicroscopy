/*
 * org.openmicroscopy.shoola.agents.metadata.editor.ChannelAcquisitionComponent 
 *
 *------------------------------------------------------------------------------
 *  Copyright (C) 2006-2008 University of Dundee. All rights reserved.
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
package org.openmicroscopy.shoola.agents.metadata.editor;


//Java imports
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import javax.swing.BorderFactory;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;


//Third-party libraries
import org.jdesktop.swingx.JXTaskPane;

//Application-internal dependencies
import omero.model.AcquisitionMode;
import omero.model.ContrastMethod;
import omero.model.Illumination;
import omero.model.PlaneInfo;
import org.openmicroscopy.shoola.agents.util.DataComponent;
import org.openmicroscopy.shoola.agents.util.EditorUtil;
import org.openmicroscopy.shoola.env.data.model.EnumerationObject;
import org.openmicroscopy.shoola.util.ui.JLabelButton;
import org.openmicroscopy.shoola.util.ui.NumericalTextField;
import org.openmicroscopy.shoola.util.ui.OMEComboBox;
import org.openmicroscopy.shoola.util.ui.OMETextArea;
import org.openmicroscopy.shoola.util.ui.UIUtilities;
import pojos.ChannelAcquisitionData;
import pojos.ChannelData;

/** 
 * Displays the metadata related to the channel.
 *
 * @author  Jean-Marie Burel &nbsp;&nbsp;&nbsp;&nbsp;
 * <a href="mailto:j.burel@dundee.ac.uk">j.burel@dundee.ac.uk</a>
 * @author Donald MacDonald &nbsp;&nbsp;&nbsp;&nbsp;
 * <a href="mailto:donald@lifesci.dundee.ac.uk">donald@lifesci.dundee.ac.uk</a>
 * @version 3.0
 * <small>
 * (<b>Internal version:</b> $Revision: $Date: $)
 * </small>
 * @since 3.0-Beta4
 */
class ChannelAcquisitionComponent
	extends JPanel
	implements PropertyChangeListener
{

	/** Action ID to show or hide the unset general data. */
	private static final int	GENERAL = 0;
	
	/** Reference to the parent of this component. */
	private AcquisitionDataUI					parent;
	
	/** The channel data. */
	private ChannelData 						channel;
	
	/** The component displaying the illumination's options. */
	private OMEComboBox							illuminationBox;
	
	/** The component displaying the contrast Method options. */
	private OMEComboBox							contrastMethodBox;
	
	/** The component displaying the contrast Method options. */
	private OMEComboBox							modeBox;
	
	/** The fields displaying the metadata. */
	private Map<String, DataComponent> 			fieldsGeneral;
	
	/** The UI component hosting the lightSource metadata. */
	private LightSourceComponent				lightPane;
	
	/** The UI component hosting the detector metadata. */
	private DetectorComponent					detectorPane;
	
	/** Button to show or hides the unset fields of the detector. */
	private JLabelButton						unsetGeneral;
	
	/** Flag indicating the unset fields for the general are displayed. */
	private boolean								unsetGeneralShown;
	
	/** The UI component hosting the general metadata. */
	private JPanel								generalPane;
	
	/** Flag indicating if the components have been initialized. */
	private boolean								init;
	
	/** Reference to the Model. */
	private EditorModel							model;

	/** The component hosting the exposure time. */
	private JXTaskPane							exposureTask;
	
	/** Resets the various boxes with enumerations. */
	private void resetBoxes()
	{
		List<EnumerationObject> l; 
		l = model.getChannelEnumerations(Editor.ILLUMINATION_TYPE);
		EnumerationObject[] array = new EnumerationObject[l.size()+1];
		Iterator<EnumerationObject> j = l.iterator();
		int i = 0;
		while (j.hasNext()) {
			array[i] = j.next();
			i++;
		}
		array[i] = new EnumerationObject(AnnotationDataUI.NO_SET_TEXT);
		illuminationBox = EditorUtil.createComboBox(array);
		
		l = model.getChannelEnumerations(Editor.CONTRAST_METHOD);
		array = new EnumerationObject[l.size()+1];
		j = l.iterator();
		i = 0;
		while (j.hasNext()) {
			array[i] = j.next();
			i++;
		}
		array[i] = new EnumerationObject(AnnotationDataUI.NO_SET_TEXT);
		contrastMethodBox = EditorUtil.createComboBox(array);
		
		l = model.getChannelEnumerations(Editor.MODE);
		array = new EnumerationObject[l.size()+1];
		j = l.iterator();
		i = 0;
		while (j.hasNext()) {
			array[i] = j.next();
			i++;
		}
		array[i] = new EnumerationObject(AnnotationDataUI.NO_SET_TEXT);
		modeBox = EditorUtil.createComboBox(array);
		
		l = model.getChannelEnumerations(Editor.BINNING);
		array = new EnumerationObject[l.size()+1];
		j = l.iterator();
		i = 0;
		while (j.hasNext()) {
			array[i] = j.next();
			i++;
		}
		array[i] = new EnumerationObject(AnnotationDataUI.NO_SET_TEXT);
	}
	
	/** Initializes the components */
	private void initComponents()
	{
		resetBoxes();
		fieldsGeneral = new LinkedHashMap<String, DataComponent>();

		detectorPane = new DetectorComponent(parent, model);
		lightPane = new LightSourceComponent(parent, model);
		unsetGeneral = null;
		unsetGeneralShown = false;
		generalPane = new JPanel();
		generalPane.setBorder(BorderFactory.createTitledBorder("Info"));
		generalPane.setBackground(UIUtilities.BACKGROUND_COLOR);
		generalPane.setLayout(new GridBagLayout());
		exposureTask = EditorUtil.createTaskPane("Exposure Time");
		exposureTask.addPropertyChangeListener(this);
	}
	
	/** Shows or hides the unset fields. */
	private void displayUnsetGeneralFields()
	{
		unsetGeneralShown = !unsetGeneralShown;
		String s = AcquisitionDataUI.SHOW_UNSET;
		if (unsetGeneralShown) s = AcquisitionDataUI.HIDE_UNSET;
		unsetGeneral.setText(s);
		parent.layoutFields(generalPane, unsetGeneral, fieldsGeneral, 
				unsetGeneralShown);
	}
	
	/**
	 * Transforms the detector metadata.
	 * 
	 * @param details The value to transform.
	 */
	private void transformGeneralSource(Map<String, Object> details)
	{
		DataComponent comp;
		JLabel label;
		JComponent area;
		String key;
		Object value;
		label = new JLabel();
		Font font = label.getFont();
		int sizeLabel = font.getSize()-2;
		Object selected;
		List notSet = (List) details.get(EditorUtil.NOT_SET);
		details.remove(EditorUtil.NOT_SET);
		if (notSet.size() > 0 && unsetGeneral == null) {
			unsetGeneral = parent.formatUnsetFieldsControl();
			unsetGeneral.setActionID(GENERAL);
			unsetGeneral.addPropertyChangeListener(this);
		}

		Set entrySet = details.entrySet();
		Entry entry;
		Iterator i = entrySet.iterator();
		boolean set;
		while (i.hasNext()) {
			entry = (Entry) i.next();
            key = (String) entry.getKey();
            set = !notSet.contains(key);
            value = entry.getValue();
            label = UIUtilities.setTextFont(key, Font.BOLD, sizeLabel);
            label.setBackground(UIUtilities.BACKGROUND_COLOR);
            if (EditorUtil.ILLUMINATION.equals(key)) {
            	selected = model.getChannelEnumerationSelected(
            			Editor.ILLUMINATION_TYPE, 
            			(String) value);
            	if (selected != null) illuminationBox.setSelectedItem(selected);
            	else {
            		set = false;
            		illuminationBox.setSelectedIndex(
            				illuminationBox.getItemCount()-1);
            	}
            			
            	illuminationBox.setEditedColor(UIUtilities.EDITED_COLOR);
            	area = illuminationBox;
            } else if (EditorUtil.CONTRAST_METHOD.equals(key)) {
            	selected = model.getChannelEnumerationSelected(
            			Editor.ILLUMINATION_TYPE, 
            			(String) value);
            	if (selected != null) 
            		contrastMethodBox.setSelectedItem(selected);
            	else {
            		set = false;
            		contrastMethodBox.setSelectedIndex(
            				contrastMethodBox.getItemCount()-1);
            	}
            			
            	contrastMethodBox.setEditedColor(UIUtilities.EDITED_COLOR);
            	area = contrastMethodBox;
            } else if (EditorUtil.MODE.equals(key)) {
            	selected = model.getChannelEnumerationSelected(Editor.MODE, 
            			(String) value);
            	if (selected != null) modeBox.setSelectedItem(selected);
            	else {
            		set = false;
            		modeBox.setSelectedIndex(modeBox.getItemCount()-1);
            	}
            	modeBox.setEditedColor(UIUtilities.EDITED_COLOR);
            	area = modeBox;
            } else {
            	if (value instanceof Number) {
            		area = UIUtilities.createComponent(
             				 NumericalTextField.class, null);
            		if (value instanceof Double) 
                		((NumericalTextField) area).setNumberType(Double.class);
                	else if (value instanceof Float) 
            			((NumericalTextField) area).setNumberType(Float.class);
             		 ((NumericalTextField) area).setText(""+value);
             		((NumericalTextField) area).setEditedColor(
             				UIUtilities.EDITED_COLOR);
            	} else {
            		area = UIUtilities.createComponent(OMETextArea.class, null);
                	if (value == null || value.equals("")) {
                		set = false;
                		value = AnnotationUI.DEFAULT_TEXT;
                	}
                	((OMETextArea) area).setEditable(false);
                	((OMETextArea) area).setText((String) value);
                	((OMETextArea) area).setEditedColor(
                			UIUtilities.EDITED_COLOR);
            	}
            }
            area.setEnabled(!set);
            comp = new DataComponent(label, area);
            comp.setEnabled(false);
			comp.setSetField(!notSet.contains(key));
			fieldsGeneral.put(key, comp);
        }
	}
	
    /** Builds and lays out the UI. */
    private void buildGUI()
    {
    	setBackground(UIUtilities.BACKGROUND_COLOR);
		parent.layoutFields(generalPane, unsetGeneral, fieldsGeneral, 
				unsetGeneralShown);
		
		setLayout(new GridBagLayout());
		GridBagConstraints constraints = new GridBagConstraints();
		constraints.fill = GridBagConstraints.BOTH;
		constraints.anchor = GridBagConstraints.WEST;
		constraints.insets = new Insets(0, 2, 2, 0);
		constraints.weightx = 1.0;
		constraints.gridy = 0;
		add(generalPane, constraints);
		++constraints.gridy;
    	add(detectorPane, constraints);
    	++constraints.gridy;
    	add(lightPane, constraints);
    	++constraints.gridy;
    	constraints.fill = GridBagConstraints.HORIZONTAL;
    	add(exposureTask, constraints);
    	parent.attachListener(fieldsGeneral);
    }
	
	/**
	 * Creates a new instance.
	 * 
	 * @param parent	Reference to the Parent. Mustn't be <code>null</code>.
	 * @param model		Reference to the Model. Mustn't be <code>null</code>.
	 * @param channel 	The channel to display. Mustn't be <code>null</code>.
	 */
	ChannelAcquisitionComponent(AcquisitionDataUI parent, 
			EditorModel model, ChannelData channel)
	{
		if (model == null)
			throw new IllegalArgumentException("No model.");
		if (parent == null)
			throw new IllegalArgumentException("No parent.");
		if (channel == null)
			throw new IllegalArgumentException("No channel.");
		this.model = model;
		this.channel = channel;
		this.parent = parent;
		initComponents();
	}
	
	/**
	 * Displays the acquisition data for the passed channel.
	 * 
	 * @param index The index of the channel.
	 */
	void setChannelAcquisitionData(int index)
	{
		if (channel.getIndex() != index) return;
		if (!init) {
			init = true;
			resetBoxes();
			removeAll();
	    	fieldsGeneral.clear();
	    	
			transformGeneralSource(EditorUtil.transformChannelData(channel));
			ChannelAcquisitionData data = model.getChannelAcquisitionData(
	    			channel.getIndex());
			detectorPane.displayDetector(EditorUtil.transformDetector(data));
			
			Map<String, Object> details = EditorUtil.transformLightSource(null, 
					data);
			String kind = (String) details.get(EditorUtil.LIGHT_TYPE);
			details.remove(EditorUtil.LIGHT_TYPE);
			lightPane.displayLightSource(kind, details);
			buildGUI();
		}
	}

	/**
	 * Sets the plane info for the specified channel.
	 * 
	 * @param index  The index of the channel.
	 */
	void setPlaneInfo(int index)
	{
		if (channel.getIndex() != index) return;
		Collection result = model.getChannelPlaneInfo(index);
		String[][] values = new String[1][result.size()];
		String[] names = new String[result.size()];
		int i = 0;
		Iterator j = result.iterator();
		PlaneInfo info;
		Map<String, Object> details;
		while (j.hasNext()) {
			info = (PlaneInfo) j.next();
			details = EditorUtil.transformPlaneInfo(info);
			values[0][i] = details.get(EditorUtil.EXPOSURE_TIME)+"s";
			names[i] = "t="+(i+1);
			i++;
		}
		JTable table = new JTable(values, names);
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		table.setShowGrid(true);
		table.setGridColor(Color.LIGHT_GRAY);
		JScrollPane pane = new JScrollPane(table);
		Dimension d = table.getPreferredSize();
		Dimension de = exposureTask.getPreferredSize();
		pane.setPreferredSize(
			new Dimension(de.width-10, 4*d.height));
		exposureTask.add(pane);
	}
	
	/**
	 * Returns <code>true</code> if data to save, <code>false</code>
	 * otherwise.
	 * 
	 * @return See above.
	 */
	boolean hasDataToSave()
	{
		boolean b = parent.hasDataToSave(fieldsGeneral);
		if (b) return true;
		b = detectorPane.hasDataToSave();
		if (b) return true;
		b = lightPane.hasDataToSave();
		if (b) return true;
		return false;
	}

	/**
	 * Prepares the data to save.
	 * 
	 * @return See above.
	 */
	List<Object> prepareDataToSave()
	{
		List<Object> data = new ArrayList<Object>();
		if (!hasDataToSave()) return data;
		String key;
		DataComponent comp;
		Object value;
		EnumerationObject enumObject;
		Number number;
		Iterator i; 
		Entry entry;
		if (channel.isDirty()) {
			i = fieldsGeneral.entrySet().iterator();
			while (i.hasNext()) {
				entry = (Entry) i.next();
				key = (String) entry.getKey();
				comp = (DataComponent) entry.getValue();
				if (comp.isDirty()) {
					value = comp.getAreaValue();
					if (EditorUtil.NAME.equals(key)) {
						channel.setName((String) value);
					} else if (EditorUtil.PIN_HOLE_SIZE.equals(key)) {
						number = UIUtilities.extractNumber((String) value, 
								Float.class);
						if (number != null)
							channel.setPinholeSize((Float) number);
					} else if (EditorUtil.ND_FILTER.equals(key)) {
						number = UIUtilities.extractNumber((String) value, 
								Float.class);
						if (number != null)
							channel.setNDFilter((Float) number);
					} else if (EditorUtil.POCKEL_CELL.equals(key)) {
						number = UIUtilities.extractNumber((String) value, 
								Integer.class);
						if (number != null)
							channel.setPockelCell((Integer) value);
					} else if (EditorUtil.EMISSION.equals(key)) {
						number = UIUtilities.extractNumber((String) value, 
								Integer.class);
						if (number != null)
							channel.setEmissionWavelength((Integer) number);
					} else if (EditorUtil.EXCITATION.equals(key)) {
						number = UIUtilities.extractNumber((String) value, 
								Integer.class);
						if (number != null)
							channel.setExcitationWavelength((Integer) number);
					} else if (EditorUtil.ILLUMINATION.equals(key)) {
						enumObject = (EnumerationObject) value;
						if (enumObject.getObject() instanceof Illumination)
							channel.setIllumination(
								(Illumination) enumObject.getObject());
					} else if (EditorUtil.MODE.equals(key)) {
						enumObject = (EnumerationObject) value;
						if (enumObject.getObject() instanceof AcquisitionMode)
							channel.setMode(
								(AcquisitionMode) enumObject.getObject());
					} else if (EditorUtil.CONTRAST_METHOD.equals(key)) {
						enumObject = (EnumerationObject) value;
						if (enumObject.getObject() instanceof ContrastMethod)
							channel.setContrastMethod(
								(ContrastMethod) enumObject.getObject());
					}
				}
			}
			data.add(channel);
		}
		
		/*
		 ChannelAcquisitionData metadata = model.getChannelAcquisitionData(
    			channel.getIndex());
		i = fieldsDetector.entrySet().iterator();
		
		while (i.hasNext()) {
			entry = (Entry) i.next();
			key = (String) entry.getKey();
			comp = (DataComponent) entry.getValue();
			if (comp.isDirty()) {
				value = comp.getAreaValue();
				if (EditorUtil.MODEL.equals(key)) {
					metadata.setDetectorModel((String) value);
				} else if (EditorUtil.MANUFACTURER.equals(key)) {
					metadata.setDetectorManufacturer((String) value);
				} else if (EditorUtil.SERIAL_NUMBER.equals(key)) {
					metadata.setDetectorSerialNumber((String) value);
				} else if (EditorUtil.GAIN.equals(key)) {
					//metadata.setPockelCell((Integer) value);
				} else if (EditorUtil.VOLTAGE.equals(key)) {
					//metadata.setEmissionWavelength((Integer) value);
				} else if (EditorUtil.OFFSET.equals(key)) {
					//channel.setExcitationWavelength((Integer) value);
				} else if (EditorUtil.READ_OUT_RATE.equals(key)) {
					//	channel.setExcitationWavelength((Integer) value);
				} else if (EditorUtil.ZOOM.equals(key)) {
					number = UIUtilities.extractNumber((String) value, 
							Float.class);
					if (number != null)
						metadata.setDetectorZoom((Float) number);
				} else if (EditorUtil.AMPLIFICATION.equals(key)) {
					number = UIUtilities.extractNumber((String) value, 
							Float.class);
					if (number != null)
						metadata.setDetectorAmplificationGain((Float) number);
				}
			}
			data.add(metadata);
		}
		*/
		return data;
	}

	/**
	 * Reacts to property fired by the <code>JLabelButton</code>.
	 * @see PropertyChangeListener#propertyChange(PropertyChangeEvent)
	 */
	public void propertyChange(PropertyChangeEvent evt)
	{
		String name = evt.getPropertyName();
		if (JLabelButton.SELECTED_PROPERTY.equals(name)) {
			displayUnsetGeneralFields();
		} else if (UIUtilities.COLLAPSED_PROPERTY_JXTASKPANE.equals(name)) {
			parent.loadPlaneInfo(channel.getIndex());
		}
	}

}
