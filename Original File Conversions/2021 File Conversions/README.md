# UEDP 2021 General Election Data Conversions
## Background:
Like in previous general elections, Electoral Commission of Uganda (EC) uploaded PDF files describing polling station level results for the 2021 Presidential Election. The EC uploaded the station files as 146 separate PDFs and each describes a polling stations for a specific 'District' level administrative division. In addition, the EC uploaded a separate list of nullified polling stations, as well as a separate summary with results totals for each district. Finally, the EC published registered-voter statistics for each polling station ahead of the general election.

## Contents:
The UEDP team converted all of the EC's 2021 General Election PDF publications into machine-readable '.csv' files. Our conversions of these documents are provided via the links below. In addition, the UEDP team has provided our code to download and convert all of the 2021 EC PDFs into these '.csv' conversion files.
* [Converted_2021_Polling_Stations_Results.csv](...)
* [Converted_2021_Nullified_Polling_Stations.csv](...)
* [Converted_2021_District_Summary_Report.csv](...)
* [Converted_2021_Pollings_and_Voter_Count.csv](...)

Code to convert all of the original PDF files to the '.csv' files linked above can be found in [UEDP 2021 Conversion Code](...). Both the UGD2021_Conversion.R and UGD2021_Conversion_Driver.R are required to execute and produce the UEDP's team's conversions of the 2021 data.

## Package Citations:
The following R packages were instrumental in the UEDP's conversion of the 2021 General Election results.
* Thomas J. Leeper (2018). tabulizer: Bindings for Tabula PDF Table Extractor Library. R package version 0.2.2.
* Gagolewski M. and others (2018). R package stringi: Character string processing facilities. http://www.gagolewski.com/software/stringi/. DOI:10.5281/zenodo.32557.
* Jeroen Ooms (2019). pdftools: Text Extraction, Rendering and Converting of PDF Documents. R package version 2.3.
  https://CRAN.R-project.org/package=pdftools.
* Hadley Wickham (2019). stringr: Simple, Consistent Wrappers for Common String Operations. R package version 1.4.0. https://CRAN.R-project.org/package=stringr.

