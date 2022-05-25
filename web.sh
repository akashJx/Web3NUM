#!/bin/bash

# ---------------------------------
# Decoration
# BOLD
B0='\033[1m'
B1='\033[0m'

# Purple
Purple='\033[0;35m'

# Green
Green='\033[0;32m'

# Cyan
Cyan='\033[0;36m'

# No Color
NC='\033[0m'
# ---------------------------------

# Usage Banner
__usage="
Usage: 
  web http://URL/
  web https://URL/

Example:
  web http://127.0.0.1/
  web https://www.example.com/
"
# Argument / URL
url=$1

# general enum
fgeneral(){
	printf -- '\n-----------------------'"${Green}${B0} Quick Enum ${B1}${NC}"'-----------------------\n'
  # robots.txt
  printf -- '\n'"${Purple} /robots.txt ${NC}"'\n'
  curl -s -D - -o /dev/null $url/robots.txt | grep -E 'HTTP|Server'

  # sitemap.xml
  printf -- '\n'"${Purple} /sitemap.xml ${NC}"'\n'
  curl -s -D - -o /dev/null $url/sitemap.xml | grep -E 'HTTP|Server'

  # .git
  printf -- '\n'"${Purple} /.git ${NC}"'\n'
  curl -s -D - -o /dev/null $url/sitemap.xml | grep -E 'HTTP|Server'

  # webdav
  printf -- '\n'"${Purple} /webdav ${NC}"'\n'
	curl -s -D - -o /dev/null $url/webdav | grep -E 'HTTP|Server'
}

# whatweb tool
fwhatweb(){
	printf -- '\n-----------------------'"${Green}${B0} whatweb ${B1}${NC}"'-----------------------\n'
	printf "${Cyan}whatweb -v $url ${NC}\n\n"
	whatweb -v $url
	printf "\n"
}

# hakrawler tool
fhakrawler(){
	printf -- '\n-----------------------'"${Green}${B0} hakrawler ${B1}${NC}"'---------------------\n'
	printf "${Cyan}echo $url | hakrawler\n\n${NC}\n"
	echo $url | hakrawler
	printf "\n"
}

# raccoon tool
fraccoon(){
	printf -- '\n-----------------------'"${Green}${B0} raccoon ${B1}${NC}"'-----------------------\n'
	printf "${Cyan}raccoon $url -T 200 --no-url-fuzzing${NC}\n"
	raccoon $url -T 200 --no-url-fuzzing
	printf "\n"
}

# gobuster / feroxbuster web enum
fwebenum(){
  printf -- '\n-----------------'"${Green}${B0} Web Dirs/Files/Recursive Dir Enum ${B1}${NC}"'-----------------\n'
  
  # web files
  printf -- '\n'"${Purple} Web Files ${NC}"'\n'
  printf "${Cyan}gobuster dir -k --quiet -u $url -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -t 90 -b 301,401,404,500,502${NC}\n"
  gobuster dir -k --quiet -u $url -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -t 90 -b 301,401,404,500,502
  printf "\n"

  # web dirs
  printf -- '\n'"${Purple} Web Dirs ${NC}"'\n'
  printf "${Cyan}gobuster dir -k -f --quiet -u $url -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt -t 90 -b 301,401,404,500,502${NC}\n"
  gobuster dir -k -f --quiet -u $url -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt -t 90 -b 301,401,404,500,502
  printf "\n"

  # recursive web dirs
  printf -- '\n'"${Purple} Recursive Web Dirs ${NC}"'\n'
  printf "${Cyan}feroxbuster -q -d 2 -f -C 403,500,502 -u $url -w /usr/share/dirb/wordlists/big.txt -t 100${NC}\n"
  feroxbuster -q -d 2 -f -C 403,500,502 -u $url -w /usr/share/dirb/wordlists/big.txt -t 100
  printf "\n"
}

# final check
fcheck(){
	printf "${Green}\nScan completed\n${NC}"
	printf "${Purple}Also check racoon saved results from${NC} ${Green}${B0} ~/Raccoon_scan_results${B1}${NC}\n"
	notify-send -i face-smile-big 'Check Scan results.!';
	notify-send -i face-smile-big 'Scan completed.!';
}

# All Function call
# Check for empty command line arg.
if [ -z "$*" ]; 
	then 
		echo "$__usage"
		exit 0;
else
	fgeneral
	fwhatweb
	fhakrawler
	fraccoon
	fwebenum
	fcheck
fi