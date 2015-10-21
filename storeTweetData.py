'''

Takes a collection of tweet IDs saved by my other program and downloads and saves all the data associated with them.

Johne Rzodkiewicz

Command line usage: 
	Arg 1: Input file name.
	Arg 2: Output file name.

	If both are blank, my hardcoded debugging defaults are used. If only one is supplied, it is assumed to be the input name and an output name is made up. Any args after the second are ignored.

'''

from twython import Twython
from time import sleep
import sys

# twitter app credentials 
# ---------[ REDACTED ]----------

# set up the connection to twitter 
twitter = Twython(CONSUMER_KEY, access_token=ACCESS_TOKEN)

# get file names
# see above for details / command line usage 
if len(sys.argv) >= 2:
	inputFileName = sys.argv[1]
	if len(sys.argv) >= 3:
		outputFileName = sys.argv[2]
	else:
		outputFileName = sys.argv[1]+"_output"
else:
	# default values for testing 
	inputFileName = "t3.txt"
	outputFileName = "test_output_3.txt"
	print("WARNING: Input and output file names not supplied. Using debugging defaults.")

print("Input file:", inputFileName, "\tOutput file:", outputFileName)

# Open the output file.
outputFile = open(outputFileName, "w")


# counter so we know when to write to the file and clear the buffer
c = 0

# intro message to user
print("Storing tweets...")

with open(inputFileName, "r") as inputFile:

	# Again using a buffer so it isn't constantly writing to disk.
	buffer = ""

	for line in inputFile:

		# remove the newline character and superfluous comma at end of line
		line = line[0:-2]

		# get the tweet data from twitter, up to 100 tweets at a time
		status = twitter.lookup_status(id=line)

		# convert each tweet's worth of data into a string and add it to the buffer
		for x in status:
			y = str((str(x).encode('utf-8'))) # this is rough but idk how else to deal with unicode errors
			buffer += (y+"\n")

		# see if we need to write to the file and clear the buffer 
		c+=1
		if not(c%20):
			print("...working "+str(c))
			outputFile.write(buffer)
			buffer = ""

		sleep(0.1)
		
# write anything remaining in buffer 
outputFile.write(buffer)



inputFile.close()
outputFile.close()


print("Done.")

