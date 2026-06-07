\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{posudok_oponent}[2025/06/14 Trieda pre posudok oponenta BP]

\LoadClass[12pt,a4paper]{article}

\usepackage[slovak]{babel}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{listings}
\usepackage[top=0.63in, bottom=0.89in, left=0.98in, right=0.79in]{geometry}
\usepackage{longtable}
\usepackage{array}
\usepackage{setspace}
\usepackage{tabularx}
\usepackage{fancyhdr}
\usepackage{expl3}
\usepackage{xfp}
\usepackage{tabularx}
\usepackage{lipsum}
\usepackage{multirow}
\usepackage{xurl}
\usepackage{indentfirst}

\usepackage{enumitem}
% Nastavenie štýlov pre itemize
\setlist[itemize,1]{label=--}
% Nastavenie štýlov pre enumerate
\setlist[enumerate,2]{label=\alph*., ref=\theenumi\alph*}

\lstset{
  extendedchars=true,
  literate=
    {á}{{\'a}}1
    {ä}{{\"a}}1
    {č}{{\v{c}}}1
    {ď}{{\v{d}}}1
    {é}{{\'e}}1
    {í}{{\'i}}1
    {ĺ}{{\'l}}1
    {ľ}{{\v{l}}}1
    {ň}{{\v{n}}}1
    {ó}{{\'o}}1
    {ô}{{\^o}}1
    {ŕ}{{\'{r}}}1
    {š}{{\v{s}}}1
    {ť}{{\v{t}}}1
    {ú}{{\'u}}1
    {ý}{{\'y}}1
    {ž}{{\v{z}}}1
    {Á}{{\'A}}1
    {Ä}{{\""A}}1
    {Č}{{\v{C}}}1
    {Ď}{{\v{C}}}1
    {É}{{\'E}}1
    {Í}{{\'I}}1
    {Ĺ}{{\'L}}1
    {Ľ}{{\v{L}}}1
    {Ň}{{\v{N}}}1
    {Ó}{{\'O}}1
    {Ô}{{\^O}}1
    {Ŕ}{{\'{R}}}1
    {Š}{{\v{S}}}1
    {Ť}{{\v{T}}}1
    {Ú}{{\'U}}1
    {Ý}{{\'Y}}1
    {Ž}{{\v{Z}}}1
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{1em}
\onehalfspacing

\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}
\renewcommand{\arraystretch}{1.3}

\def\@den{\number\day}
\def\@mesiac{\number\month}
\def\@rok{\number\year}
\newcommand\MyDate[3]{\def\@den{#1}
    \def\@mesiac{#2}
    \def\@rok{#3}}
\newcommand{\printDate}{\@den.\ \@mesiac.\ \@rok}

% =======================
% Automatické výpočty
% =======================

% Spočítaj všetky body
\ExplSyntaxOn
\newcommand{\ComputeTotalPoints}{
  \int_zero_new:N \l_tmpa_int
  \int_set:Nn \l_tmpa_int {
    \bodyAnalyza + \bodyZdroje +
    \bodyNavrh +
    \bodyRealizacia + \bodyZdovodnenie + \bodyTeoria +
    \bodyPrezentacia + \bodyExperiment + \bodyZhodnotenie +
    \bodyDokumentacia +
    \bodyFormalna + \bodyPrejav + \bodyNarocnost
  }
  \edef\bodySpolu{\int_use:N \l_tmpa_int}
}
\ExplSyntaxOff

% Urči známku podľa rozsahu bodov
\newcommand{\AutoGrade}{
  \ComputeTotalPoints
  \def\finalGrade{}
  \ifnum\bodySpolu>91
    \def\finalGrade{výborne}
  \else\ifnum\bodySpolu>82
    \def\finalGrade{veľmi dobre}
  \else\ifnum\bodySpolu>73
    \def\finalGrade{dobre}
  \else\ifnum\bodySpolu>64
    \def\finalGrade{uspokojivo}
  \else\ifnum\bodySpolu>55
    \def\finalGrade{dostatočne}
  \else
    \def\finalGrade{nedostatočne}
  \fi\fi\fi\fi\fi
}

% Urči odporúčanie práce
\newcommand{\AutoRecommendation}{
  \ifnum\bodySpolu>55
    \def\recommendation{odporúčam}
  \else
    \def\recommendation{neodporúčam}
  \fi
}

% =======================
% Premenné - hlavička
% =======================
\newcommand{\studentName}{}
\newcommand{\studyProgram}{}
\newcommand{\thesisTitle}{}
\newcommand{\opponentName}{}
\newcommand{\crzpRatio}{}

\newcommand{\setStudentName}[1]{\renewcommand{\studentName}{#1}}
\newcommand{\setStudyProgram}[1]{\renewcommand{\studyProgram}{#1}}
\newcommand{\setThesisTitle}[1]{\renewcommand{\thesisTitle}{#1}}
\newcommand{\setOpponentName}[1]{\renewcommand{\opponentName}{#1}}
\newcommand{\setCrzpRatio}[1]{\renewcommand{\crzpRatio}{#1}}


% =======================
% Premenné - bodové hodnotenie
% =======================
\newcommand{\bodyAnalyza}{}
\newcommand{\bodyZdroje}{}
\newcommand{\bodyNavrh}{}
\newcommand{\bodyRealizacia}{}
\newcommand{\bodyZdovodnenie}{}
\newcommand{\bodyTeoria}{}
\newcommand{\bodyPrezentacia}{}
\newcommand{\bodyExperiment}{}
\newcommand{\bodyZhodnotenie}{}
\newcommand{\bodyDokumentacia}{}
\newcommand{\bodyFormalna}{}
\newcommand{\bodyPrejav}{}
\newcommand{\bodyNarocnost}{}
\newcommand{\bodySpolu}{}

% =======================
% Komponenty - zobrazenie
% =======================
\newcommand{\DrawHeader}{
  \begin{center}
    \Large \textbf{Posudok oponenta bakalárskej práce}
  \end{center}

  \vspace{-1em}

  \noindent
  \begin{tabularx}{\textwidth}{@{}l>{\raggedright\arraybackslash}X@{}}
    \textbf{Meno študenta:} & \studentName \\
    \textbf{Študijný program:} & \bf{\studyProgram} \\
    \textbf{Názov bakalárskej práce:} & \thesisTitle \\
    \textbf{Meno oponenta BP:} & \opponentName \\
  \end{tabularx}

  \vspace{1em}
}

\newcommand{\DrawEvaluationTable}{
\ComputeTotalPoints
\textbf{Hodnotenie} bakalárskej práce (bodové):

\begin{table}[h]
\begin{tabular}{|l|ll|r|r|}
\hline
                   & \multicolumn{2}{c|}{\textbf{Kritériá bodového hodnotenia}}                                                            & \begin{tabular}[c]{@{}l@{}}Max.\\ počet\\ bodov\end{tabular} & \begin{tabular}[c]{@{}l@{}}Získané\\ body\end{tabular} \\ \hline
\multirow{2}{*}{1} & \multicolumn{1}{l|}{\multirow{2}{*}{\begin{tabular}[c]{@{}l@{}}Analýza\\ problematiky\end{tabular}}}                                                                                                     & Prehľad súčasného stavu problematiky a teoretický rozbor                                                                                                                         & 10 & \bodyAnalyza \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Práca s literárnymi zdrojmi                              & 5 & \bodyZdroje \\ \hline
2                  & \multicolumn{2}{l|}{Návrh riešenia – Formulácia obmedzení, postupov a cieľov}                                          & 10 & \bodyNavrh \\ \hline
\multirow{3}{*}{3} & \multicolumn{1}{l|}{\multirow{3}{*}{\begin{tabular}[c]{@{}l@{}}Realizácia\\ úloh\end{tabular}}}       & Názornosť pri dokumentovaní priebehu realizácie          & 10 & \bodyRealizacia \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Zdôvodnenie postupov a realizovaných krokov              & 5 & \bodyZdovodnenie \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Praktické využitie teoretických poznatkov                & 5 & \bodyTeoria \\ \hline
\multirow{3}{*}{4} & \multicolumn{1}{l|}{\multirow{3}{*}{\begin{tabular}[c]{@{}l@{}}Prezentácia\\ výsledkov\end{tabular}}} & Funkčnosť riešenia a metodika jej overenia                                                                                                                                    & 5 & \bodyPrezentacia \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Experimentálne overenie vlastností riešenia              & 10 & \bodyExperiment \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Vlastné kvalitatívne zhodnotenie výsledkov               & 5 & \bodyZhodnotenie \\ \hline
5                  & \multicolumn{2}{l|}{Technická a programová dokumentácia (v prílohe, na priloženom médiu)}      & 10 & \bodyDokumentacia \\ \hline
\multirow{3}{*}{6} & \multicolumn{1}{l|}{\multirow{3}{*}{\begin{tabular}[c]{@{}l@{}}Celkové\\ hodnotenie\end{tabular}}}    & Formálna úroveň                  & 5 & \bodyFormalna \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Úroveň písomného prejavu                                 & 10 & \bodyPrejav \\ \cline{3-5} 
                   & \multicolumn{1}{l|}{}                                       & Náročnosť, pôvodnosť a využiteľnosť                      & 10 & \bodyNarocnost \\ \hline
                   & \multicolumn{1}{l|}{\textbf{Spolu}}                         &                                                          & \textbf{100} & \textbf{\bodySpolu} \\ \hline
\end{tabular}
\end{table}
}

\newcommand{\DrawWordEvaluation}[1]{
    Slovné hodnotenie: \\
    \input{#1}
}

\newcommand{\DrawNotesAndQuestions}[1]{
    \vspace{1em}
    \newline
    Pripomienky a otázky oponenta: \\
    \vspace{-1em}
    \input{#1}
}

\newcommand{\printOriginalityStatement}[1]{
    Stanovisko k výsledku kontroly originality bakalárskej práce: \\
    Protokol o kontrole originality preukázal mieru zhody s indexom prác korpusu CRZP \crzpRatio\ \%.
    \input{#1}
    \newline
}

\newcommand{\DrawAutoGrade}{
  \AutoGrade
  \newline
  Hodnotenie známkou: \textbf{\finalGrade}
  \newline
}

\newcommand{\DrawRecommendation}{
  \AutoRecommendation
  \newline
  Bakalársku prácu \textbf{\recommendation{}} na obhajobu.
  \newline
}

\newcommand{\DrawFooter}{
\vspace{1em}
\newline
Dňa: \printDate

\vspace{3em}

\begin{flushright}
  \makebox[6cm]{\dotfill} \\ % riadok bodiek (šírka nastaviteľná)
  \makebox[6cM]{\centering \small podpis oponenta}
\end{flushright}
}

\newcommand{\DrawEvaluationCriteria}[1]{
    \newpage
    \pagestyle{plain}
    \textbf{\large Príloha: Kritériá bodového hodnotenia}
    \input{#1}
}
