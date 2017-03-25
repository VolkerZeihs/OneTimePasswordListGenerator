#!/bin/bash
#

function print_help {
  echo ""
  echo "usage: $0 [OPTIONS] <fileName>"
  echo ""
  echo -e "\t-c <number>\tset password count to <number>"
  echo -e "\t-d <directory>\tsaves the file to <directory>"
  echo -e "\t-n <number>\tset the number of random bytes used for the password generator <number>"
  echo ""
}

OUTDIR=""
passwordCount=100
SHIFT=0
length=12

while getopts "d:bc:b:n:" flag
do
  case "${flag}" in
    "d")
      echo "using output directory ${OPTARG}"
      OUTDIR="${OPTARG}/"
      SHIFT=$(($SHIFT + 2))
      ;;
    "c")
      echo "set password count to ${OPTARG}"
      passwordCount="${OPTARG}"
      SHIFT=$(($SHIFT + 2))
      ;;
    "n")
      echo "set random bytes count to ${OPTARG}"
      length="${OPTARG}"
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

passwords=""
fileName="$1"

for i in $(seq 1 "${passwordCount}") ; do
  passwords+="$i $(dd if=/dev/urandom bs=1 count=${length} 2> /dev/null | base64 | sed -e 's/\//\\\//g')"'\\'
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
\title{\vspace{-2cm}Passwortliste für unsere E-Mail-Korrespondenz}
\setlength{\parindent}{0pt}
\begin{document}
  \maketitle
  \begin{multicols}{3}[]
    ${passwords}
  \end{multicols}
\end{document}
" > "${OUTDIR}${fileName}.tex"
################
