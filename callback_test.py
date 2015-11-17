import urllib.request	# for downloading the files
import json
import requests
import webbrowser
from twython import Twython
from time import sleep
import sys


# get Twitter authentication tokens from a file on my machine
# note: this is to prevent these access tokens from being published on github
credentials = open("keys", "r")
ACCESS_TOKEN = credentials.readline().rstrip()
ACCESS_SECRET = credentials.readline().rstrip()
CONSUMER_KEY = credentials.readline().rstrip()
CONSUMER_SECRET = credentials.readline().rstrip()
credentials.close()

# set up the connection to twitter 
twitter = Twython(CONSUMER_KEY, access_token=ACCESS_TOKEN)


searchString = "https://twitter.com/i/search/timeline?vertical=default&q=mephistophelian%20lang%3Aen%20since%3A2011-01-01%20until%3A2011-12-31&src=typd&include_available_features=1&include_entities=1&max_position=TWEET-131982699928883200-152258905760727040-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false&callback=inner"
#searchString = "https://twitter.com/i/search/timeline?vertical=default&q=%22whatever%22%20lang%3Aen%20since%3A2010-01-01%20until%3A2011-01-01&src=typd&include_available_features=1&include_entities=1&lang=en&max_position=TWEET-20992404257505280-20992593840054272-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false&callback=?"
#searchString = "https://mobile.twitter.com/i/rw/search/timeline/all?q=%22whatever%22%20lang%3Aen%20since%3A2010-01-01%20until%3A2011-01-01&next_cursor=TWEET-20992103693688833-20992593840054272-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
searchString = "https://twitter.com/i/search/timeline?vertical=default&q=%22phoenix%22%20lang%3Aen%20since%3A2015-01-01%20until%3A2015-10-31&src=typd&include_available_features=1&include_entities=1&lang=en&max_position=TWEET-660243941887987712-660244766794391553-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false&callback=?"



path="https://twitter.com/i/search/timeline?vertical=default&q=%22testing%22%20lang%3Aen%20since%3A2010-01-01%20until%3A2011-01-01&src=typd&composed_count=0&include_available_features=1&include_entities=1&include_new_items_bar=true&interval=30000&lang=en&latent_count=0&min_position=TWEET-20987467066773506-20992564681244672-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
path="https://twitter.com/i/search/timeline?vertical=default&q=%22testing%22%20lang%3Aen%20since%3A2010-01-01%20until%3A2011-01-01&src=typd&include_available_features=1&include_entities=1&lang=en&max_position=TWEET-20987467066773506-20992564681244672-BD1UO2FFu9QAAAAAAAAETAAAAAcAAAASAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&reset_error_state=false"
initialPath = "https://twitter.com/search?q=%22testing%22%20lang%3Aen%20since%3A2010-01-01%20until%3A2011-01-01&src=typd&lang=en"

'''
response = urllib.request.urlopen(path)
data = response.read().decode(encoding='UTF-8')
print(data)
'''

with urllib.request.urlopen(initialPath) as data:
	result = data.read()


	print(result)


print("==============================\n\n")
s = requests.Session()
r = s.get(initialPath)
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)
print(r.text.encode(encoding="UTF-8"))
r = s.get(path)
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)
print(r.text.encode(encoding="UTF-8"))
print(r.json())