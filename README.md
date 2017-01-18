# crfmR

THIS IS SPACE IN PROGRESS - so keep calm

## On this space

The intent of this space if to provide general instuctions in the use of R with specific focus on fisheries data that are generally collected in the CRFM region. It is in part of Einar Hjörleifsson ([see CRFM press release](http://www.crfm.int/index.php?option=com_k2&view=item&id=544:top-fisheries-data-expert-from-iceland-shares-expertise-with-crfm-countries&Itemid=179)) short term assignment at the CRFM St. Vincent office in the first two months of 2017.

Upfront and in the spirit of open source knowledge it is emphasise that the source code for the text you are now reading can be found on this webspace as [README.Rmd](https://raw.githubusercontent.com/crfm/crfmr/master/README.Rmd). If you have [RStudio](https://www.rstudio.com) already installed on your computer and some minimal experience in using it you should be able to regenerate this whole document on your local computer using the referred file. If you can not, do not hesitate to send an email to einar.hjorleifsson@gmail.com

### Context

The R language is becoming the _Lingua franca_ both in data science in general as well as within the ICES community. Recent advancements within R have resulted in that R can no longer be considered as a specific statistical programming language but as a general scientific working environment. This broader environment has resulted in the R has become a natural component of reproducible data analysis and document writing.

The document is aimed at covering the fundamental/generic basis of the grammar of data and graphics as well reproducible document writing where R is used as the sole working medium. Recent developments in the R community that are of interest to fisheries science will also be described.

### Some notes with respect to potential focus of work

* Summarize the current data management system with emphasis on subsequent standard statistic analysis of two countries with the aim:
    - Defining strength and weaknesses of the current analysis system (from a technical perspective).
    - Review national technical document (if available) that describe in detail the methodology (including software) used for standard calculations (e.g. annual catch statistics, catch per unit effort calculation, estimation of total effort, raising of sample catch at length to total catch, ...).
    - Suggestions for improvement in analysis with particular focus of increasing efficiency, reproducability and transparability.
    - Exploring potential of additional statistical product that may be of use in summarising fisheries trends given the current data collection (e.g. using a metanalysis across species or fisheries to identify largest changes in trend over time, ...).

* Promote the use of R in fisheries data analysis by:
    - Generate a manual7cookbook that describes the basis of importing data into R, tidying, munging and simple summation analysis of fisheries data by using familiar/common data types collected in the CRFM countries.
    - Provide standard scripts (functions) as an alternative to the current methodologise used for the standard data analysis (presumably Excel).
    
* Benefits:
    - Provides a platform for standardised approach across countries, despite data being stored in a different medium.
    - Enhances skill and competency in R by using data familiar to the fisheries scientist in the region.
    - Increases efficiency, re-producability and transparency.
    - Provides a stepping stone for more sophisticated analysis in R in the future.

### For contributers

#### Get a copy of the directory

If you want to get the whole directory onto your computer simply do (within Linux):

A. HTTPS
```
git clone https://github.com/crfm/crfmr.git
```

B. If you have setup ssh on github a more seamless way is:
```
git clone git@github.com:crfm/crfmr.git
```

Then open the project via RStudio and ammend, improve, add as you wish.

If on Windows there are some buttons on the github page which can be pushed.

#### On pushing changes to the github directory

Just some minimal instruction now:

* In the top right panel in RStudio (if you have default settings) there is a tab called "Git". If you open it and if you have made some changes you may see a list of some objects.
* Select the objects you want to commit and press the "Commit" button.
* Write some gibberish (for now) in the "Commit message"
* Once done presh the "Push" button. You may here be asked for a password if you have cloned the stuff via HTTPS.
* If all goes smoothly you have changed the content on the github.com site



