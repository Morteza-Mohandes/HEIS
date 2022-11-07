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