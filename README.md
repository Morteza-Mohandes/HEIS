_v. 1_  

`HEIS` : Iranian HEIS
=====================

#### Description
HEIS is a Stata package for downloading and cleaning the Iranian household expenditure and income survey. Moreover, This package saves the tables of the dataset in _dta_ format. For now, the dataset of 1394 is not available yet, but 1381-1400 are available.

#### Installation
To install the package first you need to install "github" package:
```stata
net install github, from("https://haghish.github.io/github/")
```
Next, to download and install the "HEIS" package:
```
github install Iran-Indicators/HEIS
```
#### Quick Start
If you have the dataset; set the directory of your Stata on the folder contains you dataset.
```
cd "D:\data"
```
If not, specify the directory you want to download a dataset and set the _data_ option _"true"_.
```
HEIS year, data("true")
```
For some years like 1380-1388, the weight of the observations are not included in the dataset. To solve the problem, you can use option _weight_ and set it _"true"_.
```
HEIS year, data("true") weight("true")
```
In case you just need the weights:
```
HEIS year, weight("true")
```
For now, the dataset of 1394 is not available yet, but 1381-1400 are available.




### License
Academic Free License v3.0

Author
------

**[__Ali Bahrami Sani__](https://alibahramisani.github.io/), [__Morteza Mohandes Mojarrad__](https://morteza-mohandes.github.io/)**  
Graduate student of economics at TeIAS, Graduate student of economics at TeIAS  
Ali.Bahrami.Sani@gmail.com, mortza.mohandes@gmail.com  
