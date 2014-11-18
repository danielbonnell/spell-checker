spell-checker
===========

A simple program I wrote that takes a string of words and checks it for misspelled words. The program creates a dictionary from the lotsowords.txt file. It creates a list of words from the string that aren't in the dictionary and then checks them to see if they are missing a letter (e.g. "Ruby on Rals"), have an extra letter somewhere (e.g. "Rubby on Rails") or have two adjacent letters swapped (e.g. "Ruby on Raisl"). After compiling a list of candidate matches for the misspelled word, the program presents the user with an ordered list of the most likely match based on the frequency with which the candidate match appears in the lotsowords.txt file.
