> **Important:** This is a template repository to help you set up your team project.  
>  
> You are free to modify it based on your needs. For example, if your data is downloaded using *multiple* scripts instead of a single one (as shown in `\data\`), structure the code accordingly. The same applies to all other starter files—adapt or remove them as needed.  
>  
> Feel free to delete this text.


# Impact of director career length on movie ratings
*This project aims to analyze the relationship between a director's career length and the quality of their movies as measured by ratings extracted from IMBd* 

## Motivation

This study is relevant as it can provide insights into whether experience plays a significant role in filmmaking success, informing both aspiring and established directors, film producers, and scholars studying the film industry

By analyzing IMDb datasets, we will measure a director’s career length based on the span between their first and last directed movie and compare this to the average IMDb ratings of their films. Additionally, the number of productions attributed to each director will be taken into account, allowing us to explore whether a higher volume of work influences overall ratings. The findings could provide insight into whether experience and productivity correlate with higher audience appreciation

## Research question
'Do directors with a long career have better-rated movies?'

## Data
The research was conducted based on the following datasets extracted from imdb
-  "title.basics" = "https://datasets.imdbws.com/title.basics.tsv.gz",
-  "title.crew" = "https://datasets.imdbws.com/title.crew.tsv.gz",
-  "title.ratings" = "https://datasets.imdbws.com/title.ratings.tsv.gz",
-  "name.basics" = "https://datasets.imdbws.com/name.basics.tsv.gz"

After merging the required data, a sample was taken to be able to conduct a more in-depth analysis. The final data set used extract the results contained entries.

Variable description
- Career_start: year of production of the first movie directed
- Career_end: Year of production of the last movie directed
- Career_length: total length of a director's career, calculated as career_end - career_start
- Num_movies: total amount of movies produced per director
- Avg_rating: average rating of movies produced rated from 0-10
- Career_category: short (<10 years), medium (10-30 years), long (>30 years)

## Method

To answer this question, a multiple regression analysis is chosen as the primary research method. Regression is well-suited for this study because it allows us to examine the relationship between a director’s career length and the average IMDb rating of their movies while also considering the number of productions they have directed. By applying a multiple linear regression model, we can determine whether a longer career and/or a higher number of directed movies are associated with better ratings, while controlling for potential variability. Additionally, a boxplot analysis is included to categorize directors into career-length groups, and a scatter plot will be used to explore the relationship between the number of movies directed and IMDb ratings. This combination of methods ensures a comprehensive and statistically sound approach to answering the research question.


## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

*Explain any tools or packages that need to be installed to run this workflow.*

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team < x > members: < insert member details>
