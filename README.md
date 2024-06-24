# Densify v0.3.2
**maintained by:** hkdb \<<hkdb@3df.io>\><br />

## Description

A GTK+ GUI Application written in Python that simplifies compressing PDF files with Ghostscript

## Change Log

#### June 24th, 2024 - v0.3.2 Released

- Fixed #9 - Recent & Drag & Drop
- Fixed \ check
- Added some other illegal filename characters that could potentially be dangerous

#### May 17th, 2020 - v0.3.1 Released

Hotfix:
- Increased "do not show logo" condition to "any display under 800 (h)"

#### May 17th, 2020 - v0.3.0 Released

Features:
- Added Error Handling Unsafe Character \`
- Switched to Python3 - also fixes #4
- Allow User Resize of Window
- Desktop Notification
- Handling Lower Screen Resolutions - #5
- Refined installation script (v0.2)

Bug Fixes:
- Display Icon - #3

Notes:

- Changed installation Procedure in README


### MAY 13th, 2018 - v0.2.0 Released

Features:
- Improved error handling of filenames - [issue #2](https://github.com/hkdb/Densify/issues/2)
- Support for Chinese & other unicode file names

Bug Fixes:
- Support whitespaces in filenames - [issue #1](https://github.com/hkdb/Densify/issues/1)

#### MAY 13th, 2018 - v0.1.0 Released

- Birth of Densify

## Screenshots

![Screenshots](https://osi.3df.io/wp-content/uploads/2018/05/Densify-Screens.png "Screenshots")

Notice that compressed.pdf is 4M; the results from compressing a 28M pdf? I then opened up compressed.pdf and it still looked great!

## Under the Hood

It essentially takes your GUI input and turns it into the following Ghostscript command:

```
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/ebook
-dNOPAUSE -dQUIET -dBATCH -sOutputFile=[compressed.pdf]
"[input.pdf]"
```

## Error Handling

Currently, if any of the below conditions are met, the application will either automatically handle or show an error/warning dialog message that returns to the main window without doing anything upon the user clicking "OK". This is designed to prevent any dangerous execution of Ghostscript. For the ones that are questionable, it will warn the user and provide a chance to cancel or confirm.

Automatically Handles:

- Output file name was not specified, use "compressed.pdf" by default

Shows an Error Dialog Message and Returns to Main Window Upon the User Clicking "OK":

- Input file is not specified
- Input file does not end with .pdf
- Input File and Output File are the same
- Input File Name Contains Unsupported Characters(/ \ : ; ` > < } { # * ' ")
- Output File Name Contains Unsupported Characters(/ \ : ; ` > < } { # * ' ")

Questionable Conditions that the application will verify with User via A Dialog Message:

- Output File does not end with .pdf, verify with user that's really what they want
- Output File Name Matches a File in the Output Directory

## Installation

Step 1:

Download or Clone Densify

Step 2:

Execute the install.sh script from within the downloaded Densify directory to install this application:

```
sudo chmod a+x install.sh
sudo ./install.sh
```
Enter your sudo password when the dialog pops up.

You should then see this:

```
hkdb@machine:/opt/Densify$ sudo ./install.sh
Installation Complete. If you don't see any errors above, you are good to go! :)
hkdb@machine:/opt/Densify$
```

Now, you can search for "densify" in Gnome Shell Search and you will see that Densify is available to launch. Enjoy!

## Disclaimer

This application is maintained by volunteers and in no way do the maintainers make any guarantees. Please use at your own risk!

## Recognition

Many thanks to Anthony Wong and Koala Yeung for talking me through this and Dr. Haggen So for sharing the following link that inspired me to write this application:

https://www.tjansson.dk/2012/04/compressing-pdfs-using-ghostscript-under-linux/

This is an application utility sponsored by 3DF Limited's Open Source Initiative.

To Learn more please visit:

https://osi.3df.io

https://www.3df.com.hk

## Want a CLI alternative instead?

Check out [cPDF](https://github.com/hkdb/cpdf), a Python script to simplify compress PDF file size with GhostScript
