'''

Functions for getting and processing tweet-containing JSON files from Twitter.

Johne Rzodkiewicz

'''

import urllib.request	# for downloading the files
import re 				# regex 

# This class represents a JSON file
class JSON:

	# I use multiple constructors here because in the future I may want to load JSONs from disk. (Though right now, that functionality isn't active.)
	def __init__(self, data):
		self.contents = data

	# Load a JSON file from a URL
	@classmethod
	def fromURL(cls, path):
		response = urllib.request.urlopen(path)
		data = response.read().decode(encoding='UTF-8')
		return cls(data)

	# Load a JSON file from disk
	# Note: empty / stub right now 
	@classmethod
	def fromDisk(cls, path):
		pass

	# Saves JSON file to disk 
	def saveJSON(self, fileName="saved_json"):
		f = open(fileName+".json", "w")
		f.write(self.contents)
		f.close()

	# Find the last tweet ID in the file using regular expressions
	# Returns last tweet ID, or None on failure
	def getLastTweetID(self):
		matches = re.findall('data-tweet-id=\\\\"(\d\d\d\d\d\d\d\d\d\d\d)', self.contents, 0)
		if matches:
			return matches[-1]	
		else:
			print("ERROR: found no tweet ids")
			return None 

	# Find all the tweet IDs contained in the file
	# Returns list of tweet IDs, or None on failure
	def getTweetIDs(self):
		matches = re.findall('data-tweet-id=\\\\"(\d\d\d\d\d\d\d\d\d\d\d)', self.contents, 0)
		if matches:
			return matches	
		else:
			return None 	

	# Prints contents to console for debugging
	def printContents(self):
		print(self.contents)







if __name__ == "__main__":
	pass