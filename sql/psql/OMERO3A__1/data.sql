--
-- Copyright 2008 Glencoe Software, Inc. All rights reserved.
-- Use is subject to license terms supplied in LICENSE.txt
--

--
-- This file was generated by dsl/resources/ome/dsl/data.vm
--

begin;
set constraints all deferred;

--
-- First, we install a unique constraint so that it is only possible
-- to go from versionA/patchA to versionB/patchB once.
--
alter table dbpatch add constraint unique_dbpatch unique (currentVersion, currentPatch, previousVersion, previousPatch);

--
-- Since this is a table that we will be using in DB-specific ways, we're also going
-- to make working with it a bit simpler.
--
alter table dbpatch alter id set default nextval('seq_dbpatch');
alter table dbpatch alter permissions set default -35;
alter table dbpatch alter message set default 'Updating';

--
-- Then, we insert into the patch table the patch (initialization) which we are currently
-- running so that if anything goes wrong, we'll have some record. 
--
insert into dbpatch (currentVersion, currentPatch, previousVersion, previousPatch, message) 
             values ('OMERO3A',  1,    'OMERO3A',   0,             'Initializing');

--
-- Here we will create the root account and the necessary groups
--
insert into experimenter (id,permissions,version,omename,firstname,lastname)
        values (0,0,0,'root','root','root');
insert into event (id,permissions,time,status,experimenter) values (0,0,now(),'BOOTSTRAP',0);
insert into experimentergroup (id,permissions,version,owner_id,group_id,creation_id,update_id,name)
        values (0,-35,0,0,0,0,0,'system');
insert into experimentergroup (id,permissions,version,owner_id,group_id,creation_id,update_id,name)
        values (nextval('seq_experimentergroup'),-35,0,0,0,0,0,'user');
insert into experimentergroup (id,permissions,version,owner_id,group_id,creation_id,update_id,name)
        values (nextval('seq_experimentergroup'),-35,0,0,0,0,0,'default');
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value) values
        (0,-35,0,0,0,'Bootstrap');
insert into groupexperimentermap 
        (id,permissions,version,owner_id,group_id,creation_id,update_id, parent, child, child_index)
        values
        (0,-35,0,0,0,0,0,0,0,0);
insert into groupexperimentermap 
        (id,permissions,version,owner_id,group_id,creation_id,update_id, parent, child, child_index)
        select nextval('seq_groupexperimentermap'),-35,0,0,0,0,0,1,0,1;


update event set type = 0;
update event set experimentergroup = 0;

alter table event alter column type set not null;
alter table event alter column experimentergroup set not null;


insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Oil';
insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Oel';
insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Water';
insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Wasser';
insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Hl';
insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Gly';
insert into immersion (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_immersion'),-35,0,0,0,'Wl';
insert into arctype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_arctype'),-35,0,0,0,'Hg';
insert into arctype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_arctype'),-35,0,0,0,'Xe';
insert into arctype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_arctype'),-35,0,0,0,'Hg-Xe';
insert into arctype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_arctype'),-35,0,0,0,'Other';
insert into renderingmodel (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_renderingmodel'),-35,0,0,0,'rgb';
insert into renderingmodel (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_renderingmodel'),-35,0,0,0,'hsb';
insert into renderingmodel (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_renderingmodel'),-35,0,0,0,'greyscale';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'Wide-field';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'LaserScanningMicroscopy';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'LaserScanningConfocal';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'SpinningDiskConfocal';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'SlitScanConfocal';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'MultiPhotonMicroscopy';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'StructuredIllumination';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'SingleMoleculeImaging';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'TotalInternalReflection';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'FluorescenceLifetime';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'SpectralImaging';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'FluorescenceCorrelationSpectroscopy';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'NearFieldScanningOpticalMicroscopy';
insert into acquisitionmode (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_acquisitionmode'),-35,0,0,0,'SecondHarmonicGenerationImaging';
insert into binning (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_binning'),-35,0,0,0,'1x1';
insert into binning (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_binning'),-35,0,0,0,'2x2';
insert into binning (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_binning'),-35,0,0,0,'4x4';
insert into binning (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_binning'),-35,0,0,0,'8x8';
insert into family (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_family'),-35,0,0,0,'linear';
insert into family (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_family'),-35,0,0,0,'polynomial';
insert into family (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_family'),-35,0,0,0,'exponential';
insert into family (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_family'),-35,0,0,0,'logarithmic';
insert into medium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_medium'),-35,0,0,0,'Air';
insert into medium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_medium'),-35,0,0,0,'Oil';
insert into medium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_medium'),-35,0,0,0,'Water';
insert into medium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_medium'),-35,0,0,0,'Glycerol';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'int8';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'int16';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'int32';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'uint8';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'uint16';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'uint32';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'float';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'double';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'complex';
insert into pixelstype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pixelstype'),-35,0,0,0,'double-complex';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'DV';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'STK';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'TIFF';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'text/csv';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'text/plain';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'text/xml';
insert into format (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_format'),-35,0,0,0,'text/x-python';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'Excimer';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'Gas';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'MetalVapor';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'SolidState';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'Dye';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'Semiconductor';
insert into lasertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasertype'),-35,0,0,0,'FreeElectron';
insert into pulse (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pulse'),-35,0,0,0,'CW';
insert into pulse (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pulse'),-35,0,0,0,'Single';
insert into pulse (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pulse'),-35,0,0,0,'Q-Switched';
insert into pulse (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pulse'),-35,0,0,0,'Repetitive';
insert into pulse (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_pulse'),-35,0,0,0,'Mode-Locked';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Submitted';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Resubmitted';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Queued';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Requeued';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Running';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Error';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Waiting';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Finished';
insert into jobstatus (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_jobstatus'),-35,0,0,0,'Cancelled';
insert into coating (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_coating'),-35,0,0,0,'UV';
insert into coating (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_coating'),-35,0,0,0,'PlanApo';
insert into coating (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_coating'),-35,0,0,0,'PlanFluor';
insert into coating (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_coating'),-35,0,0,0,'SuperFluor';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'CCD';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'Intensified-CCD';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'Analog-Video';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'PMT';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'Photodiode';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'Spectroscopy';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'Life-time-Imaging';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'Correlation-Spectroscopy';
insert into detectortype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_detectortype'),-35,0,0,0,'FTIR';
insert into illumination (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_illumination'),-35,0,0,0,'Transmitted';
insert into illumination (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_illumination'),-35,0,0,0,'Epifluorescence';
insert into illumination (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_illumination'),-35,0,0,0,'Oblique';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Achro';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Achromat';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Fluor';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Fl';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Fluar';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Neofluar';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Fluotar';
insert into aberrationcorrection (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_aberrationcorrection'),-35,0,0,0,'Apo';
insert into photometricinterpretation (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_photometricinterpretation'),-35,0,0,0,'RGB';
insert into photometricinterpretation (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_photometricinterpretation'),-35,0,0,0,'ARGB';
insert into photometricinterpretation (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_photometricinterpretation'),-35,0,0,0,'CMYK';
insert into photometricinterpretation (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_photometricinterpretation'),-35,0,0,0,'HSV';
insert into photometricinterpretation (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_photometricinterpretation'),-35,0,0,0,'Monochrome';
insert into photometricinterpretation (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_photometricinterpretation'),-35,0,0,0,'ColorMap';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'Import';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'Internal';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'Shoola';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'User';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'Task';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'Test';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'Processing';
insert into eventtype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_eventtype'),-35,0,0,0,'FullText';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Rhodamine-5G';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Coumaring-C30';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'ArFl';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'ArCl';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'KrFl';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'KrCl';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'XeFl';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'XeCl';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'XeBr';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'GaAs';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'GaAlAs';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'e-';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Cu';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Ag';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'N';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Ar';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Kr';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'Xe';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'HeNe';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'HeCd';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'CO';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'CO2';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'H2O';
insert into lasermedium (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_lasermedium'),-35,0,0,0,'HFl';
insert into microscopetype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_microscopetype'),-35,0,0,0,'Upright';
insert into microscopetype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_microscopetype'),-35,0,0,0,'Inverted';
insert into microscopetype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_microscopetype'),-35,0,0,0,'Dissection';
insert into microscopetype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_microscopetype'),-35,0,0,0,'Electrophysiology';
insert into irisdiaphragm (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_irisdiaphragm'),-35,0,0,0,'I';
insert into irisdiaphragm (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_irisdiaphragm'),-35,0,0,0,'Iris';
insert into irisdiaphragm (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_irisdiaphragm'),-35,0,0,0,'W/Iris';
insert into dimensionorder (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_dimensionorder'),-35,0,0,0,'XYZCT';
insert into dimensionorder (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_dimensionorder'),-35,0,0,0,'XYZTC';
insert into dimensionorder (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_dimensionorder'),-35,0,0,0,'XYCTZ';
insert into dimensionorder (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_dimensionorder'),-35,0,0,0,'XYCZT';
insert into dimensionorder (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_dimensionorder'),-35,0,0,0,'XYTCZ';
insert into dimensionorder (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_dimensionorder'),-35,0,0,0,'XYTZC';
insert into frequencymultiplication (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_frequencymultiplication'),-35,0,0,0,'x1';
insert into frequencymultiplication (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_frequencymultiplication'),-35,0,0,0,'x2';
insert into frequencymultiplication (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_frequencymultiplication'),-35,0,0,0,'x3';
insert into frequencymultiplication (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_frequencymultiplication'),-35,0,0,0,'x4';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'FP';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'FRET';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Time-lapse';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'4-D+';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Screen';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Immunocytopchemistry';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Immunofluroescence';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'FISH';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Electropyhsiology';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Ion-Imaging';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Colocalization';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'PGI/Documentation';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'FRAP';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Photablation';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Photoactivation';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Uncaging';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Optical-Trapping';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Fluorescence-Lifetime';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Spectral-Imaging';
insert into experimenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_experimenttype'),-35,0,0,0,'Other';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'Brightfield';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'Phase';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'DIC';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'HoffmanModulation';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'ObliqueIllumination';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'PolarizedLight';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'Darkfield';
insert into contrastmethod (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_contrastmethod'),-35,0,0,0,'Fluorescence';
insert into filamenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_filamenttype'),-35,0,0,0,'Incandescent';
insert into filamenttype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_filamenttype'),-35,0,0,0,'Halogen';
insert into filtertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_filtertype'),-35,0,0,0,'LongPass';
insert into filtertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_filtertype'),-35,0,0,0,'ShortPass';
insert into filtertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_filtertype'),-35,0,0,0,'BandPass';
insert into filtertype (id,permissions,owner_id,group_id,creation_id,value)
    select nextval('seq_filtertype'),-35,0,0,0,'MultiPass';

create table configuration ( name varchar(255) primary key, value text );

create table password ( experimenter_id bigint unique not null REFERENCES experimenter (id) , hash char(24), dn text );
insert into password values (0,'@ROOTPASS@'); 
-- root can now login with omero.rootpass property value

-- Here we have finished initializing this database. 
update dbpatch set message = 'Database ready.', finished = now() 
  where currentVersion = 'OMERO3A' and 
        currentPatch = 1 and 
        previousVersion = 'OMERO3A' and 
        previousPatch = 0;

commit;
