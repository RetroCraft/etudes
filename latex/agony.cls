\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{agony}

%
% Options
%

\RequirePackage{kvoptions}
\DeclareStringOption{class}
\DeclareBoolOption{tikz}
\DeclareBoolOption{minted}
\DeclareBoolOption{nogeometry}
\DeclareBoolOption{notes}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*
\ifagony@notes\LoadClass[11pt]{report}\else\LoadClass[11pt]{article}\fi

%
% Load packages
%

\usepackage{xparse}
\usepackage{xspace}

% Typography
\usepackage[english]{babel}
\usepackage{iftex}
\usepackage{amsfonts,amssymb}
\usepackage{unicode-math}
\setmathfont{latinmodern-math.otf}
% fixes because latinmodern-math is dumb
\setmathfont[range=bb]{texgyrepagella-math.otf}[AutoFakeBold=3] % restore nice-looking ℝ 
\setmathfont[range={scr,bfscr},StylisticSet=01]{STIX Two Math} % restore distinct mathcal/mathscr
\AtBeginDocument{
  \renewcommand\setminus{\smallsetminus} % ∖ should be small to look like an operator
  \renewcommand\varnothing{\diameter} % ∅ should obviously be
}

% Fancy underline for iondexed terms
\usepackage{contour}
\usepackage[normalem]{ulem}
\renewcommand{\ULdepth}{1.8pt}
\contourlength{0.8pt}
\newcommand{\myuline}[1]{%
  \uline{\phantom{#1}}%
  \llap{\contour{white}{#1}}%
}
\NewDocumentCommand\term{sO{#3}m}{\myuline{#3}\IfBooleanF#1{\index{#2}}}

% Formatting
\usepackage[titles]{tocloft}
\addto\captionsenglish{\renewcommand{\contentsname}{\@title}}
\usepackage{titlesec}
\usepackage{multicol,collcell}
\usepackage[dvipsnames,table]{xcolor}
\usepackage{array} % for \newcolumntype macro

\usepackage{enumerate}
\usepackage{paralist}
\usepackage[shortlabels]{enumitem} % remove space before enums
\setlist[enumerate]{topsep=0pt}
\setlist[enumerate,1]{label={(\alph*)}}
\setlist[enumerate,2]{label={(\roman*)}}

% Math
\usepackage{amsmath}
\usepackage{physics}
\usepackage{cancel}
\usepackage{systeme}
\sysdelim.. % no curly braces
\usepackage{mathtools} % for \DeclarePairedDelimiter macro
\@ifpackageloaded{unicode-math}{
  \let\underbrace\LaTeXunderbrace
  \let\overbrace\LaTeXoverbrace
  \AtBeginDocument{
    % See https://github.com/wspr/unicode-math/issues/457
    \renewcommand{\Re}{\operatorname{Re}}
    \renewcommand{\Im}{\operatorname{Im}}
  }
}{}

% See https://tex.stackexchange.com/questions/510506/conflict-between-flexisym-and-polynom-packages
% \catcode`^=12 \catcode`_=12
\usepackage{polynom}
% \catcode`^=7 \catcode`_=8

% Figures
\ifagony@tikz
  \RequirePackage{tikz,pgfplots,transparent,annotate-equations}
  \pgfplotsset{compat=1.15}
  \usepgfplotslibrary{fillbetween}
  \usetikzlibrary{patterns,positioning,shapes,calc,chains,tikzmark}
  \tikzset{
    vertalign/.style = {
      baseline={([yshift=-.8ex]current bounding box.center)}
    },
    annotate equations/text/.style={font=\footnotesize},
  }
\fi

\ifagony@minted
  \@namedef{ver@framed.sty}{9999/12/31} % see gpoore/minted#181
  \@namedef{opt@framed.sty}{}
  \RequirePackage{minted}
  \usemintedstyle{tango}
  \newminted{pseudo}{autogobble,mathescape,escapeinside=@@,linenos}
\fi

%
% Styles
%

\ifagony@nogeometry\else
  \usepackage{geometry}
  \geometry{letterpaper,margin=1in}
  % increase header for fancyhdr
  \setlength{\headheight}{15pt}
  \setlength{\topmargin}{-20pt}
  \setlength{\headsep}{1.5ex}
  
  \RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \fancyhf{}
  \fancyfoot[c]{\thepage}
  \lhead{\@title}
  \rhead{\@author}

  \fancypagestyle{firstpage}{
    \fancyhf{}
    \rhead{\@author}
    \fancyfoot[c]{\thepage}
  }
\fi
\setlength{\parskip}{1.5ex}
\parindent=0pt

\author{James Ah Yong}

% Links
\usepackage{imakeidx,bookmark,hyperref}
\RequirePackage[capitalise]{cleveref}
\hypersetup{
  colorlinks,
  linkcolor=RoyalBlue,
  linktoc=all
}

%
% Macros
%

\newcommand{\thetitle}{\@title}

% Cute initialisms (with versions for start of sentences)
\newcommand{\Wlog}{\textsc{wlog}\xspace}
\newcommand{\WLOG}{\textsc{Wlog}\xspace}
\newcommand{\Tfae}{\textsc{tfae}\xspace}
\newcommand{\TFAE}{\textsc{Tfae}\xspace}
\newcommand{\xth}{\textsuperscript{th}\xspace}

% Typesetting
\newcolumntype{C}{>{$}c<{$}} % math version of "C" column type

% Sets
\newcommand{\bb}{\mathbb}
\newcommand{\N}{\ensuremath{\mathbb{N}}}
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}
\newcommand{\R}{\ensuremath{\mathbb{R}}}
\newcommand{\C}{\ensuremath{\mathbb{C}}}
\newcommand{\F}{\ensuremath{\mathbb{F}}}
\let\U\@undefined
\newcommand{\U}{\ensuremath{\mathcal{U}}}
\let\O\@undefined
\newcommand{\O}{\ensuremath{\mathcal{O}}}
\newcommand{\sym}{\mathbin{\triangle}}

% Functions
\DeclareMathOperator{\id}{id}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\im}{im}
\DeclareMathOperator{\lcm}{lcm}
\DeclareMathOperator{\cis}{cis}

% Operators
\newcommand{\from}{\leftarrow}
\newcommand{\toto}{\rightrightarrows}
\newcommand{\tofrom}{\rightleftarrows}
\newcommand{\Rarr}{\Rightarrow}
\newcommand{\Larr}{\Leftarrow}
\newcommand{\Harr}{\Leftrightarrow}
\newcommand{\harr}{\leftrightarrow}
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
\newcommand{\dyx}{\dv{y}{x}}

% Category Theory
\newcommand{\cat}[1]{\mathsf{#1}}
\renewcommand{\op}{^{\cat{op}}} % overrides physics.sty \op for \outerproduct
\DeclareMathOperator{\Obj}{Obj}
\newcommand{\Hom}[1][]{\ifthenelse{\isempty{#1}}{\operatorname{Hom}}{\operatorname{Hom}_{\cat{#1}}}}
\newcommand{\End}[1][]{\ifthenelse{\isempty{#1}}{\operatorname{End}}{\operatorname{End}_{\cat{#1}}}}
\newcommand{\mono}{\rightarrowtail}
\newcommand{\epic}{\twoheadrightarrow}
\newcommand{\into}{\hookrightarrow}

% Linear Algebra
\newcommand{\trans}{^{\intercal}} % Transpose
\newcommand{\xto}{\xrightarrow} % \xto{R_1 \harr R_2}
\DeclareMathOperator{\Proj}{Proj}
\DeclareMathOperator{\Perp}{Perp}
\DeclareMathOperator{\Span}{Span}
\DeclareMathOperator{\Col}{Col}
\DeclareMathOperator{\adj}{adj}
% add optional argument for augmented matrices to ams *matrix environments and physics bmqty (tex.se 2233)
\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
  \hskip -\arraycolsep%
  \let\@ifnextchar\new@ifnextchar%
  \array{#1}}
\RenewDocumentCommand{\bmqty}{om}{\IfValueTF{#1}{\begin{bmatrix}[#1]#2\end{bmatrix}}{\begin{bmatrix}#2\end{bmatrix}}}
\RenewDocumentCommand{\pmqty}{om}{\IfValueTF{#1}{\begin{pmatrix}[#1]#2\end{pmatrix}}{\begin{pmatrix}#2\end{pmatrix}}}
% function mqty
\newcommand{\fmqty}[1]{\pqty{\pmqty{#1}}}
% allow redefinition of inner product separator
\newcommand{\ipsep}{\middle\vert}
\RenewDocumentCommand{\innerproduct}{ s m g }
{\IfBooleanTF{#1}
  { % No resize
    \IfNoValueTF{#3}
    {\vphantom{#2}\left\langle\smash{#2}\ipsep\smash{#2}\right\rangle}
    {\vphantom{#2#3}\left\langle\smash{#2}\ipsep\smash{#3}\right\rangle}
  }
  { % Auto resize
    \IfNoValueTF{#3}
    {\left\langle{#2}\ipsep{#2}\right\rangle}
    {\left\langle{#2}\ipsep{#3}\right\rangle}
  }}

% Layout, boxes, etc.
\input{agony-note.tex}
