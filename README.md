# Uganda Elections Data Portal (UEDP)
## Background:
The [Uganda Elections Data Portal (UEDP)](https://uganda.electionsdataportal.org/result/Presidential/2016/National/) was designed by the [International Republican Institute (IRI)](https://www.iri.org/) in partnership with [Keshif](https://keshif.me/). IRI is a premier international democracy-development organization. Our nonpartisan, nongovernmental Institute has performed high-impact work in more than 100 countries since 1983—in Africa, Asia, Eurasia, Europe, Latin America and the Caribbean, and the Middle East and North Africa—and currently has offices in 40 countries worldwide.

The UEDP consists of a user-friendly website that allows users to visualize, analyze, and download registration and results data from [Electoral Commission (EC) of Uganda](https://ec.or.ug/) for the 2006, 2011, and 2016 Ugandan presidential elections, as well as short analytical reports on key election-related trends. The set of tools offered by the UEDP allows electoral stakeholders to conduct more effective, data-driven, election-related interventions and activities. For instance, areas with low turnout or a very high rate of invalid votes may benefit from additional get-out-the-vote campaigns and voter education.

This repository contains the complete UEDP datasets that are presented on the UEDP website. This repository also contains the machine-readable conversions of the EC's original election data publications, and also zipped archives of the EC's PDF publications of this election data. This repository also contains UEDP's methodology and annexes. Finally, UEDP's customized maps that are used to display data can also are available for download as GeoJSON files.

## Disclaimer:
*While IRI aims to make the information on this website as timely and accurate as possible, IRI makes no claims nor guarantees about the accuracy and completeness of the data on this site beyond what is outlined in our verification process, and expressly disclaims liability for errors and omissions in the contents of this site.*

## Executive Methodology:
IRI constructed the UEDP datasets using official election publications of the Electoral Commission of Uganda. The exact number of documents that IRI used to put together the UEDP datasets depends on what the EC published for each presidential election. However, the backbone of the UEDP database and analyses are the polling-station-level results files that are published for each election by the EC, including the 2016, 2011, and 2006 elections.

All the original EC publications used were originally PDF documents. IRI took three primary steps with the EC’s election data to allow for meaningful data wrangling, including data aggregation, data analysis, and geographic representation. Each step is detailed below:  

*1.	Aggregation:* Existing EC election data exists in various PDF documents. For example, the 2016 election results are published in one large PDF document, while registered voter demographics such as gender and age are published in two documents. IRI helps solve this challenge by merging all available information into a single database.

*2.	Analysis:* In their current form, the EC’s election documents are difficult to analyze as the data is statically presented in large PDF files that are not machine-readable. IRI helps solve this challenge by converting the original PDF documents into machine-readable files that can be displayed on an interactive web portal.

*3.	Geographical Representation:* Since the start of Uganda’s multi-party presidential elections in 2006, Uganda’s number of districts, parishes, and polling stations has increased. Most recently, the number of districts has increased to 134 under a 2015 Act of Parliament that reorganized the districts at the outset of 2019.  Because of this, the original election results publications over the three election years are hard to compare as each year shows different geographical breakdowns. IRI solves this challenge by re-sorting the election data for these three years into a common set of geographical units that aligns with the 2019 reorganization. These standardized 2019 units include regions, districts, and parishes. These units are described in the final UEDP datasets and UEDP’s updated map file allows the election data to be overlaid on interactive maps that are displayed in the web portal. 
 
For all of the information on how the UEDP datasets and maps were created, please refer to the full methodology.


