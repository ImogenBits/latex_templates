\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}[2022/09/10 Assignment sheet class]
\LoadClass[a4paper,11pt]{article}

\RequirePackage[a4paper, left=2cm, right=4.5cm, top=2cm, bottom=2cm]{geometry}
\RequirePackage{xkeyval, pdftexcmds, etoolbox}
\RequirePackage[skip=2\baselineskip]{parskip}
\RequirePackage{titlesec}


\newcommand{\wordAssignment}{Assignment}
\newcommand{\wordGroup}{Group}
\newcommand{\wordTotalPoints}{Total points}
\newcommand{\wordExercise}{Exercise}
\DeclareOptionX{german}{
    \renewcommand{\wordAssignment}{Übung}
    \renewcommand{\wordGroup}{Gruppe}
    \renewcommand{\wordTotalPoints}{Gesamtpunkte}
    \newcommand{\wordExercise}{Aufgabe}
}

\renewcommand{\thesection}{\wordExercise{} \arabic{section}}
\renewcommand{\thesubsection}{\alph{subsection})}
\renewcommand{\thesubsubsection}{\roman{subsubsection})}
\titleformat{\subsection}[runin]{}{\thesubsection}{1em}{}[]
\titleformat{\subsubsection}[runin]{}{\thesubsubsection}{1em}{}[]

\newcommand{\printpointsline}{}
\DeclareOptionX{pointsbox}{
    \renewcommand{\printpointsline}{
        \hfill
        \begin{Form}
        \wordTotalPoints: \TextField[name=points, width=20mm, align=1, bordercolor={0 0 0}]{}
        \end{Form}
        \vspace{\baselineskip} \\
    }
}

\ProcessOptionsX

\newcommand{\printcourse}{}
\newcommand{\course}[1]{\renewcommand{\printcourse}{#1}}

\newcommand{\printgroup}{}
\newcommand{\group}[1]{\renewcommand{\printgroup}{#1}}

\newcommand{\printassignment}{}
\newcommand{\assignment}[1]{\renewcommand{\printassignment}{#1}}

\newcommand{\pdfmembers}{}
\newcommand{\fmtmembers}{}
\newcommand{\member}[2]{
    \expandafter\renewcommand\expandafter\fmtmembers\expandafter{\fmtmembers#1 & #2 \\}
    \expandafter\renewcommand\expandafter\pdfmembers\expandafter{\pdfmembers#1, #2; }
}

\newcounter{lastyear}
\setcounter{lastyear}{\numexpr \year - 1 \relax}

\renewcommand{\maketitle}{
    {\centering
    {\raggedright
    \begin{tabular}{l}
        \ifdefvoid{\printcourse}{}{
        \printcourse \\
        \ifnum \month<4 WS \arabic{lastyear} \else \ifnum \month>9 WS \else SS \fi \the\year \fi \\}
        \ifdefvoid{\printgroup}{}{\wordGroup{} \printgroup \\}
    \end{tabular}}
    %
    \ifdefvoid{\printcourse}{\ifdefvoid{\printgroup}{}{\hfill}}{\hfill}
    {\Large \wordAssignment{} \printassignment}
    %
    \ifdefvoid{\fmtmembers}{}{
        \hfill
        \begin{tabular}{l l}
            \fmtmembers
        \end{tabular}
    }\par}

    \hrule
    \vspace{\baselineskip}
}

\AtBeginDocument{
    \@ifpackageloaded{hyperref}{
        \hypersetup{
            pdftitle = {\printcourse{} \wordAssignment{} \printassignment},
            pdfauthor = {\wordGroup{} \printgroup: \pdfmembers},
            pdfsubject = {\printcourse}
        }
    }

    \printpointsline
    \maketitle    
}


