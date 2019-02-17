#####################	INSTRUCCIONES	#######################
#	remove-tiers.praat
#	
#	This script runs through all the Textgrids in a folder and removes the X last tiers of the TextGrid.
#							INSTRUCTIONS
#				0) You'll need a folder with the TextGrids.
# 				1) Open the script with Praat (Read from file...), the script will open. In the upper menu select Run and Run again.
# 				2) Write the folder and the number of tier you want to remove.
#
#	comments are always welcome 
#	Wendy Elvira-Garcia
#	Free script under a GNU General Public License contract. 
#	wendyelviragarcia @ g m a i l . c o m
#	Retrieved from http://stel.ub.edu/labfon/en/praat-scripts
#	Laboratori de Fonètica (University of Barcelona)
#####################	FORMULARIO	#######################
form Folder

comment Directorio donde están los Textgrids:
sentence directoriomater /Users/Wen/Desktop/praat
comment Do you want to remove tiers?
boolean remove_tier 1
comment All the tiers from the number specified will be removed (included)
integer remove_tiers_from 2


endform
##########################################


Create Strings as file list... lista 'directoriomater$'/*.TextGrid


numberOfFiles = Get number of strings
for ifile from 1 to numberOfFiles
	echo Modificando el TextGrid 'ifile' de 'numberOfFiles'
	select Strings lista
	nombreArchivo$ = Get string: ifile
	nombreObjeto$ = nombreArchivo$ - ".TextGrid"

	do ("Read from file...", "'directoriomater$'/'nombreArchivo$'")
	select TextGrid 'nombreObjeto$'
	if remove_tier = 1
		numberOfTiers = Get number of tiers
		for tier from remove_tiers_from to numberOfTiers
			Remove tier: tier
		endfor
	endif
	
	
	
	do ("Save as text file...", "'directoriomater$'/'nombreArchivo$'")
	
select all
minus Strings lista
Remove

endfor
select all
Remove

echo Tier 'remove_tiers_from' and those below have been removed in 'numberOfFiles' files.

