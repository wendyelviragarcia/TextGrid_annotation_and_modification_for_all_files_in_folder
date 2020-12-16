# TextGrid_annotation_and_modification_for_all_files_in_folder
A set of scripts for Praat TextGrid files management

All scripts are autonomous and can be used separately:

## blank_TextGrid_creation: 
Creates TextGrids for all the Sounds in a folder.

## created_TextGrid_modification: 
Opens a created TextGrid with its related sound, gives you time to correct it and saves the TextGrid with the modifications.

## segmentation_helper: 
This script goes through all the wavs in a folder and annotates them (sound by sound in IPA). It needs the ortographic transcription of the wav content. It will write the same label (sentence) in the TextGrid for all the wavs in the folder. If you want to annotate a corpus that has a different content depending on the file name, check Mietta Lennes scripts, SPASS or EasyAlign.

## remove_tiers: 
This script runs through all the Textgrids in a folder and removes the number of tiers you select and those below it

## add_tiers: 
It adds new interval or point tiers for all the TextGrids in a folder.
