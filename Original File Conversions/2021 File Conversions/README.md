# UEDP 2021 General Election Data Conversions
## Background:
Like in previous general elections, Electoral Commission of Uganda (EC) uploaded PDF files describing polling station level results for the 2021 Presidential Election. For detailed results across polling stations, the EC uploaded 146 separate PDFs containing station-level data across all 'District' level administrative divisions. In addition, the EC uploaded a separate list of nullified polling stations, as well as a separate summary with results totals for each district. Finally, the EC published registered-voter counts for each polling station ahead of the general election.

## Contents:
The UEDP team converted all of the EC's 2021 General Election PDF publications into machine-readable '.csv' files. Our (zipped) machine-readable conversions of these documents are provided via the links below. In addition, the UEDP team has provided our code to download and convert all of the 2021 EC PDFs into these '.csv' conversion files.
* 2021 Results by Polling Station &#8594; [Converted_2021_Results.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2021%20File%20Conversions/Converted_2021_Results.7z)
* 2021 List of Nullified Polling Stations &#8594; [Converted_2021_NullStations.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2021%20File%20Conversions/Converted_2021_NullStations.7z)
* 2021 District Tally Sheet &#8594; [Converted_2021_DistrictTallySheet.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2021%20File%20Conversions/Converted_2021_DistrictTallySheet.7z)
* 2021 Voter Count by Polling Stations &#8594; [Converted_2021_VoterCountbyStations.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2021%20File%20Conversions/Converted_2021_VoterCountbyStations.7z)

Instructions and code for generating each of these conversion files are povided below.

## Instructions:
1. Download both .R files ([UGD2021_Conversion.R](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2021%20File%20Conversions/UGD2021_Conversion.R) and [UGD2021_Conversion_Driver.R](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2021%20File%20Conversions/UGD2021_Conversion_Driver.R)) and store these in the same folder.
2. Open UGD2021_Conversion.R and run the code under "1. PDF FILE DOWNLOADS & LOOKUP DATAFRAME FOR CONVERSION." 
3. Run the code under "Other 2021 file downloads" if you wish to download and convert the list of nullified polling stations, the district tally sheet, and/or the polling station registered voter counts.
4. Ensure that all R packages under "Notes on Driver" are installed and that the environment for rJava is set correctly.
5. Run remaining code to convert station results PDFs and the nullified polling stations PDF. The code will write the conversions as .csv files.



## Package Citations:
The following R packages were instrumental in the UEDP's conversion of the 2021 General Election results.
* Thomas J. Leeper (2018). tabulizer: Bindings for Tabula PDF Table Extractor Library. R package version 0.2.2.
* Gagolewski M. and others (2018). R package stringi: Character string processing facilities. http://www.gagolewski.com/software/stringi/. DOI:10.5281/zenodo.32557.
* Jeroen Ooms (2019). pdftools: Text Extraction, Rendering and Converting of PDF Documents. R package version 2.3.
  https://CRAN.R-project.org/package=pdftools.
* Hadley Wickham (2019). stringr: Simple, Consistent Wrappers for Common String Operations. R package version 1.4.0. https://CRAN.R-project.org/package=stringr.

