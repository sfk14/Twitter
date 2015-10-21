'''

Functions for getting and processing tweet-containing JSON files from Twitter.

Johne Rzodkiewicz

'''


import urllib.request
import re


class JSON:


	def __init__(self, data):
		self.contents = data

	@classmethod
	def fromURL(cls, path):
		response = urllib.request.urlopen(path)
		data = response.read().decode(encoding='UTF-8')
		return cls(data)

	@classmethod
	def fromDisk(cls, path):
		pass

	def saveJSON(self, fileName="saved_json"):
		f = open(fileName+".json", "w")
		f.write(self.contents)
		f.close()


	def getLastTweetID(self):
		matches = re.findall('data-tweet-id=\\\\"(\d\d\d\d\d\d\d\d\d\d\d)', self.contents, 0)
		if matches:
			return matches[-1]	
		else:
			print("ERROR: found no tweet ids")
			return None 

	def getLastTweetID_old(self):
		matches = re.finditer('.*data-tweet-id=\\\\"(\d\d\d\d\d\d\d\d\d\d\d)', self.contents, re.S)
		if matches:
			return(list(matches)[-1].group(1)) 
		else:
			print("ERROR: no matches")
			return None 

	def getTweetIDs(self):
		matches = re.findall('data-tweet-id=\\\\"(\d\d\d\d\d\d\d\d\d\d\d)', self.contents, 0)
		if matches:
			return matches	
		else:
			return None 	


	def printContents(self):
		print(self.contents)







if __name__ == "__main__":
	pass