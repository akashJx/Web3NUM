# Web3NUM

**A standalone bash script which utilizes existing web enumeration tools to find most interesting stuffs in web application security testing.
This tool just runs various tools with one web url as command line argument.**

**Reason to use this tool?**
- Well it can find the files/folders some endpoints which we may overlook while doing things manually.

> **Aimed for OSCP. No auto exploitation. No violation of tool restrictions.**

**Why I made this?**
- For easing the process of web enum in OSCP exam.
- I was putting wrong flags with wrong wordlists.
- I didn't wanted to copy paste commands from my cheatsheet and change the url parameter everytime for most usual commands.

### Tested on
- Kali Linux 2021.3 (PWK VM)
 
### Prerequisite
Install the below tools before running it.
- curl
- whatweb
- hakrawler
- racoon
- gobuster
- feroxbuster

```bash
sudo apt install whatweb,gobuster,hakrawler,feroxbuster,curl -y

sudo pip install raccoon-scanner
```

### Download / Config
```
wget "https://raw.githubusercontent.com/akashJx/Web3NUM/main/web.sh"

sudo cp web.sh /usr/local/bin/

sudo chmod 777 /usr/local/bin/web.sh
```

### Usage
```
$ sh web.sh                       

Usage: 
  web http://URL/
  web https://URL/

Example:
  web http://127.0.0.1/
  web https://www.example.com/
```

---

**My Discord :** akashx#4733

DM to discuss about this tool / about improvements. 

---
