# Uganda Elections Data Portal
## Background:
The [Uganda Elections Data Portal (UEDP)](https://uganda.electionsdataportal.org/result/Presidential/2016/National/) was designed by the [International Republican Institute (IRI)](https://www.iri.org/) in partnership with [Keshif](https://keshif.me/). IRI is a premier international democracy-development organization. Our nonpartisan, nongovernmental Institute has performed high-impact work in more than 100 countries since 1983—in Africa, Asia, Eurasia, Europe, Latin America and the Caribbean, and the Middle East and North Africa—and currently has offices in 40 countries worldwide.

The UEDP consists of a user-friendly website that allows users to visualize, analyze, and download registration and results data from [Electoral Commission (EC) of Uganda](https://ec.or.ug/) for the 2006, 2011, and 2016 Ugandan presidential elections, as well as short analytical reports on key election-related trends. The set of tools offered by the UEDP allows electoral stakeholders to conduct more effective, data-driven, election-related interventions and activities. For instance, areas with low turnout or a very high rate of invalid votes may benefit from additional get-out-the-vote campaigns and voter education.

This repository contains the complete UEDP datasets that are presented on the UEDP website. This repository also contains the machine-readable conversions of the EC's original election data publications, and also zipped archives of the EC's PDF publications of this election data. This repository also contains UEDP's methodology and annexes. Finally, UEDP's customized maps that are used to display data can also are available for download as GeoJSON files.


***See the interactive portal at [uganda.electionsdataportal.org](https://uganda.electionsdataportal.org/result/Presidential/2016/National/)***

![Portal](https://user-images.githubusercontent.com/58988133/100172205-cf6d8c80-2e95-11eb-8934-966686aa058f.gif)


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
    * [2016 Election Results by Polling Station PDF](https://github.com/bt-IRI/UEDP/tree/master/Original%20Source%20Data/2016%20Election/2016%20Election%20Results) &#8594; Machine-readable conversion: [Converted 2016 Results.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2016%20Conversions/Converted%202016%20Results.7z)
         * Original on EC site [here](https://ec.or.ug/ecresults/0-Final_Presidential_Results_Polling%20Station.pdf), Internet Archive capture [here](https://web.archive.org/web/20170109064503/https:/ec.or.ug/ecresults/0-Final_Presidential_Results_Polling%20Station.pdf)
    * [2016 Polling Stations List PDF](https://github.com/bt-IRI/UEDP/tree/master/Original%20Source%20Data/2016%20Election/2016%20Election%20Station%20List) &#8594; Machine-readable conversion: [Converted 2016 Polling Stations List.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2016%20Conversions/Converted%202016%20Polling%20Stations%20List.7z)
         *  Original on EC site [here](https://www.ec.or.ug/sites/VoterCount/Statistics%20by%20Polling%20Station.pdf), Internet Archive capture [here](https://web.archive.org/web/20170107081126/https:/www.ec.or.ug/sites/VoterCount/Statistics%20by%20Polling%20Station.pdf)
    * NVR for 2015/2016 (No longer from EC) &#8594; Aggregated conversion: [Converted 2016 NVR Registered voter Age by Gender.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2016%20Conversions/Converted%202016%20NVR%20Registered%20voter%20Age%20by%20Gender.7z)
         *  Note: The NVR for 2015/2016 was originally offered through a portal on the EC site. However, this edition of the NVR is no longer available as a new NVR was created ahead of the 2020 Presidential Election. The UEDP presents registered voter demographic data from the 2015/2016 NVR that was collected while this edition was still online. Please see the station-level aggregated conversion of the original 2015/2016 NVR for demographic infromation used in the 2016 UEDP dataset. Please see the methodology for more information on the 2015/2016 NVR and how its original 28,010 Station List PDFs were transformed for use in the UEDP.
* 2011 Presidential Election Source Files
    * [2011 Election Results by Polling Station PDF](https://github.com/bt-IRI/UEDP/tree/master/Original%20Source%20Data/2011%20Election/2011%20Election%20Results) &#8594; Machine-readable conversion: [Converted 2011 Results.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2011%20Conversions/Converted%202011%20Results.7z)
         * Original on EC site [here](https://www.ec.or.ug/sites/Elec_results/2011_Pres_Pstn.pdf), Internet Archive capture [here](https://web.archive.org/web/20170107151330/http:/www.ec.or.ug/sites/Elec_results/2011_Pres_Pstn.pdf)
* 2006 Presidential Election Source Files
    * [2006 Election Results by Polling Station PDF](https://github.com/bt-IRI/UEDP/blob/master/Original%20Source%20Data/2006%20Election/2006%20Election%20Results/Presidential%20Election%202006%20-%20Results%20by%20Polling%20Station.7z) &#8594; Machine-readable conversion: [Converted 2006 Results.csv](https://github.com/bt-IRI/UEDP/raw/master/Original%20File%20Conversions/2006%20Conversions/Converted%202006%20Results.7z)
         * Original on EC site [here](https://www.ec.or.ug/sites/Elec_results/2006_pres_polling.pdf), Internet Archive capture [here](https://web.archive.org/web/20181222125155/http:/www.ec.or.ug/sites/Elec_results/2006_pres_polling.pdf)

## III. UEDP Datasets
While the UEDP portal will output summary report downloads for particular geographical areas and elections, the following station-level datasets are made available for download here:
* [UEDP 2016 Dataset.csv](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Datasets/UEDP%202016%20Dataset.7z)
* [UEDP 2011 Dataset.csv](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Datasets/UEDP%202011%20Dataset.7z)
* [UEDP 2006 Dataset.csv](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Datasets/UEDP%202006%20Dataset.7z)
* [UEDP 2011-2016 Unified Dataset.csv](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Datasets/UEDP%20Unified%202011-2016%20Dataset.7z)
     * Unlike the other individual-year datasets, this 'Unified' version combines all data from the 2011 and 2016 datasets into a single file. The UEDP 2011 and 2016 datasets are normalized down to the 'Parish' administrative unit across both election years. 



## IV. UEDP Maps
The customized map files used to display data in the portal are also made available for download on this repository in GeoJSON format.

The following files are 'simplified' geometries. These files are suitable for representing the data as it stands with a smaller-size map file. However, if users wish to adjust any of the map geometries, it is recommended that users instead download the 'Unsimplified' version of the Parish Map and use this as the starting point for additional re-adjustments.
* [Admin. Level 1: Regions](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Maps/UEDP-(Lvl.1%20Regions).7z)
* [Admin. Level 3: Districts](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Maps/UEDP-(Lvl.%203%20Districts).7z)
* [Admin. Level 4: Counties](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Maps/UEDP-(Lvl.4%20Counties).7z)
* [Admin. Level 6: Parishes](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Maps/UEDP-(Lvl.6%20Parishes).7z)

The unsimplified version of the UEDP parish map is available for download here:
* [Unsimplified - Admin. Level 6: Parishes](https://github.com/bt-IRI/UEDP/raw/master/UEDP%20Maps/UEDP-(Unsimplified%20Lvl.6%20Parish%20Map).7z)

***For linking the election datasets to the maps...***

These GeoJSON files are indexed to the UEDP Datasets using a common 'ID' key. The map files themselves do not contain any data beyond geometries and the 'ID' key.

To link the 2011 and 2016 UEDP datasets to each of the maps, the datasets' ID should be trimmed to the appropriate number of characters. The dataset IDs for 2011 and 2016 are 14-characters. These indicate REGION-DISTRICT-COUNTY-PARISH-STATION.
* To link REGION data to the region map, trim the dataset IDs to 1 character.
* To link DISTRICT data to the district map, trim the dataset IDs to 7 characters.
* To link COUNTY data to the county map, trim the dataset IDs to 5 characters.
* To link PARISH data to the county map, trim the dataset IDs to 11 characters.

Unlike the 2011 and 2016 datasets, the 2006 UEDP dataset is only geographically normalized with other datasets down to the DISTRICT level. Due to this difference in normalization, the 2006 IDs are only 10 characters in length.
* To link 2006 REGION data to the region map, trim the 2006 IDs to 1 character.
* To link 2006 DISTRICT data to the region map, trim the 2006 IDs to 7 characters.

For additonal information on how the election data was geographically normalized, and how the custom UEDP maps were created, please refer to the methodology.
