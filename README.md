# Generate-RandomData

This powershell function will generate many files containing random data for testing with AUTOFORM LN.  Customer Data can easily be turned into a template in a couple of minutes and supplied to this script to generate as much data as you require.

## Pre-requisites

**NameIT** - A PowerShell Module available from the PowerShellGallery (PSGallery).\
It can be installed using `Install-Module -Name NameIT`.  Alternatively the script will cheque for the presence of this module and install it.

**PowerShell 5.0** - PSGallery is only avaialble on PowerShell 5.0 (at least out of the box) so this is a requirement to run the script.

## Usage

To use the function, download it from Gogs and load the function into Powershell as normal.

To call the function use `Generate-RandomData -Path c:\path\to\template.xml -NumberOfOutputs 5`

## Template Creation

There are various functions you can use within a template in order to generate different types of data.

For example:\
The `?` and `#` characters will be replaced with alphabetic and numeric characters respectively.\
`[person]` will be replaced with a random name.\
`[person female first]` will be replaced with a random first name for a woman.
`[address]` will be replaced with the first line of an address in the US format.

A full list of template functions can be found on the developers github page:\
https://github.com/dfinke/NameIT

I have also added two custom datasets that you won't find detailed on the developers page:\
`[city]` will be replaced with the name of a random City.\
`[country]` will be replaced with the name of a random Country.

You can also mix and match, for example:\
`[address], [city], [country][space]??##[space]#??`\
By using spaces and single characters/numbers at the end I have recreated the format of a UK postcode.

## Example Template

I have provided an example template called `template.xml` so that you can see how they are created and execute the command to see what happens.