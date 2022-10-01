\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}[2022/09/10 Assignment sheet class]
\LoadClass[a4paper,11pt]{article}

\RequirePackage[a4paper, left=2cm, right=4.5cm, top=2cm, bottom=2cm]{geometry}
\RequirePackage{xkeyval, pdftexcmds, etoolbox}


\newcommand{\wordAssignment}{}
\newcommand{\wordGroup}{}
\newcommand{\wordTotalPoints}{}
\DeclareOptionX{language}[english]{
    \ifnum\pdfstrcmp{#1}{english}=0
        \renewcommand{\wordAssignment}{Assignment}
        \renewcommand{\wordGroup}{Group}
        \renewcommand{\wordTotalPoints}{Total points}
    \fi
    \ifnum\pdfstrcmp{#1}{german}=0
        \renewcommand{\wordAssignment}{Übung}
        \renewcommand{\wordGroup}{Gruppe}
        \renewcommand{\wordTotalPoints}{Gesamtpunkte}
    \fi
}

\newcommand{\printcourse}{}
\newcommand{\course}[1]{\renewcommand{\printcourse}{#1}}
\DeclareOptionX{course}[]{
    \course{#1}
}

\newcommand{\printgroup}{}
\newcommand{\group}[1]{\renewcommand{\printgroup}{#1}}
\DeclareOptionX{group}[]{
  \group{#1}
}

\newcommand{\printsheet}{}
\newcommand{\sheet}[1]{\renewcommand{\printsheet}{#1}}
\DeclareOptionX{sheet}[]{
  \sheet{#1}
}

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

\ExecuteOptionsX{group, course, sheet, language}
\ProcessOptionsX

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
    {\Large \wordAssignment{} \printsheet}
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
            pdftitle = {\printcourse{} \wordAssignment{} \printsheet},
            pdfauthor = {\wordGroup{} \printgroup: \pdfmembers},
            pdfsubject = {\printcourse}
        }
    }
    \printpointsline
    \maketitle    
}


