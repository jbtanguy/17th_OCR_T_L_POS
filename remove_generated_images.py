from PIL import Image 
import sys
import os

if __name__ == '__main__':
	img_path = sys.argv[1] # Path to PNG image
	img = Image.open(img_path) # Open image
	if img.getcolors() == None: # nb colors test 1 - images from gallica: None
		os.remove(img_path)
	else:
		if len(img.getcolors()) < 256: # nb colors test 2 - empty images:nb colors < 256
			os.remove(img_path)