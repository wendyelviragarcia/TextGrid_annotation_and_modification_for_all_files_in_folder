#segmentation_helper v.1
# Citation: Elvira-García, W. (2018). Segmentation helper. v1. Laboratori de Fonètica (University of Barcelona). Retrieved from http://stel.ub.edu/labfon/en/praat-scripts

# This script goes through all the wavs in a folder and annotates them (sound by sound in IPA).
# It needs the ortographic transcription of the wav content. All the wavs must have the same segmental content.
# If you want to annotate a corpus that has a different content depending on the code check Mietta Lennes scripts, SPASS or EasyAlign.
# If you belong to the AMPER project ask for the AMPER segmentation script.

# Description:
# for all the wavs in a folder:
# creates a TextGrid with a 2 tiers
# in tier1: the whole sentence you provided in the form
# in tier2: the phonetic transcription split by phone

# Arguments of the script (3)(data that needs in the form)
# 1 $label_of_the_tier_1
# 2 $folder
# 3 boolean set it to 0 for command prompt


# comments are always welcome 
#	Free script under a GNU General Public License contract. Comes without warranty. 
#	wendyelviragarcia a t g m a i l . c o m

;author weg

form Segmenter help
	comment Write the content of your wav
	comment write spaces as underscores
	sentence Utterance Venen_verdura
	comment Write where your files are:
	sentence folder D:\Usuarios\labfonub15\Desktop\test_manual
	optionmenu language
		option Catalan
		option Spanish (Spain)
		option English (America)

	boolean Pause_after_each_file 0
endform

#utterance$ =  "Venen verdura"

Create Strings as file list: "list", folder$ + "/" + "*wav"
numberOfFiles = Get number of strings

for ifile to numberOfFiles
	selectObject: "Strings list"
	fileName$ = Get string: ifile


	if fileReadable(folder$ + "/" + fileName$)
		mySound = Read from file: folder$ + "/" + fileName$
		#mySound = selected("Sound")
		name$ = selected$("Sound")
		
		myText = To TextGrid (silences): 100, 0, -25, 0.1, 0.1, "", utterance$
		nIntervals= Get number of intervals: 1
		for iInterval to nIntervals
			selectObject: myText
			currentLabel$ = Get label of interval: 1, iInterval
			if currentLabel$ = utterance$
				start= Get start time of interval: 1, iInterval
				end = Get end time of interval: 1, iInterval
				selectObject: mySound, myText
				View & Edit

				editor: myText
					Alignment settings:
					... language$, "no", "yes", "yes"
					Select: start, end
					Align interval
				endeditor
			endif
		endfor
		
		if pause_after_each_file = 1
			selectObject: mySound, myText
			View & Edit
			pause Correct the segmentation
		endif
		
		selectObject: myText
		Save as text file: folder$ + "/" + name$ + ".TextGrid"
		removeObject: myText, mySound
	else
		echo No sound
	endif
endfor
