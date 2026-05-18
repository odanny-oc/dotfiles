local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

ls.config.setup({
    updateevents = 'TextChanged, TextChangedI',
})


vim.keymap.set({ "i", "s" }, "<A-n>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

--keybinds for insert nodes
--
vim.keymap.set({"i", "s"}, "<A-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({"i", "s"}, "<A-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- Functions

local function generate_label(args)
    local title = args[1][1] or ""
    -- Convert to lowercase, replace spaces with hyphens, 
    -- and remove special characters for a clean label
    local label = title:lower():gsub("%s+", "_"):gsub("[^%w%-_]", "")
    return  label
end

local function match_bracket(args)
    local opening = args[1][1]
    local brackets = {
        ["("] = ")",
        ["\\{"] = "\\}",
        ["["] = "]",
        ["|"] = "|",
        ["\\langle"] = "\\rangle"
    }
    return brackets[opening] or ""
end

--examples
ls.add_snippets("lua", {
    s("hello",{
        t('print("hello world")')
    }),

--insert nodes (work like $ in json)
    s("if", {
        t('if '),
        i(1, "true"),
        i(2),
        t(' end')
 }),
})

-- tex snippets 
ls.add_snippets('tex', {
-- Example
s("beg", fmt(
[[
\begin{{{}}}
    {}  
\end{{{}}}
]],{
    i(1), i(0), rep(1)
})),
s("prebib", fmt(
[[
\documentclass[12pt]{{article}}
\usepackage{{mathtools}}
\usepackage{{multicol}}
\usepackage{{physics}}
\usepackage{{amssymb}} %maths stuff%
\usepackage{{esint}} %for integrals
\setcounter{{tocdepth}}{{4}} %subsubsections in toc
\setlength{{\parindent}}{{0pt}} %no indent
\usepackage[hidelinks]{{hyperref}}
\usepackage[nameinlink, noabbrev]{{cleveref}} %refs
\usepackage[nottoc]{{tocbibind}}
\usepackage{{tikz}} %old figures package
\usepackage{{pythonhighlight}} % insert python code \begin{{python}}
\hfuzz=16pt
% \usepackage{{siunitx}} %for tables
\usepackage{{import}}
\usepackage{{caption}}
\usepackage[dvipsnames]{{xcolor}} %for coloured text
\usepackage{{subcaption}} %for subfigures
\usepackage{{pstool}}
\usepackage{{xifthen}}
\usepackage{{pdfpages}}
\usepackage{{transparent}}
\usepackage{{graphicx}}
\usepackage{{scalefnt}}
\usepackage[inkscapelatex=false]{{svg}}
\usepackage{{wrapfig}}
\usepackage{{lmodern}}
\usepackage[T1]{{fontenc}}
\usepackage{{fancyhdr}} % Custom headers and footers
\usepackage[a4paper, left=20mm, right=20mm, top=20mm, bottom=20mm]{{geometry}}
\usepackage{{array}}

\pagestyle{{fancyplain}} % Makes all pages in the document conform to the custom headers and footers
\fancyhead{{}} % No page header - if you want one, create it in the same way as the footers below

\fancyfoot[L]{{}} % Empty left footer
\fancyfoot[C]{{}} % Empty center footer
\fancyfoot[R]{{\thepage}} % Page numbering for right footer
\renewcommand{{\headrulewidth}}{{0pt}} % Remove header underlines
\renewcommand{{\footrulewidth}}{{0pt}} % Remove footer underlines

%\renewcommand{{\figurename}}{{fig}} %allows custom figure numbering
\renewcommand{{\tablename}}{{Table}}

%
\makeatletter
\def\smallunderbrace#1{{\mathop{{\vtop{{\m@th\ialign{{##\crcr
   $\hfil\displaystyle{{#1}}\hfil$\crcr
   \noalign{{\kern3\p@\nointerlineskip}} %creates \smallunderbrace command
   \tiny\upbracefill\crcr\noalign{{\kern3\p@}}}}}}}}\limits}}
\makeatother
%

\def\bibname{{\normalsize{{Bibliography}}}}\let\refname\bibname %set bibliography name

\title{{{}}}

\author{{O. Daniel O'Carroll\\
\small{{{{22337259}}}}\\
\small{{\href{{mailto:oocarrol@tcd.ie}}{{oocarrol@tcd.ie}}}}
}}\\
\date{{\today}}
\begin{{document}}
\maketitle
\tableofcontents
\pagebreak
%
{}
%
\pagebreak
\begin{{thebibliography}}{{999}}
%
\end{{thebibliography}}
\end{{document}}
]], {
i(1), i(2)}
)),
s("prebeamer", fmt(
[[
\documentclass[12pt]{{beamer}}
\usetheme{{CambridgeUS}}
\usepackage{{mathtools}}
\usepackage[normalem]{{ulem}}
\usepackage{{multicol}}
\usepackage{{physics}}
\usepackage{{amssymb}} %maths stuff%
\usepackage{{esint}} %for integrals
\setcounter{{tocdepth}}{{4}} %subsubsections in toc
\setlength{{\parindent}}{{0pt}} %no indent
% \usepackage[nameinlink, noabbrev]{{cleveref}} %refs
% \usepackage[hidelinks]{{hyperref}}" ,
% \usepackage[nottoc]{{tocbibind}}
\usepackage{{tikz}} %old figures package
\usepackage{{pythonhighlight}} % insert python code \begin{{python}}
\hfuzz=16pt
% \usepackage{{siunitx}} %for tables
\usepackage{{import}}
\usepackage{{caption}}
\usepackage[dvipsnames]{{xcolor}} %for coloured text
\usepackage{{subcaption}} %for subfigures
\usepackage{{pstool}}
\usepackage{{xifthen}}
\usepackage{{pdfpages}}
\usepackage{{transparent}}
\usepackage{{graphicx}}
\usepackage{{scalefnt}}
\usepackage[inkscapelatex=false]{{svg}}
\usepackage{{wrapfig}}
\usepackage{{lmodern}}
\usepackage[T1]{{fontenc}}
\geometry{{paperwidth=16cm,paperheight=9cm}}
\usepackage{{array}}
\usepackage{{movie15}}
% in documenet

\setbeamertemplate{{navigation symbols}}{{}}
\setbeamertemplate{{footline}}{{\insertframenumber}}
\setbeamertemplate{{itemize items}}[circle]
\setbeamertemplate{{enumerate items}}[default]
\setbeamercolor{{item}}{{fg=red}}
\usefonttheme[onlymath]{{serif}}

%\renewcommand{{\figurename}}{{fig}} %allows custom figure numbering
\renewcommand{{\tablename}}{{Table}}

%
\makeatletter
\def\smallunderbrace#1{{\mathop{{\vtop{{\m@th\ialign{{##\crcr
   $\hfil\displaystyle{{#1}}\hfil$\crcr
   \noalign{{\kern3\p@\nointerlineskip}} %creates \smallunderbrace command
   \tiny\upbracefill\crcr\noalign{{\kern3\p@}}}}}}}}\limits}}
\makeatother
%

\captionsetup[figure]{{labelformat=empty}}

\renewcommand{{\backgroundPath}}{{/home/danny/Pictures/uhj_phases.jpg}}
% \graphicspath{{/home/danny/exoplanet_atmospheres/images}}

\usepackage{{fancybox}}
\usepackage{{empheq}}
\usepackage{{tcolorbox}} %Boxes for theorems and definitions
\tcbuselibrary{{theorems}}

\newtcbtheorem[number within=section]{{mydef}}{{}}%
{{colback=White!20,colframe=Black!90!black,fonttitle=\bfseries}}{{def}}

\newcommand{{\beamereq}}[2]{{%
\begin{{mydef*}}{{#1}}
#2
\end{{mydef*}}}}

\renewcommand{{\maketitle}}{{
    \begingroup
        \setbeamertemplate{{footline}}{{}}
        \setbeamertemplate{{background canvas}}{{
            \includegraphics[height=\paperheight, width = \paperwidth]{{\backgroundPath}}
        }}
        \begin{{frame}}
            \titlepage
        \end{{frame}}
    \endgroup
}}


\title{{{}}}

\setbeamercolor{{author}}{{fg=white}}
\setbeamercolor{{date}}{{fg=white}}
% \addtobeamertemplate{{title background}}{{\pgfsetfillopacity{{0.7}}}}{{\pgfsetfillopacity{{1}}}}
\author{{O. Daniel O'Carroll
    \textorpdfstring{{\\ \small{{\href{{mailto:oocarrol@tcd.ie}}{{oocarrol@tcd.ie}}}}}}}} 
\date{{\today}}
\institute[]{{Institute}}
\begin{{document}}
\maketitle
{}
\end{{document}}
]], {
i(1), i(2)}
)),
s("frame", fmt(
[[
\begin{{frame}}[t]{{{}}}
    {}
\end{{frame}}
]],
{i(1),i(2)}
)),
-- Preamble
s("pre1", fmt(
[[
\documentclass[12pt]{{article}}
\usepackage{{mathtools}}
\usepackage{{multicol}}
\usepackage{{physics}}
\usepackage{{amssymb}} %maths stuff%
\usepackage{{esint}} %for integrals
\setcounter{{tocdepth}}{{4}} %subsubsections in toc
\setlength{{\parindent}}{{0pt}} %no indent
\usepackage[hidelinks]{{hyperref}}
\usepackage[nameinlink, noabbrev]{{cleveref}} %refs
\usepackage[nottoc]{{tocbibind}}
\usepackage{{tikz}} %old figures package
\usepackage{{pythonhighlight}} % insert python code \begin{{python}}
\hfuzz=16pt
% \usepackage{{siunitx}} %for tables
\usepackage{{import}}
\usepackage{{caption}}
\usepackage[dvipsnames]{{xcolor}} %for coloured text
\usepackage{{subcaption}} %for subfigures
\usepackage{{pstool}}
\usepackage{{xifthen}}
\usepackage{{pdfpages}}
\usepackage{{transparent}}
\usepackage{{graphicx}}
\usepackage{{scalefnt}}
\usepackage[inkscapelatex=false]{{svg}}
\usepackage{{wrapfig}}
\usepackage{{lmodern}}
\usepackage[T1]{{fontenc}}
\usepackage{{fancyhdr}} % Custom headers and footers
\usepackage[a4paper, left=20mm, right=20mm, top=20mm, bottom=20mm]{{geometry}}
\usepackage{{array}}

\newcommand{{\horrule}}[1]{{\rule{{\linewidth}}{{#1}}}} % Create horizontal rule command with 1 argument of height


\pagestyle{{fancyplain}} % Makes all pages in the document conform to the custom headers and footers
\fancyhead{{}} % No page header - if you want one, create it in the same way as the footers below

\fancyfoot[L]{{}} % Empty left footer
\fancyfoot[C]{{}} % Empty center footer
\fancyfoot[R]{{\thepage}} % Page numbering for right footer
\renewcommand{{\headrulewidth}}{{0pt}} % Remove header underlines
\renewcommand{{\footrulewidth}}{{0pt}} % Remove footer underlines

%\renewcommand{{\figurename}}{{fig}} %allows custom figure numbering
\renewcommand{{\tablename}}{{Table}}

%
\makeatletter
\def\smallunderbrace#1{{\mathop{{\vtop{{\m@th\ialign{{##\crcr
   $\hfil\displaystyle{{#1}}\hfil$\crcr
   \noalign{{\kern3\p@\nointerlineskip}} %creates \smallunderbrace command
   \tiny\upbracefill\crcr\noalign{{\kern3\p@}}}}}}}}\limits}}
\makeatother
%

\title{{{}}}

\author{{O. Daniel O'Carroll\\
\small{{22337259}}\\
\small{{\href{{mailto:oocarrol@tcd.ie}}{{oocarrol@tcd.ie}}}}}}
\date{{\today}}
\begin{{document}}
\maketitle
\tableofcontents
\pagebreak
%
{}
\end{{document}}
]], {
i(1), i(0)
}
)),
-- Preamble Notes
s("prenotes", fmt(
[[
\documentclass[12pt]{{article}}
\setcounter{{tocdepth}}{{4}} %subsubsections in toc
\setlength{{\parindent}}{{0pt}} %no indent
\usepackage{{mathtools}}
\usepackage{{physics}}
\usepackage{{esint}} %for integrals
\usepackage{{amssymb}} %maths stuff%
\usepackage[dvipsnames]{{xcolor}} %for coloured text
\usepackage[hidelinks]{{hyperref}}
\usepackage[nameinlink, noabbrev]{{cleveref}}
%\usepackage[nottoc]{{tocbibind}}
\usepackage{{tikz}} %old figures package
\usepackage{{pythonhighlight}} % insert python code \begin{{python}}
\hfuzz=16pt
% \usepackage{{siunitx}} %for tables
\usepackage{{import}}
\usepackage{{caption}}
\usepackage{{subcaption}} %for subfigures
\usepackage{{pstool}}
\usepackage{{xifthen}}
\usepackage{{pdfpages}}
\usepackage{{transparent}}
\usepackage{{graphicx}}
\usepackage{{scalefnt}}
\usepackage[inkscapelatex=false]{{svg}}
\usepackage{{wrapfig}}
\usepackage{{lmodern}}
\usepackage[T1]{{fontenc}}
\usepackage{{float}}

\usepackage{{sectsty}} % Allows customizing section commands
\allsectionsfont{{\normalfont\scshape}} % Make all sections centered the default font and small caps

\usepackage{{tocloft}}
% Change the font for all Table of Contents entries (sections subsections etc.)
\renewcommand{{\cfttoctitlefont}}{{\normalfont\scshape\Large}}
\renewcommand{{\cftsecfont}}{{\normalfont\scshape}}
\renewcommand{{\cftsubsecfont}}{{\normalfont\scshape}}

% Change the font for page numbers in the Table of Contents
% \renewcommand{{\cftpagefont}}{{\normalfont\scshape}}

\usepackage{{fancybox}}
\usepackage{{empheq}}
\usepackage{{tcolorbox}} %Boxes for theorems and definitions
\tcbuselibrary{{theorems}}

\newtcbtheorem[number within=section]{{mydef}}{{Definition}}%
{{colback=White!50,colframe=Black!80!black,fonttitle=\bfseries}}{{def}}

% Automatically add definitions to the ToC
\newcommand{{\tocdef}}[3]{{%
\refstepcounter{{subsection}}
\begin{{mydef}}{{#1}}{{#2}}
    \addcontentsline{{toc}}{{subsection}}{{\protect\numberline{{\ref{{def:#2}}}}#1}}
#3
\end{{mydef}}
}}

\usepackage[a4paper, left=20mm, right=20mm,
top=20mm, bottom=20mm]{{geometry}}

%\renewcommand{{\figurename}}{{fig}} %allows custom figure numbering
\renewcommand{{\tablename}}{{Table}}

\usepackage{{fancyhdr}} % Custom headers and footers
\pagestyle{{fancyplain}} % Makes all pages in the document conform to the custom headers and footers
\fancyhead{{}} % No page header - if you want one create it in the same way as the footers below

\fancyfoot[L]{{}} % Empty left footer
\fancyfoot[C]{{}} % Empty center footer
% \fancyfoot[R]{{\thepage}} % Page numbering for right footer
\renewcommand{{\headrulewidth}}{{0pt}} % Remove header underlines
\renewcommand{{\footrulewidth}}{{0pt}} % Remove footer underlines
\setlength{{\headheight}}{{13.6pt}} % Customize the height of the header

%
\makeatletter
\def\smallunderbrace#1{{\mathop{{\vtop{{\m@th\ialign{{##\crcr
$\hfil\displaystyle{{#1}}\hfil$\crcr
\noalign{{\kern3\p@\nointerlineskip}} %creates \smallunderbrace command
\tiny\upbracefill\crcr\noalign{{\kern3\p@}}}}}}}}\limits}}
\makeatother
%
\newcommand{{\threebythree}}[9]{{
\begin{{pmatrix}}
{{#1}} & {{#2}} & {{#3}} \\
{{#4}} & {{#5}} & {{#6}} \\
{{#7}} & {{#8}} & {{#9}}
\end{{pmatrix}}
}}

\newcommand{{\twobytwo}}[4]{{
\begin{{pmatrix}}
{{#1}} & {{#2}}\\
{{#3}} & {{#4}}
\end{{pmatrix}}
}}

\newcommand{{\twobytwoasym}}[1]{{
\begin{{pmatrix}}
0 & {{#1}}\\
-{{#1}} & 0
\end{{pmatrix}}
}}

\newcommand{{\sym}}[6]{{
\begin{{pmatrix}}
{{#1}} & {{#4}} & {{#5}} \\
{{#4}} & {{#2}} & {{#6}} \\
{{#5}} & {{#6}} & {{#3}}
\end{{pmatrix}}
}}

\newcommand{{\antisym}}[3]{{
\begin{{pmatrix}}
0 & {{#1}} & {{#2}} \\
-{{#1}} & 0 & {{#3}} \\
-{{#2}} & -{{#3}} & 0
\end{{pmatrix}}
}}
%
\newcommand{{\ingen}}{{{{\smash{{\raisebox{{0.5ex}}{{\scalebox{{0.9}}{{G}}}}}}\mkern -11mu \scalebox{{1.5}}{{\text{{I}}}}}}}}

%\setcounter{{chapter}}{{1}} % Set the chapter counter to 1
\numberwithin{{equation}}{{subsection}} % Number equations within sections (i.e. 1.1 1.2 2.1 2.2 instead of 1 2 3 4)
\numberwithin{{figure}}{{subsection}} % Number figures within sections (i.e. 1.1 1.2 2.1 2.2 instead of 1 2 3 4)
\numberwithin{{table}}{{subsection}} % Number tables within sections (i.e. 1.1 1.2 2.1 2.2 instead of 1 2 3 4)

%
\newcommand{{\horrule}}[1]{{\rule{{\linewidth}}{{#1}}}} % Create horizontal rule command with 1 argument of height

%\renewcommand{{\bibname}}{{\scalefont{{.7}} Bibliography}}

\title{{%
\normalfont \normalsize
\textsc{{Senior Sophister Notes}} \\ [25pt] % Your university school and/or department name(s)
\horrule{{0.5pt}} \\ [0.4cm] % Thin top horizontal rule
\huge {} \\ % The assignment title
\horrule{{2pt}} \\ [0.5cm] % Thick bottom horizontal rule
}}
%
\author{{O. Daniel O'Carroll\\
\small{{22337259}}\\
\small{{\href{{mailto:oocarrol@tcd.ie}}{{oocarrol@tcd.ie}}}}}}
\date{{\normalsize\today}}
\begin{{document}}
%\begin{{minipage}}{{\textwidth}}
\maketitle
\tableofcontents
%\end{{minipage}}
%
\pagebreak
%
{}
\end{{document}}
]],{
i(1), i(0)
}
)
),
s("prelet", fmt(
[[
\documentclass[11pt]{{article}}
\setcounter{{tocdepth}}{{4}} %subsubsections in toc
\setlength{{\parindent}}{{0pt}} %no indent
\usepackage{{mathtools}}
\usepackage{{physics}}
\usepackage{{esint}} %for integrals
\usepackage{{amssymb}} %maths stuff%
\usepackage[dvipsnames, table]{{xcolor}} %for coloured text
\usepackage[unicode, draft=false]{{hyperref}}
\definecolor{{linkcolour}}{{rgb}}{{0,0.2,0.6}}
\hypersetup{{colorlinks,breaklinks,urlcolor=linkcolour,linkcolor=linkcolour}}
\usepackage[nameinlink, noabbrev]{{cleveref}}
%\usepackage[nottoc]{{tocbibind}}
\usepackage{{tikz}} %old figures package
\usepackage{{pythonhighlight}} % insert python code \begin{{python}}
\hfuzz=16pt
% \usepackage{{siunitx}} %for tables
\usepackage{{import}}
\usepackage{{tabularx}}
\usepackage{{caption}}
\usepackage{{subcaption}} %for subfigures
\usepackage{{pstool}}
\usepackage{{xifthen}}
\usepackage{{pdfpages}}
\usepackage{{transparent}}
\usepackage{{graphicx}}
\usepackage{{scalefnt}}
\usepackage[inkscapelatex=false]{{svg}}
\usepackage{{wrapfig}}
\usepackage{{lmodern}}
\usepackage[T1]{{fontenc}}
\usepackage{{multicol}}
\usepackage{{array}}
\usepackage{{sectsty}} % Allows customizing section commands
\allsectionsfont{{\centering\normalfont\scshape}} % Make all sections centered, the default font and small caps

\usepackage{{tocloft}}
% Change the font for all Table of Contents entries (sections, subsections, etc.)
\renewcommand{{\cfttoctitlefont}}{{\normalfont\scshape\Large}}
\renewcommand{{\cftsecfont}}{{\normalfont\scshape}}
\renewcommand{{\cftsubsecfont}}{{\normalfont\scshape}}

% Change the font for page numbers in the Table of Contents
% \renewcommand{{\cftpagefont}}{{\normalfont\scshape}}

\usepackage{{tcolorbox}} %Boxes for theorems and definitions
\tcbuselibrary{{theorems}}

\newtcbtheorem[number within=section]{{mydef}}{{Definiton}}%
{{colback=White!5,colframe=Black!35!black,fonttitle=\bfseries}}{{def}}

\newcommand{{\tocdef}}[3]{{%
\refstepcounter{{subsection}}
\begin{{mydef}}{{#1}}{{#2}}
    \addcontentsline{{toc}}{{subsection}}{{\protect\numberline{{\ref{{def:#2}}}}#1}}
#3
\end{{mydef}}
}}

\usepackage[a4paper, left=10mm, right=10mm,
 top=10mm, bottom=20mm]{{geometry}}

\renewcommand{{\figurename}}{{fig}} %allows custom figure numbering
\renewcommand{{\tablename}}{{Table}}

\usepackage{{fancyhdr}} % Custom headers and footers
\pagestyle{{fancyplain}} % Makes all pages in the document conform to the custom headers and footers
\fancyhead{{}} % No page header - if you want one, create it in the same way as the footers below

\fancyfoot[L]{{}} % Empty left footer
\fancyfoot[C]{{}} % Empty center footer
\fancyfoot[R]{{}} % Page numbering for right footer
\renewcommand{{\headrulewidth}}{{0pt}} % Remove header underlines
\renewcommand{{\footrulewidth}}{{0pt}} % Remove footer underlines
% \setlength{{\headheight}}{{13.6pt}} % Customize the height of the header

%
\makeatletter
\def\smallunderbrace#1{{\mathop{{\vtop{{\m@th\ialign{{##\crcr
    $\hfil\displaystyle{{#1}}\hfil$\crcr
    \noalign{{\kern3\p@\nointerlineskip}} %creates \smallunderbrace command
    \tiny\upbracefill\crcr\noalign{{\kern3\p@}}}}}}}}\limits}}
\makeatother
%
\newcommand{{\threebythree}}[9]{{
\begin{{pmatrix}}
{{#1}} & {{#2}} & {{#3}} \\
{{#4}} & {{#5}} & {{#6}} \\
{{#7}} & {{#8}} & {{#9}}
\end{{pmatrix}}
}}

\newcommand{{\sym}}[6]{{
\begin{{pmatrix}}
{{#1}} & {{#4}} & {{#5}} \\
{{#4}} & {{#2}} & {{#6}} \\
{{#5}} & {{#6}} & {{#3}}
\end{{pmatrix}}
}}

\newcommand{{\antisym}}[3]{{
\begin{{pmatrix}}
0 & {{#1}} & {{#2}} \\
-{{#1}} & 0 & {{#3}} \\
-{{#2}} & -{{#3}} & 0
\end{{pmatrix}}
}}
%
%\setcounter{{chapter}}{{1}} % Set the chapter counter to 1
\numberwithin{{equation}}{{subsection}} % Number equations within sections (i.e. 1.1, 1.2, 2.1, 2.2 instead of 1, 2, 3, 4)
\numberwithin{{figure}}{{subsection}} % Number figures within sections (i.e. 1.1, 1.2, 2.1, 2.2 instead of 1, 2, 3, 4)
\numberwithin{{table}}{{subsection}} % Number tables within sections (i.e. 1.1, 1.2, 2.1, 2.2 instead of 1, 2, 3, 4)

%
\newcommand{{\horrule}}[1]{{\rule{{\linewidth}}{{#1}}}} % Create horizontal rule command with 1 argument of height

%\renewcommand{{\bibname}}{{\scalefont{{.7}} Bibliography}}

\begin{{document}}
\begin{{center}}
    \horrule{{0.5pt}} \\ [0.4cm] % Thin top horizontal rule
    \Large O. Daniel O'Carroll\\ % The assignment title
    \small{{\href{{mailto:oocarrol@tcd.ie}}{{oocarrol@tcd.ie}}}}\\
    \small {}
    \horrule{{2pt}} \\ [0.5cm] % Thick bottom horizontal rule
\end{{center}}
{}
\end{{document}}
]], {
i(1), i(2)
}
)),
-- Table
s("tab", fmt(
[[
\renewcommand{{\thetable}}{{{}}}
\begin{{table}}[H]
	\begin{{center}}
		\begin{{tabular}}{{|c|c|c|{}}}
			\hline
			\textbf{{{}}} & \textbf{{{}}} & \textbf{{{}}}\\
			\hline
			{} & {} & {} \\
			\hline
		\end{{tabular}}
		\caption{{{}}}
		\label{{tab{}}}
	\end{{center}}
\end{{table}}
]],{
i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), rep(1)
}
)),
-- CSVTable
s("csvtab", fmt(
[[
\renewcommand{{\thetable}}{{{}}}
\begin{{table}}[ht!]
	\begin{{center}}
		\csvreader[tabular=|l|c|c|
    table head=\hline {}\\ \hline\hline
		late after line=\\ \hline
    {{{}.csv}}{{{}}}%
    {{\csvcoli & {}}}
    \caption{{{}}}
    \label{{tab{}}}
	\end{{center}}
\end{{table}}
    ]],{
    i(1),i(3), i(4), i(5), i(6), i(2), rep(1)
    }
)),
-- Equation No Numbering 
s("neqn", fmt(
[[
%
\begin{{flalign*}}
    {}
\end{{flalign*}}
%
]],{
i(1)
}
)),
-- Equation Manual Numbering
s("eqn", fmt(
[[
%
\renewcommand{{\theequation}}{{{}}}
\begin{{flalign}}
    {} 
    \label{{eq{}}}
\end{{flalign}}
%
]],{
i(1), i(2), rep(1)
}
)),
-- Aligned
s("aligned", fmt(
[[
    \begin{{aligned}}
        {} 
    \end{{aligned}}
]],{
i(1)
}
)),
-- Equation Automatic Numbering
s("aeqn", fmt(
[[
%
\begin{{flalign}}
    {} 
    \label{{eq{}}}
\end{{flalign}}
%
]],{
i(1), i(2)
}
)),
-- Equation Gather
s("geqn", fmt(
[[
%
\begin{{gather{}}}
    {} 
    \label{{eq{}}}
\end{{gather{}}}
%
]],{
    c(1, {t "" , t "*"}), i(2), i(3), rep(1)
}
)),
-- Section No Number
s("toc", fmt(
[[
\{}section*{{{}}}\label{{{}}}
\addcontentsline{{toc}}{{{}section}}{{{}}}
]],{
    i(1), i(2), rep(2), rep(1), rep(2)
}
)),
-- Section Auto Number
s("sect", fmt(
[[
\{}section*{{{}}}\label{{{}}}
]],{
    i(1), i(2), rep(2)
}
)),
-- Matrices & Vectors
s("matrix", fmt(
[[
\begin{{pmatrix}}
    {}\\
    {}\\
    {}\\
\end{{pmatrix}}
]],{
i(1), i(2), i(3)
}
)),
--Figure
s("fig", fmt(
[[
\begin{{figure}}[ht!]
	\centering
    {}[width=\linewidth]{{{}}}
	\captionsetup{{font=footnotesize}}
	\caption{{{}}}
	\label{{fig{}}}
\end{{figure}}
%
]],{
    c(1, {
    t("\\includesvg"),
    t("\\includegraphics"),
    }), i(2), i(3), i(4)
}
)),
-- Subfigure
s("subfig", fmt(
[[
\begin{{figure}}[H] 
\begin{{subfigure}}[H]{{{}\linewidth}}
    \includegraphics[width=\linewidth]{{{}}}
\end{{subfigure}}
\end{{figure}}
%
]],{
i(1), i(2)
}
)),
-- Subfigure add
s("subfigadd", fmt(
[[
\begin{{subfigure}}[H]{{{}\linewidth}}
    \includegraphics[width=\linewidth]{{{}}}
\end{{subfigure}}
%
]],{
i(1), i(2)
}
)),
-- PNG Figure
s("figpng", fmt(
[[
\begin{{figure}}[H]
	\centering
    \includegraphics[width=\linewidth]{{{}}}
	\captionsetup{{font=footnotesize}}
	\caption{{{}}}
	\label{{fig{}}}
\end{{figure}}
%
]],{
i(1), i(2), i(3)
}
)),
--Auto Figure
s("afig", fmt(
[[
\begin{{figure}}[H]
	\centering
    \includesvg[width=\linewidth]{{{}}}
	\captionsetup{{font=footnotesize}}
	\caption{{{}}}
	\label{{fig{}}}
\end{{figure}}
%
]],{
i(1), i(2), i(3)
}
)),
s("wrapfig", fmt(
[[
%
\begin{{wrapfigure}}[{}]
    \flushright
    \captionsetup{{font=scriptsize}}
    %
    \includesvg[width=\\linewidth]{{{}}}
    \caption{{{}}}
    \label{{fig{}}}
    %
\end{{wrapfigure}}
%
]],{i(1), i(2), i(3), i(4)
}
)),
-- Big Brackets
s("bigbrac", fmt(
[[
\left{} {} \right{}
]],
{
--Node 1: The ChoiceNode for the opening bracket
c(1, {
    t("("),
    t("\\{"),
    t("["),
    t("|"),
    t("\\langle")
}),
-- Node 2: The content inside the brackets
i(2),
-- Node 3: The FunctionNode that mirrors Node 1
f(match_bracket, {1})
}
)),
-- Derivative
s("d", fmt(
[[
\dfrac{{d {} }}{{d {} }}
]],
{i(1), i(2)}
)),
--Second Derivative
s("dd", fmt(
[[
\dfrac{{d^2 {}}}{{d {}{}}}
]],
{i(1), i(2), c(3, {t("^2"), t("\\partial")})}
)),
-- Partial Derivative
s("pd", fmt(
[[
\dfrac{{\partial {}}}{{\partial {}}}
]],
{i(1), i(2)}
)),
-- Double Partial Derivative
s("pdd", fmt(
[[
\dfrac{{\partial^2 {}}}{{\partial {} {}}}
]],
{
i(1), c(3, {t("^2"), t("\\partial")}), i(2)
}
)),
s("hyref", fmt(
[[
\hyperref[{}]{{\textit{{{}}}}}
]],{
i(1), i(2)
}
)),
-- Real Numbers
s("RR", fmt(
[[
\mathbb{{R}}
]],{}
)),
--Python evironment
s("py", fmt(
[[
%
\begin{{python}}
    {}
\end{{python}}
%
]],{
i(1)}
)),
--Cases
s("cases", fmt(
[[
\begin{{cases}}
    {},\\[20pt]
    {}.
\end{{cases}}
]],{
i(1), i(2)}
)),
-- Box Definition Beamer
s("beamereq", fmt(
[[
%
\beamereq{{{}}}
    {{
%
\begin{{flalign}}
    {} 
    \label{{eq{}}}
\end{{flalign}}
%
    }}
%
]],{
    i(1), i(2), i(3)
}
)),
-- Box Definition
s("def", fmt(
[[
%
\tocdef{{{}}}{{{}}}
    {{
    {}
    }}
%
]],{
    i(1), f(generate_label, {1}), i(2)
}
)),
-- In General
s("ig", fmt(
[[
{}\ingen{}
]],{
    c(1, {t("$"), t("")}), rep(1)
}
)),
-- Fraction
s("ff", fmt(
[[
\{}{{{}}}{{{}}}
]],{
   c(1, {t("dfrac"), t("frac")}), i(2), i(3)
}
)),
s("frame", fmt(
[[
\begin{{frame}}[c]{{{}}}
{}
\end{{frame}}
]],{
    i(1), i(2)
}
)),
s("bf", fmt(
[[
\textbf{{{}}}
]],{
    i(1)
}
)),
s("it", fmt(
[[
\textit{{{}}}
]],{
    i(1)
}
)),
s("empheq", fmt(
[[
%
\begin{{empheq}}[box = \shadowbox*]{{align}}
 {} 
 \label{{eq{}}}
\end{{empheq}}
%
]],{
i(1), i(2)
}
)),
})

ls.add_snippets("python", {
s("fig", fmt(
    [[
    fig, ax = plt.subplots({})
    {}
    ]],{i(1),i(2)}
))
})
