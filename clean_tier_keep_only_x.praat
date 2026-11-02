# ============================================================================
# Keep selected labels and remove non-target intervals
# ============================================================================
#
# DESCRIPTION
# This script processes all TextGrids in a specified folder.
# It retains only the labels specified by the user and clears all other
# interval labels. It then merges consecutive empty intervals by removing
# their shared boundaries.
#
# The original boundaries delimiting retained intervals are preserved,
# so their original start times, end times and durations remain unchanged.
#
# INPUT
#   - A folder containing TextGrid files.
#   - A comma-separated list of labels to retain (e.g. s,z).
#   - The tier number to process.
#
# OUTPUT
#   - A new TextGrid for each input TextGrid, saved in the same folder.
#   - Output filename: originalfilename_cleaned.TextGrid
#   - Only the selected labels are retained.
#   - Consecutive empty intervals are merged.
#   - Original TextGrid files are not modified.
#
#
# Wendy Elvira-García
# Laboratory of Phonetics, University of Barcelona
#
# LICENSE
# GNU General Public License v3.0 (GNU GPL-3.0).
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but without any warranty.
# See https://www.gnu.org/licenses/gpl-3.0.html
#
# ============================================================================

form remove labels
    sentence Folder ./test
    sentence labels_to_keep s,z
    integer tier 2
endform

# Convert comma-separated labels into a string array
labels$# = splitByWhitespace$# (replace$ (labels_to_keep$, ",", " ", 0))
numberOfLabels = size (labels$#)

# Trim spaces around labels
for j from 1 to numberOfLabels
    labels$#[j] = replace_regex$ (labels$#[j], "^[ \t]+|[ \t]+$", "", 0)
endfor

# Create the list of WAV files
myList = Create Strings as file list: "list", folder$ + "/*.wav"
selectObject: myList
numberOfFiles = Get number of strings

for ifile from 1 to numberOfFiles

    selectObject: myList
    fileName$ = Get string: ifile
    base$ = fileName$ - ".wav"

    # Read the corresponding TextGrid
    if fileReadable (folder$ + "/" + base$ + ".TextGrid")

        myText = Read from file: folder$ + "/" + base$ + ".TextGrid"
        selectObject: myText

        nTiers = Get number of tiers

        if tier >= 1 and tier <= nTiers

            nIntervals = Get number of intervals: tier

            # Process all intervals
            for cleanInterval from 1 to nIntervals

                selectObject: myText

                cleanLabel$ = Get label of interval: tier, cleanInterval

                # Remove trailing spaces
                cleanLabel$ = replace_regex$ (cleanLabel$, "[ \t]+$", "", 0)

                # Check whether the label should be kept
                keepLabel = 0

                for j from 1 to numberOfLabels
                    if cleanLabel$ = labels$#[j]
                        keepLabel = 1
                    endif
                endfor

                # Empty all non-target intervals
                if keepLabel = 0
                    Set interval text: tier, cleanInterval, ""
                endif

            endfor






            # Second loop: merge consecutive empty intervals
            cleanInterval = Get number of intervals: tier

            while cleanInterval >= 2

                selectObject: myText

                currentLabel$ = Get label of interval: tier, cleanInterval
                currentLabel$ = replace_regex$ (currentLabel$, "[ \t]+$", "", 0)

                previousLabel$ = Get label of interval: tier, cleanInterval - 1
                previousLabel$ = replace_regex$ (previousLabel$, "[ \t]+$", "", 0)

                # If both consecutive intervals are empty, merge them
                if currentLabel$ = "" and previousLabel$ = ""

                    Remove left boundary: tier, cleanInterval

                endif

                cleanInterval = cleanInterval - 1

            endwhile

            # Save the cleaned TextGrid as a new file
            selectObject: myText
            Save as text file: folder$ + "/" + base$ + "_cleaned.TextGrid"

        else
            appendInfoLine: "Invalid tier in ", base$
        endif

    endif
removeObject: myText

endfor

# Remove the file-list object
removeObject: myList

