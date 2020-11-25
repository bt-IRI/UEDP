# Uganda Elections Data Portal (UEDP)
## Background:
The [Uganda Elections Data Portal (UEDP)](https://uganda.electionsdataportal.org/result/Presidential/2016/National/) was designed by the [International Republican Institute (IRI)](https://www.iri.org/) in partnership with [Keshif](https://keshif.me/). IRI is a premier international democracy-development organization. Our nonpartisan, nongovernmental Institute has performed high-impact work in more than 100 countries since 1983—in Africa, Asia, Eurasia, Europe, Latin America and the Caribbean, and the Middle East and North Africa—and currently has offices in 40 countries worldwide.

The UEDP consists of a user-friendly website that allows users to visualize, analyze, and download registration and results data from [Electoral Commission (EC) of Uganda](https://ec.or.ug/) for the 2006, 2011, and 2016 Ugandan presidential elections, as well as short analytical reports on key election-related trends. The set of tools offered by the UEDP allows electoral stakeholders to conduct more effective, data-driven, election-related interventions and activities. For instance, areas with low turnout or a very high rate of invalid votes may benefit from additional get-out-the-vote campaigns and voter education.

This repository contains the complete UEDP datasets that are presented on the UEDP website. This repository also contains the machine-readable conversions of the EC's original election data publications, and also zipped archives of the EC's PDF publications of this election data. This repository also contains UEDP's methodology and annexes. Finally, UEDP's customized maps that are used to display data can also are available for download as GeoJSON files.

## Disclaimer:
***While IRI aims to make the information on this website as timely and accurate as possible, IRI makes no claims nor guarantees about the accuracy and completeness of the data on this site beyond what is outlined in our verification process, and expressly disclaims liability for errors and omissions in the contents of this site.***

# Repository Table of Contents
## I. Methodology
### Summary:
IRI constructed the UEDP datasets using official election publications of the Electoral Commission of Uganda. The exact number of documents that IRI used to put together the UEDP datasets depends on what the EC published for each presidential election. However, the backbone of the UEDP database and analyses are the polling-station-level results files that are published for each election by the EC, including the 2016, 2011, and 2006 elections.

All the original EC publications used were originally PDF documents. IRI took three primary steps with the EC’s election data to allow for meaningful data wrangling, including data aggregation, data analysis, and geographic representation. Each step is detailed below:  

*1.	Aggregation:* Existing EC election data exists in various PDF documents. For example, the 2016 election results are published in one large PDF document, while registered voter demographics such as gender and age are published in two documents. IRI helps solve this challenge by merging all available information into a single database.

*2.	Analysis:* In their current form, the EC’s election documents are difficult to analyze as the data is statically presented in large PDF files that are not machine-readable. IRI helps solve this challenge by converting the original PDF documents into machine-readable files that can be displayed on an interactive web portal.

*3.	Geographical Representation:* Since the start of Uganda’s multi-party presidential elections in 2006, Uganda’s number of districts, parishes, and polling stations has increased. Most recently, the number of districts has increased to 134 under a 2015 Act of Parliament that reorganized the districts at the outset of 2019.  Because of this, the original election results publications over the three election years are hard to compare as each year shows different geographical breakdowns. IRI solves this challenge by re-sorting the election data for these three years into a common set of geographical units that aligns with the 2019 reorganization. These standardized 2019 units include regions, districts, and parishes. These units are described in the final UEDP datasets and UEDP’s updated map file allows the election data to be overlaid on interactive maps that are displayed in the web portal.

## II. Source Documents
The following official Electoral Commission PDF publications were used to construct the UEDP datasets. This repository provides zipped copies of the original EC PDF versions, as well as IRI's machine-readable conversions of these documents. ***Please note that these conversions differ from the final UEDP datasets since additional modifications were made to allow for cross-election analysis and a representation of the data on a map.*** 

* 2016 Presidential Election Source Files
    * [2016 Election Results by Polling Station PDF](https://github.com/bt-IRI/UEDP/tree/master/Original%20Source%20Data/2016%20Election/2016%20Election%20Results) &#8594; Machine-readable conversion: [Converted 2016 Results.csv](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2016%20Conversions/Converted%202016%20Results.csv)
         * Original on EC site [here](https://ec.or.ug/ecresults/0-Final_Presidential_Results_Polling%20Station.pdf), Internet Archive capture [here](https://web.archive.org/web/20170109064503/https:/ec.or.ug/ecresults/0-Final_Presidential_Results_Polling%20Station.pdf)
    * [2016 Polling Stations List PDF](https://github.com/bt-IRI/UEDP/tree/master/Original%20Source%20Data/2016%20Election/2016%20Election%20Station%20List) &#8594; Machine-readable conversion: [Converted 2016 Polling Stations List.csv](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2016%20Conversions/Converted%202016%20Polling%20Stations%20List.csv)
         *  Original on EC site [here](https://www.ec.or.ug/sites/VoterCount/Statistics%20by%20Polling%20Station.pdf), Internet Archive capture [here](https://web.archive.org/web/20170107081126/https:/www.ec.or.ug/sites/VoterCount/Statistics%20by%20Polling%20Station.pdf)
    * NVR for 2015/2016 (No longer from EC) &#8594; Aggregated conversion: [Converted 2016 NVR Registered voter Age by Gender.csv](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2016%20Conversions/Converted%202016%20NVR%20Registered%20voter%20Age%20by%20Gender.csv)
         *  Note: The NVR for 2015/2016 was originally offered through a portal on the EC site. However, this edition of the NVR is no longer available as a new NVR was created ahead of the 2020 Presidential Election. The UEDP presents registered voter demographic data from the 2015/2016 NVR that was collected while this edition was still online. Please see the station-level aggregated conversion of the original 2015/2016 NVR for demographic infromation used in the 2016 UEDP dataset. Please see the methodology for more information on the 2015/2016 NVR and how its original 28,010 Station List PDFs were transformed for use in the UEDP.
* 2011 Presidential Election Source Files
    * [2011 Election Results by Polling Station PDF](https://github.com/bt-IRI/UEDP/tree/master/Original%20Source%20Data/2011%20Election/2011%20Election%20Results) &#8594; Machine-readable conversion: [Converted 2011 Results.csv](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2011%20Conversions/Converted%202011%20Results.csv)
         * Original on EC site [here](https://www.ec.or.ug/sites/Elec_results/2011_Pres_Pstn.pdf), Internet Archive capture [here](https://web.archive.org/web/20170107151330/http:/www.ec.or.ug/sites/Elec_results/2011_Pres_Pstn.pdf)
* 2006 Presidential Election Source Files
    * [2006 Election Results by Polling Station PDF](https://github.com/bt-IRI/UEDP/blob/master/Original%20Source%20Data/2006%20Election/2006%20Election%20Results/Presidential%20Election%202006%20-%20Results%20by%20Polling%20Station.7z) &#8594; Machine-readable conversion: [Converted 2006 Results.csv](https://github.com/bt-IRI/UEDP/blob/master/Original%20File%20Conversions/2006%20Conversions/Converted%202006%20Results.csv)
         * Original on EC site [here](https://www.ec.or.ug/sites/Elec_results/2006_pres_polling.pdf), Internet Archive capture [here](https://web.archive.org/web/20181222125155/http:/www.ec.or.ug/sites/Elec_results/2006_pres_polling.pdf)

## III. UEDP Datasets

## IV. UEDP Maps



