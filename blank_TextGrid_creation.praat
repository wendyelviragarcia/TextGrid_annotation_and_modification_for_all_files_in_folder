#	blank-TextGrid-creation (v. 1.2 October 2017)
#
#							DESCRIPCIÓN
#	Este script abre uno a uno todos los ficheros .wav de una carpeta crea TextGrids para ellos de uno en uno, 
#	da la opción de modificarlos y los guarda.
#
#
#							INSTRUCCIONES
#
#	0. Para usar este script necesitas una serie de ficheros .wav.
#	1. Abre el script con Praat (Read from file...) y selecciona el script o simplemente arrastra el fichero al icono de Praat.
#	 
#	2. Se abrirá un formulario donde puedes:
#		poner el nombre de los tiers
# 		elegir si quieres empezar a trabajar con el archivo 1 de la lista 
#		o si, por el contrario, ya habías trabajado con esos archivos antes y sabes el número por el que te quedaste.
#		Clica OK.
#	3. Se abrirá una ventana donde se pregunta donde están tus archivos, selecciona la carpeta y clica "OK"
# 	
#	4. si has selccionado pausarlos: Se abrirán el sonido y el TextGrid juntos. Corrige lo que sea necesario y cuando acabes clica "Continue".
#	5. El TextGrid se guardará en la misma carpeta donde estaban los sonidos.
#		y se abrirá el archivo siguiente de la lista.
#
#	Wendy Elvira-García (2013). Blank-TextGrid-creation v.1. [praat script]
#	wendyelviragarcia @ g m a il . c o m
#	license: GNU 3
#	Laboratori de Fonètica (Universitat de Barcelona)
#
###########################################################################################

#check Praat version
if praatVersion < 5363
	exit This script works only in Praat  5363 or later
endif

form Creator
	# comment Pon la ruta de la carpeta donde están los archivos:
	# word Folder Users/usuario/carpeta
	
	comment All tiers names 
	sentence all_tiers transcription BI
	comment Point tiers name
	sentence point_tiers BI
	comment Had you already begun the TextGrid creation?
	comment If so, in wich number of the sound list do you 
	comment want to start today?
	integer nfile 1
	comment Do you want to make Textgrids for all files in one click?
	boolean pause_for_correction 0
endform
#seleccionador de carpeta (sólo crea una variable)
#comenta esta linea (pon una almohadilla) y descomenta las 4 lineas del formulario, si quieres poner la ruta escrita, sin el selector.
folder$ = chooseDirectory$ ("Elige la carpeta cuyos archivos quieres ver/modificar:")


#Crea la lista de archivos de todos los wav de esa carpeta
Create Strings as file list... listawav 'folder$'/*.wav


#selecciona la lista y extrae en una variable el numero de archivos que tiene
select Strings listawav
nstrings = Get number of strings

#empieza el bucle 
for i from nfile to nstrings
	select Strings listawav
	#Llevo el .wav que toca a objetos
	nombresonido$ = Get string... i
	Read from file... 'folder$'/'nombresonido$'

	#crea el TextGrid de ese .wav a objetos
	base$ = nombresonido$ - ".wav"
	nombregrid$ = base$ + ".TextGrid"
	
	To TextGrid: all_tiers$, point_tiers$
	
	#Selecciono los sonidos y los veo
	select Sound 'base$'
	plus TextGrid 'base$'
	View & Edit
	
	#pauso el script para dejar interaccionar al investigador
	if pause_for_correction = 1
		pause Corrige el TextGrid 'base$' ('i' de 'nstrings') y clica "Continuar" el TextGrid se guardará automáticamente.
	endif

	#Guardo el TextGrid
	select TextGrid 'base$'
	Save as text file... 'folder$'/'nombregrid$'
	
	#limpio la lista de objetos y de paso cierro la ventana del editor
	select all
	minus Strings listawav
	Remove
endfor

#limpieza de objetos final
select all
Remove

exit Finished





