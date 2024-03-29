![logoFHNW](/img/logoFHNW.jpg?raw=true "logoFHNW")

```
Author: Mario Huegi
Institution: FHNW - University of Applied Sciences Northwestern Switzerland
Course of studies: Energy and Environmental Technologies
Module: MATLAB-Workshob
Lecturer: Prof. Dr. Norbert Hofmann
```

### Features
* Graphical interface for mango drying simulation
* Data saving formats: CSV, TXT, DAT
* Plot saving formats: PDF, PNG, JPEG

### Third-party software
* Use of CoolProp in Matlab (see [CoolProp-Website](http://www.coolprop.org/ "CoolProp-Website"), openSource alternative to [refProp](https://www.nist.gov/srd/refprop "refProp"))
* MATLAB-Toolboxes used: X-Steam, SplashScreen
* MATLAB-Toolboxes used and modified: SI Psychrometric Chart

### Tutorial (german only)
The folder tutorial Videos contains some tutorial videos in german language.

# Mango Drying Simulator

* [General Overview](#general-overview)
* [Function description](#function-description)
  * [mangoSimulator](#mangosimulator)
  * [specificIdealConvective](#specificidealconvective)
  * [specificIdealCondensation](#specificidealcondensation)
  * [idealDrying](#idealdrying)
  * [idealCondensation](#idealcondensation)
  * [logFileGenerator](#logfilegenerator)
  * [drawPlot](#drawplot)
  * [drawPdf](#drawpdf)
  * [exportCSV](#exportcsv)
* [GUI description](#gui-description)
* [CoolProp](#coolprop)
  * [Installation](#installation)
  * [Use of CoolProp](#use-of-coolprop)


## General Overview
This script was created within the scope of an EUT project (EUT-P3-19HS-08). The project group investigated the behaviour of mangos in different ovens. With the help of this script the ideal behaviour of a convection oven can be simulated. For the creation of the graphics X-Steam is used. Furthermore, the script can also simulate a condensation dryer, which is operated with a heat pump. The program CoolProp was used to calculate the heat pump statically.

## Function description
### mangoSimulator
This function starts the software with a splashScreen wrapper.

### specificIdealConvective
Returns output data for ideal convective drying processes.
#### inputs:
* app: GUI-data variable
#### outputs:
* energySecondary: Secondary energy used to dry mangos
* energyPrimary:   Primary energy used to dry mangos
* energyButane:    Amount of Butane needed
* CO2weight:       emitted CO2 due to burning butane

### specificIdealCondensation
Returns output data for ideal condensation drying processes.
#### inputs:
* app: GUI-data variable
#### outputs:
* energySecondary:    Secondary energy used to dry mangos
* energyPrimary:      Primary energy used to dry mangos
* energyElectricity:  Current needed in kWh
* CO2weight:          emitted CO2 due to burning butane

### idealDrying
Calculates an ideal convective dryer (e.g. ideal ATESTA).
#### inputs:
* m_hum_in:   humidity of raw-mango (in percent)
* m_hum_out:  humidity of dry-mango (in percent)
* s_air_hum:  humidity of air at the coldest point (in percent)
* t_in:       air temperature entering the oven (burner temperature) in degree Celsius
* t_in:       air temperature leaving the oven (chimney temperature) in degree Celsius
* UIaxes:     GUI-Axes File to plot psychrometric chart
#### outputs:
* energy_per_kg_mango:    amount of energy used by ideal convective dryer
* air_per_kg_mango:       amount of air used, to transport the needed energy (can be used to calculate a fan)

### idealCondensation
Calculates an ideal condensation dryer (heat pump).This function uses coolProp, make sure to have coolProp installed in an MATLAB compatible Phython version (in Phython use: pip install coolProp) For more information, see [CoolProp-Website](http://www.coolprop.org/ "CoolProp-Website").
#### inputs:
* temp_cooling:   low temperature of the heat pump
* temp_heating:   high temperature of the heat pump
* superheat:      amount of degrees to overheat (compressor protection)
* m_hum_in:       humidity of raw-mango (in percent)
* m_hum_out:      humidity of dry-mango (in percent)
* air_hum:        humidity of air at the coldest point (in percent)
* UIaxes:         GUI-Axes File to plot psychrometric chart
#### outputs:
* energy_per_kg_mango:    amount of energy used by ideal condesation dryer
* air_per_kg_mango:       amount of air used, to transport the needed energy (can be used to calculate a fan)
* COP_heating:            Coefficient of Power of the heating process in the heat pump

### logFileGenerator
Simple text logger for software statistics
#### input:
* logMessage: Message to log into log-file.

### drawPlot
Plots the input UIFigure to pdf, png or jpeg. The plotted pdf are usable as scalable vector graphics e.g. in latex. Jpeg and png are not scalable and worse in quality.
#### input:
* app: GUI-data variable

### drawPdf
Generates cutted pdf out of a MATLAB figure.
#### inputs:
* fig: MATLAB-figure to plot
* path: Path where file should be stored
* name: Name of file to store

### exportCSV
Exports all input and output data to CSV, TXT or DAT file. User can choose path and filename in a opening prompt.
#### input:
* app: app: GUI-data variable

## GUI description
The GUI is mainly based on the functions listed above. If you open the GUI.mlapp file, you get to the App-Designer of MATLAB. Like most GUI designers, it is divided into a graphical and a textual (code) part.

## CoolProp
### Installation
Using the pip installation program, you can install the official release from the pypi server using:
```
pip install CoolProp
```
There are also unofficial Conda packages available from the conda-forge channel. To install, use:
```
conda install conda-forge::coolprop
```
### Use of CoolProp
In the folder etc you can find a MATLAB wrapper. It is recommended to perform a first functional test of the wrapper with CoolPropWrapperTest.m. If problems occur during configuration, the wrapper will inform you and suggest solutions. Once CoolProp is properly configured, it works in the background and requires no maintenance.
