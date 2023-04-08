
# Table of Contents

1.  [Scripts](#org32aaf83)
    1.  [Multimedia files conversion](#orgd5020c3)
    2.  [Playing music - command line](#orgbda3f01)
        1.  [FZF + mocp [file:bin/p]](#org2f65d18)
        2.  [FZF + mpg123 + playlist creation [file:bin/m1]](#orgffc9225)
        3.  [FZF + mpg123 [file:bin/m2]](#orgc1850c2)
2.  [Emacs](#orgfe3276f)
    1.  [Doom emacs configuration [file:.doom.d]](#orgdfc3933)
3.  [Other](#orga67e8f5)



<a id="org32aaf83"></a>

# Scripts


<a id="orgd5020c3"></a>

## Multimedia files conversion


<a id="orgbda3f01"></a>

## Playing music - command line

I use mpg123 to play my mp3 music files for years. Recently I&rsquo;ve found fzf (fuzzy find) tool and I&rsquo;ve got an idea to use it to accelerate search and kick of playing songs from my music gallery.

Below you will find three handy scripts I&rsquo;ve created for quick finding and playing of music:


<a id="org2f65d18"></a>

### FZF + mocp [<bin/p>]

It uses MOCP to play the songs from selected directory and its subdirectories. It also plays flac files if you install flac decoder.

    
    #!/bin/bash
    # depends on: fzf and mocp (music on console)
    
    musicDir=~/Music
    fzfSelectedDir="$(find $musicDir -type d|fzf)"
    mocp -m "$fzfSelectedDir" -c -a "$fzfSelectedDir" -p
    mocp


<a id="orgffc9225"></a>

### FZF + mpg123 + playlist creation [<bin/m1>]

It creates a playlist, saves it in selected directory and uses mpg123 to play it.

    
    #!/bin/bash
    # depends on: fzf and mpg123 - create a list.m3u file in selected folder then passes it to play to mpg123
    
    musicDir=~/Music
    fzfSelectedDir="$(find $musicDir -type d|fzf)"
    cd "$fzfSelectedDir"
    find ./ -iregex '.*.mp.*' -type f -print > list.m3u
    mpg123 --list list.m3u


<a id="orgc1850c2"></a>

### FZF + mpg123 [<bin/m2>]

It plays songs from selected directory passing songs list directly to mpg123. You need to use ctrl+c to go to next track.

    
    #!/bin/bash
    # depends on: fzf and mpg123 - need to do ctrl+c to go to next track
    
    musicDir=~/Music
    fzfSelectedDir="$(find $musicDir -type d|fzf)"
    cd "$fzfSelectedDir"
    find ./ -iname '*.mp3' -type f -print | mpg123 --list -


<a id="orgfe3276f"></a>

# Emacs


<a id="orgdfc3933"></a>

## Doom emacs configuration [<.doom.d>]


<a id="orga67e8f5"></a>

# Other

