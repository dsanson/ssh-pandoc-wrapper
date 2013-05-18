## The Problem 

[Pandoc] is not easy to install in every environment. 

## A Solution

One way to use pandoc without having it installed is to use a copy installed on a remote server over ssh. For example,

    $ cat foo.markdown | ssh example.com "pandoc -t html"

will pipe the content of your local file, `foo.markdown`, through the remote copy of pandoc, convert it to html, and return the output on standard out, where you can do what you want with it.

Binary output (pdf, docx, odt, epub) is slightly more complicated, because pandoc will not pipe binary files to standard out,

    $ cat foo.markdown | ssh example.com "pandoc -o foo.docx; cat foo.docx; rm foo.docx" > foo.docx

will do the trick.

## Convenience

Place `ssh-pandoc-wrapper.sh` in your path, make it executable, and rename it `pandoc`. Edit the `server` variable on line 3 to point to your ssh server.

Now you have an ersatz local copy of pandoc. The script worries about
passing local input to the remote server and getting remote output back.
All other options are passed through to the copy of pandoc running on
the remote server.

All of these commands should work just as expected:

    $ pandoc foo.markdown 
    $ cat foo.markdown | pandoc
    $ pandoc foo.markdown bar.markdown -o foobar.docx
    $ pandoc foo.markdown -t latex --numbered-sections --latex-engine xelatex

Even

    $ pandoc
    **example**
    ^D
    <p><strong>example</strong><p>

## Other Files

As explained above, the script worries about passing local input to the remote server and getting remote output back. All other options are passed through to the remote server. This means that some commands may not work as expected. For example,

    $ pandoc foo.markdown -t latex --template exam.latex

will only work if `exam.latex` is available to the *remote* copy of pandoc, on the remote server.

So if your conversion depends on other files—templates, bibtex files, images, css files—it is up to you to worry about making sure those files are available to the remote copy of pandoc.

## Requirements

You need to have access to pandoc over ssh. The script itself is written in bash.

## Installation

Place `ssh-pandoc-wrapper.sh` in your path, make it executable, and rename it `pandoc`. Edit the `server` variable on line 3 to point to your ssh server.

You may wish to setup password-less ssh login: if you don't, you will need to provide your password every time you use the script.

[pandoc]: http://www.johnmacfarlane.net/pandoc/


