'''

Downloads and stores the IDs of all the tweets returned by a given search.

Johne Rzodkiewicz

Command line usage: 
	Arg 1: The Twitter JSON request URL. Probably needs to be in quotes.
	Arg 2: Output file name.
	Arg 3: Max number of results to return.

	All are optional, but if one wants to supply a particular argument, all the preceding ones must be supplied as well because I didn't write an actual parser. 

'''
from json_tools import *
import re
import os
import datetime
from time import sleep
import sys


def updatetwitterSearchURL(previousURL, nextID):
	return re.sub(r'TWEET-\d+', "TWEET-" + str(nextID), previousURL, count=1)


# Takes a full buffer of tweet ids and a file handle, divides the buffered ids into lines of <= 100, and writes them to said file.
# Returns number of ids written.
def writeTweetIDs(fileHandle, tweetBuffer):

	counter = 0
	for tid in tweetBuffer:

		# write to file using commas as delimiters 
		# note that even the last id in the list is followed by a comma, and the second program assumes this
		fileHandle.write(tid+",")

		# make a new line once we have 100 
		if not (counter % 100):
			fileHandle.write("\n")
		counter += 1

	return counter


# My first fully functional searcher / id downloader.
# Takes a special initial request URL (must be found manually), a name for the output file, and max number of results to return. Downloads and stores the IDs of all tweets returned by that search (up to the limit, if not 0).
# Returns the number of tweet IDS saved.
# Note that because the buffer is only written every so often, very low values of maxResults may be useless.
def basicSearch(requestURL, fileName="default_name.txt", maxResults = 0):

	# Intro message
	print("Downloading tweet IDs...")

	# This is a buffer. It collects a large number of tweet ids; once there are enough, they are divided into lines of ~100 and written to disk. This offers a balance between constant disk writing and losing everything should the program crash. 
	buffer = []

	# Open a file to save the ids. I use a .txt extention just so you can easily click on the file and open it without selecting an application to open it. 
	# If no name is specified for the output file, we make one up using the current date/time.
	if fileName == "default_name.txt":
		fileName = "search_results_"+datetime.datetime.now().isoformat()+".txt"
	f = open(fileName, "w")

	# This keeps track of how many tweet ids have been found.
	numResults = 0

	# This second counter lets us know when to clear the buffer.
	counter = 0

	while(True):
		# This really was the best way I could think of to make this loop.
		if maxResults:
			if numResults >= maxResults:
				break

		# Get a batch of tweets from Twitter. Seems to return 15-20 at a time.
		j = JSON.fromURL(requestURL)

		#j.printContents()

		# Get a list of the tweet ids from the returned JSON file. 
		tweetIds = j.getTweetIDs()
		if tweetIds == None:
			break
		else:
			buffer += tweetIds

		# Use the last tweet id to update the request URL so we can get the next batch of tweets
		requestURL = updatetwitterSearchURL(requestURL, buffer[-1])

		# Clear the buffer every so many passes and give the user an indication that the program is making progress.
		counter += 1
		if not(counter%20):
			numResults += writeTweetIDs(f, buffer)
			print("..."+str(numResults))
			buffer = []
		sleep(0.5)


	numResults += writeTweetIDs(f, buffer)
	print("\nDONE!\nDownloaded", numResults, "tweet IDs.")

	# Close the output file.
	f.close()

if __name__ == "__main__":

	# Get parameters from command line args, if possible. 
	# default debugging values
	#searchString = "https://twitter.com/i/search/timeline?vertical=default&q=stackoverflow%20since%3A2010-06-08%20until%3A2010-06-20&src=typd&include_available_features=1&include_entities=1&max_position=TWEET-17901046179-38292929111-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false"
	#outputFileName = "default_name.txt"
	searchString = "https://twitter.com/i/search/timeline?vertical=default&q=mephistophelian%20lang%3Aen%20since%3A2011-01-01%20until%3A2011-12-31&src=typd&include_available_features=1&include_entities=1&max_position=TWEET-131982699928883200-152258905760727040-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false"
	outputFileName = "mep_2013_newest5"
	searchString = "https://twitter.com/i/search/timeline?vertical=default&q=%22Kombucha%22%20lang%3Aen%20since%3A2011-01-01%20until%3A2011-12-31&src=typd&include_available_features=1&include_entities=1&lang=en&max_position=TWEET-152818692563025920-152896761122390016-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false"
	#searchString = "https://mobile.twitter.com/i/rw/search/timeline/all?q=%22Kombucha%22%20lang%3Aen%20since%3A2011-01-01%20until%3A2011-12-31&next_cursor=TWEET-152818692563025920-152896761122390016-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	#searchString = "https://twitter.com/i/search/timeline?vertical=default&q=%22whatever%22%20lang%3Aen%20since%3A2015-02-11%20until%3A2015-11-02&src=typd&include_available_features=1&include_entities=1&lang=en&max_position=TWEET-660908361874034688-660968352303706114-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAgAAAAAAAAAAAAAAg&reset_error_state=false"
	#searchString = "https://twitter.com/i/search/timeline?vertical=default&q=%22whatever%22%20since%3A2010-03-16%20until%3A2010-11-25&src=typd&include_available_features=1&include_entities=1&lang=en&max_position=TWEET-7583841334067200-7584239008620544-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false"
	#searchString = "https://twitter.com/i/search/timeline?vertical=default&q=%22whatever%22%20since%3A2010-03-16%20until%3A2010-11-25&src=typd&composed_count=0&include_available_features=1&include_entities=1&include_new_items_bar=true&interval=30000&lang=en&latent_count=0&min_position=TWEET-7583841334067200-7584239008620544-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
	maxResults = 0

	if len(sys.argv) >= 2:
		searchString = sys.argv[1]
		if len(sys.argv) >= 3:
			outputFileName = sys.argv[2]
			if len(sys.argv) >= 4:
				maxResults = int(sys.argv[3])

	print("Output file:", outputFileName)

	#actually run the search
	basicSearch(searchString, outputFileName, maxResults)

	