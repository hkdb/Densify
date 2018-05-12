# Densify v0.1.0
**maintained by:** hkdb \<<hkdb@3df.io>\><br />

## Description

A GTK+ GUI Application written in Python that simplifies compressing PDF files with Ghostscript

## Change Log
MAY 12th, 2018 - v0.1.0 Released

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
- Input File Name Contains Unsupported Characters(not alphabetical, numeric, dashes, or underscores)
- Output File Name Contains Unsupported Characters(not alphabetical, numeric, dashes, or underscores)

Questionable Conditions that the application will verify with User via A Dialog Message:

- Output File does not end with .pdf, verify with user that's really what they want
- Output File Name Matches a File in the Output Directory

## Installation

Step 1:

Download and place "Densify" folder in /opt

Step 2:

Execute the install.sh script to install this application:

```
cd /opt/Densify/
sudo chmod 755 install.sh
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

## Future Plans

- Compile to binaries to support Linux with Nuitka
- Build Debian Packages
- Build RPM Packages
- Compile to binaries to support OS X and Windows 10

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

Check out [Densify](https://github.com/hkdb/cpdf), a Python script to simplify compresses PDF file size with GhostScript
