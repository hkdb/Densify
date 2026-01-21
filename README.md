# Densify
**maintained by:** hkdb \<<hkdb@3df.io>\><br />

## Description

A GTK GUI Application written in Python that simplifies compressing PDF files with Ghostscript

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

## Installation

Make sure you install the dependencies like `notify-send` and `ghostscript`.

You can then either download the latest AppImage(amd64 only) from the release page or follow the below steps.

Step 1:

Clone Densify:
```
git clone https://github.com/hkdb/Densify.git
```
or download the tarball from the release page and untar.

Step 2:

Go into the repo dir and execute the install.sh script from within the downloaded Densify directory to install this application:

```
cd Densify
sudo ./install.sh
```
Enter your sudo password when the dialog pops up.

You should then see this:

```
hkdb@machine:/opt/Densify$ sudo ./install.sh
Installation Complete. You are good to go! :)
hkdb@machine:/opt/Densify$
```

Now, you can search for "densify" in Gnome Shell Search and you will see that Densify is available to launch. Enjoy!

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

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
