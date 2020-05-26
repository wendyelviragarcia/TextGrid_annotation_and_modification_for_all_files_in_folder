##########################################

#####################	FORMULARIO	#######################
form Indica el directorio

comment Directorio donde están los Textgrids:
sentence folder /Users/Wen/Desktop/praat
comment ¿Quieres borrar tiers?
boolean remove_tier 0
comment ¿Qué número de tier quieres borrar (posición del tier)?
integer tier_number_to_be_removed 0
comment ¿Quieres añadir point tiers?
boolean point_tier 1
integer posicion_point_tier 2
word nombre_point_tier_2 BI
word nombre_point_tier_3 Tones
comment ¿Quieres añadir interval tiers?
boolean interval_tier 0
word nombre_interval_tier XX
integer posicion_interval_tier 1 (=on top)
boolean guardar_la_lista_de_archivos_modificados 1

endform
##########################################
if windows = 1
	barra$ = "\"
else
	barra$= "/"
endif

Create Strings as file list... lista 'folder$'/*.TextGrid
if guardar_la_lista_de_archivos_modificados
	Save as raw text file: "'folder$''barra$'lista.txt"
endif

numberOfFiles = Get number of strings
for ifile from 10 to numberOfFiles
	echo Modificando el TextGrid 'ifile' de 'numberOfFiles'
	select Strings lista
	nombreArchivo$ = Get string... ifile
	nombreObjeto$ = nombreArchivo$ - ".TextGrid"

	do ("Read from file...", "'folder$'/'nombreArchivo$'")
	select TextGrid 'nombreObjeto$'
	if remove_tier = 1
		Remove tier... 'tier_number_to_be_removed'
	endif
	
	if point_tier = 1
		do ("Insert point tier...", posicion_point_tier, "'nombre_point_tier_2$'")
		do ("Insert point tier...", posicion_point_tier, "'nombre_point_tier_3$'")
	endif
	if interval_tier = 1
		do ("Insert interval tier...", posicion_interval_tier, "'nombre_interval_tier$'")
	endif
	
	do ("Save as text file...", "'folder$'/'nombreArchivo$'")
	
select all
minus Strings lista
Remove

endfor
select all
Remove

