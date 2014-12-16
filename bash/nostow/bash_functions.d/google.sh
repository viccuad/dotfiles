# define a word - USAGE: define dog
function define() {
  local LNG=$(echo $LANG | cut -d '_' -f 1)
  local CHARSET=$(echo $LANG | cut -d '.' -f 2)
  lynx -accept_all_cookies -dump -hiddenlinks=ignore -nonumbers -assume_charset="$CHARSET" -display_charset="$CHARSET" "http://www.google.com/search?hl=${LNG}&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -C 2 -A 5 -w "*" > /tmp/define
  if [ ! -s /tmp/define ]; then
    echo "Sorry, google doesn't know this one..."
    rm -f /tmp/define
    return 1
  else
    cat /tmp/define | grep -v Search
    echo ""
  fi
  rm -f /tmp/define
  return 0
}


# translate a word using Google
# usage: translate <phrase> <output-language>
# example: translate "hello" es = hola (will auto-detect source language)
# for a list of language codes: http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
function translate() { wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=%7C${2:-en}" | sed 's/.*{"translatedText":"\([^"]*\)".*/\1\n/'; }



function translate_help() {
cat <<EOF
Language  ISO
(Afan) Oromo  om
Abkhazian ab
Afar    aa
Afrikaans af
Albanian  sq
Amharic   am
Arabic    ar
Armenian  hy
Assamese  as
Aymara    ay
Azerbaijani az
Bashkir   ba
Basque    eu
Bengali   bn
Bhutani   dz
Bihari    bh
Bislama   bi
Breton    br
Bulgarian bg
Burmese   my
Byelorussian  be
Cambodian km
Catalan   ca
Chinese   zh
Corsican  co
Croatian  hr
Czech   cs
Danish    da
Dutch   nl
English   en
Esperanto eo
Estonian  et
Faeroese  fo
Fiji    fj
Finnish   fi
French    fr
Frisian   fy
Galician  gl
Georgian  ka
German    de
Greek   el
Greenlandic kl
Guarani   gn
Gujarati  gu
Hausa   ha
Hebrew    he
(former iw)
Hindi   hi
Hungarian hu
Icelandic is
Indonesian  id
(former in)
Interlingua ia
Interlingue ie
Inupiak   ik
Inuktitut   iu
(Eskimo)
Irish   ga
Italian   it
Japanese  ja
Javanese  jw
Kannada   kn
Kashmiri  ks
Kazakh    kk
Kinyarwanda rw
Kirghiz   ky
Kirundi   rn
Korean    ko
Kurdish   ku
Laothian  lo
Latin   la
Latvian,  lv
Lettish
Lingala   ln
Lithuanian  lt
Macedonian  mk
Malagasy  mg
Malay   ms
Malayalam ml
Maltese   mt
Maori   mi
Marathi   mr
Moldavian mo
Mongolian mn
Nauru   na
Nepali    ne
Norwegian no
Occitan   oc
Oriya   or
Pashto, Pushto  ps
Persian   fa
Polish    pl
Portuguese  pt
Punjabi   pa
Quechua   qu
Rhaeto-Romance  rm
Romanian  ro
Russian   ru
Samoan    sm
Sangro    sg
Sanskrit  sa
Scots Gaelic  gd
Serbian   sr
Serbo-Croatian  sh
Sesotho   st
Setswana  tn
Shona   sn
Sindhi    sd
Singhalese  si
Siswati   ss
Slovak    sk
Slovenian sl
Somali    so
Spanish   es
Sudanese  su
Swahili   sw
Swedish   sv
Tagalog   tl
Tajik   tg
Tamil   ta
Tatar   tt
Tegulu    te
Thai    th
Tibetan   bo
Tigrinya  ti
Tonga   to
Tsonga    ts
Turkish   tr
Turkmen   tk
Twi   tw
Uigur   ug
Ukrainian uk
Urdu    ur
Uzbek   uz
Vietnamese  vi
Volapuk   vo
Welch   cy
Wolof   wo
Xhosa   xh
Yiddish   yi
(former ji)
Yoruba    yo
Zhuang    za
Zulu    zu
EOF
}

# ThePirateBay.org torrent search 
function piratebay()
{
lynx -dump http://thepiratebay.org/search/$@|awk '/TPB.torrent$/ {print $2}'
}

# Google spell checker
function spellcheck() { typeset y=$@;curl -sd "<spellrequest><text>$y</text></spellrequest>" https://www.google.com/tbproxy/spell|sed -n '/s="[0-9]"/{s/<[^>]*>/ /g;s/\t/ /g;s/ *\(.*\)/Suggestions: \1\n/g;p}'|tee >(grep -Eq '.*'||echo -e "OK");}
