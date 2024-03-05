#####################	INSTRUCTIONS	#######################
#	remove-tier.praat
#	
#	This script runs through all the Textgrids in a folder and removes the X  tier of the TextGrid.
#							INSTRUCTIONS
#				0) You'll need a folder with the TextGrids.
# 				1) Open the script with Praat (Read from file...), the script will open. In the upper menu select Run and Run again.
# 				2) Write the folder and the number of tier you want to remove.
#
#	comments are always welcome 
#	Wendy Elvira-García
#	Free script under a GNU General Public License contract. 
#	wendyelviragarcia @ u b . e d u
#	Retrieved from https://www.ub.edu/phoneticslaboratory/
# 	https://github.com/wendyelviragarcia
#	Laboratori de Fonètica (University of Barcelona)
#####################	FORMULARIO	#######################
form Remove tier
comment PLEASE MAKE A COPY OF YOUR DATA BEFORE 
comment RUNNING THIS SCRIPT!!!!
comment __
comment Folder where your textgrids are:
sentence directoriomater /Users/Wen/Desktop/praat
comment Folder where the textgrids will be saved:
sentence output_folder /Users/Wen/Desktop/output
comment Which tier do you want removed (top to bottom order)?
integer number_of_tier 5 

endform
##########################################


Create Strings as file list... lista 'directoriomater$'/*.TextGrid


numberOfFiles = Get number of strings
pause Tier 'number_of_tier' will be removed in 'numberOfFiles' files.

for ifile to numberOfFiles
	echo Modificando el TextGrid 'ifile' de 'numberOfFiles'
	select Strings lista
	nombreArchivo$ = Get string: ifile
	nombreObjeto$ = nombreArchivo$ - ".TextGrid"

	do ("Read from file...", "'directoriomater$'/'nombreArchivo$'")
	select TextGrid 'nombreObjeto$'
	
		
			nowarn Remove tier: number_of_tier 
		
	
	do ("Save as text file...", "'output_folder$'/'nombreArchivo$'")
	
select all
minus Strings lista
Remove

endfor
select all
Remove

echo Tier 'remove_tiers_from' and those below have been removed in 'numberOfFiles' files.

