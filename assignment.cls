\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}[2022/09/10 Assignment sheet class]
\LoadClass[a4paper,11pt]{article}

\RequirePackage[hidelinks, unicode]{hyperref}
\RequirePackage[a4paper, left=3cm, right=3cm, top=2cm, bottom=3cm]{geometry}
\RequirePackage{xkeyval, xparse, pdftexcmds}


\newcommand{\printgroup}{}
\newcommand{\group}[1]{\renewcommand{\printgroup}{#1}}
\define@key{assignment.cls}{group}[???]{
  \group{#1}
}

\newcommand{\printcourse}{}
\newcommand{\course}[1]{\renewcommand{\printcourse}{#1}}
\define@key{assignment.cls}{course}[]{
    \course{#1}
}

\newcommand{\printsheet}{}
\newcommand{\sheet}[1]{\renewcommand{\printsheet}{#1}}
\define@key{assignment.cls}{sheet}[0]{
  \sheet{#1}
}
\newcommand{\wordAssignment}{Assignment Sheet}
\newcommand{\wordGroup}{Group}
\newcommand{\wordTotalPoints}{Total points}
\define@key{assignment.cls}{language}[english]{
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

\ExecuteOptionsX{group, course, sheet, language}
\ProcessOptionsX

\newcommand{\pdfmembers}{}
\newcommand{\fmtmembers}{}
\newcommand{\member}[2]{
    \expandafter\renewcommand\expandafter\fmtmembers\expandafter{\fmtmembers#1 & #2 \\}
    \expandafter\renewcommand\expandafter\pdfmembers\expandafter{\pdfmembers#1, #2; }
}


\AtBeginDocument{
    \hypersetup{
        pdftitle = {\wordAssignment{} \printsheet},
        pdfauthor = {\wordGroup{} \printgroup: \pdfmembers},
        pdfsubject = {\printcourse}
    }
    
    \hfill
    \begin{Form}
    \begin{tabular}{c}
    \\
    \wordTotalPoints: \raisebox{-5pt}{\TextField[name=points, width=20mm, align=1, bordercolor={0 0 0}]{}} \\
    \\
    \end{tabular}
    \end{Form}
    
    {\raggedright
    \begin{tabular}{l}
        \printcourse \\
        \ifnum \month<4 WS \else \ifnum \month>9 WS \else SS \fi \fi \the\year \\
        \wordGroup{} \printgroup \\
    \end{tabular}}
    \hfill
    {\Large \wordAssignment{} \printsheet}
    \hfill
    \begin{tabular}{l l}
        \fmtmembers
    \end{tabular}
    
    \hrule
    \vspace{\baselineskip}
}


