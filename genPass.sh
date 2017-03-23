#!/bin/bash
#

function print_help {
  echo ""
  echo "usage: $0 [OPTIONS] <fileName>"
  echo ""
  echo -e "\t-c <number>\tset password count to <number>"
  echo -e "\t-d <directory>\tsaves the file to <directory>"
  echo ""
}

OUTDIR=""
anz=125
SHIFT=0

while getopts "d:bc:b" flag
do
  case "${flag}" in
    "d")
      echo "using output directory ${OPTARG}"
      OUTDIR="${OPTARG}/"
      SHIFT=$(($SHIFT + 2))
      ;;
    "c")
      echo "set password count to ${OPTARG}"
      anz="${OPTARG}"
      SHIFT=$(($SHIFT + 2))
      ;;
  esac
done

shift ${SHIFT}

if [[ -z $1 ]]
then
  print_help
  exit 1
fi

length=9
passwords=""
fileName="$1"

for i in $(seq 1 "${anz}") ; do
  passwords+="$i $(dd if=/dev/urandom bs=1 count=${length} 2> /dev/null | base64 | sed -e 's/\//\\\//g')"'\\[0.3cm]'
done

### TEX FILE ###
echo "
\documentclass[12pt]{article}

\usepackage[utf8]{inputenc}
\usepackage[english]{babel}
\usepackage[a4paper,bindingoffset=0.2in,
            left=3cm,right=3cm,top=1cm,bottom=1cm,
            footskip=.25in]{geometry}
\usepackage{multicol}

\renewcommand{\familydefault}{\ttdefault}
\thispagestyle{empty}

\begin{document}
  \begin{multicols}{3}[
    \section*{\centering Passwort Liste für unsere E-Mail Korrespondenz}
    \vspace{0.5cm}
  ]
    ${passwords}
  \end{multicols}
\end{document}
" > "${OUTDIR}${fileName}.tex"
################
