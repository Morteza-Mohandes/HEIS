{smcl}
{* *! version 1.2.2  15may2018}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "examplehelpfile##syntax"}{...}
{viewerjumpto "Description" "examplehelpfile##description"}{...}
{viewerjumpto "Options" "examplehelpfile##options"}{...}
{viewerjumpto "Remarks" "examplehelpfile##remarks"}{...}
{viewerjumpto "Examples" "examplehelpfile##examples"}{...}

{title: Title}

{phang}
{bf:HEIS} {hline 2} HEIS data from 1380 to 1400 download and clean: first install this package:

net install github, from("https://haghish.github.io/github/")

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:wh:atever}
[{namelist}]
{ifin}
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}

{synopt:{opt weight}}download weights if set to "true"{p_end}
{synopt:{opt data}}download data if set to "true"{p_end}
{synopt:{opt path}}path to save files (default is mdb or working directory){p_end}
//
// {synopt:{opt d:etail}}display additional statistics{p_end}
// {synopt:{opt mean:only}}suppress the display; calculate only the mean;
//         programmer's option{p_end}
// {synopt:{opt f:ormat}}use variable's display format{p_end}
// {synopt:{opt sep:arator(#)}}draw separator line after every {it:#} variables;
//         default is {cmd:separator(5)}{p_end}
// {synopt:{opth g:enerate(newvar)}}create variable name {it:newvar}{p_end}
// {synoptline}
// {p2colreset}{...}
// {p 4 6 2}
// {cmd:by} is allowed; see {manhelp by D}.{p_end}
// {p 4 6 2}
// {cmd:fweight}s are allowed; see {help weight}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:whatever} HEIS data from 1380 to 1400 download and clean


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt detail} displays detailed output of the calculation.

{phang}
{opt meanonly} restricts the calculation to be based on only the means.  The
default is to use a trimmed mean.

{phang}
{opt format} requests that the summary statistics be displayed using
the display formats associated with the variables, rather than the default
{cmd:g} display format; see
{findalias frformats}.

{phang}
{opt separator(#)} specifies how often to insert separation lines
into the output.  The default is {cmd:separator(5)}, meaning that a
line is drawn after every 5 variables.  {cmd:separator(10)} would draw a line
after every 10 variables.  {cmd:separator(0)} suppresses the separation line.

{phang}
{opth generate(newvar)} creates {it:newvar} containing the whatever
values.


{marker remarks}{...}
{title:Remarks}

{pstd}
For detailed information on the whatever statistic, see
{manlink R Intro}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. whatever mpg weight}{p_end}

{phang}{cmd:. whatever mpg weight, meanonly}{p_end}


