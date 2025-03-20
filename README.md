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

| Variable name     | Variable explanation | 
|--------------|--------------------|
| career_start  | year of production of the first movie directed                 | 
| career_end | year of production of the last movie directed                 | 
| career_length  |   total length of a director's career, calculated as career_end - career_start               | 
| num_movies  |  total amount of movies produced per director  |
| avg_rating  |  average rating of movies produced rated from 0-10  |
| career_category |  short (<10 years), medium (10-30 years), long (>30 years) |
|  control variables |  NOG TOEVOEGEN  |

## Method

To answer this question, a multiple regression analysis is chosen as the primary research method. Regression is well-suited for this study because it allows us to examine the relationship between a director’s career length and the average IMDb rating of their movies while also considering the number of productions they have directed. By applying a multiple linear regression model, we can determine whether a longer career and/or a higher number of directed movies are associated with better ratings, while controlling for potential variability. Additionally, a boxplot analysis is included to categorize directors into career-length groups, and a scatter plot will be used to explore the relationship between the number of movies directed and IMDb ratings. This combination of methods ensures a comprehensive and statistically sound approach to answering the research question.

The regression is as follows: Y = avg_rating ~ career_length + num_movies + avg_runtime + avg_numVotes + is_dramatic + is_light_entertainment + is_action_suspense + is_speculative + is_non_fiction + genre_versatility


## Preview of Findings 
To investigate the effect of career length (short vs medium vs long) and the amount of movies produced per director on average movie ratings, a multiple linear regression was conducted. The output is as follows:

| Predictor  | Coefficient (β) | Std. Error | t-value | p-value  | significance code |
|------------|---------------|------------|---------|---------|--------|
| Intercept   | 6.194e+00   | 7.959e−03 778.250 | < 2e−16 |   *** |
| career_length | −3.437e−03 |   4.459e−04 −7.708 |   1.28e−14 |  ***   |
|  num_movies  | 4.481e−03 | 5.093e−04 | 8.798  | < 2e−16   | *** |
|  avg_runtime | −5.469e−06   | 1.369e−05 | −0.399 | 0.69   |  |
|  avg_numVotes   | 4.476e−06 | 1.910e−07 | 23.437 | < 2e−16   | *** |
|  is_dramatic | 1.598e−01 | 7.465e−03 | 21.408 | < 2e−16   | *** |
|  is_light_entertainment  | −1.114e−01   | 7.439e−03 | −14.982   | < 2e−16   | *** |
|  is_action_suspense   | −2.518e−01   | 7.808e−03 | −32.249   | < 2e−16   | *** |
|  is_speculative | −6.054e−01   | 8.403e−03 | −72.045  | < 2e−16 | *** |
|  is_non_fiction | 8.783e−01 | 8.095e−03 | 108.500   | < 2e−16   | *** |
|  genre_versatility | NA  | NA  | NA  | NA  |

Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

**R² = 0.89**, **Adjusted R² = 0.87**, **F-statistic = 45.67**, **p-value = 0.000001**



Based on this regression table, both career length and the amount of movies produced has a significant effect on the average movie ratings. A negative trend can be observed for both variables, however, the effect is stronger for the amount of movies produced as for the career length. This is better visible in the scatter plots included in the Rmd file.

The regression findings provide valuable insights for the film industry, guiding decisions in talent selection, budget allocation, and marketing strategies. For professionals such as producers and studio executives, the data suggests that directors with longer careers may produce films with declining ratings over time. This could prompt studios to focus on directors with shorter, more consistent track records and allocate budgets to those prioritizing quality over quantity. Marketing efforts could also emphasize high-rated works rather than an entire career.

For streaming platforms like Netflix and Amazon Prime, the results are important for selecting content and adjusting recommendation algorithms. Platforms may prefer directors with a consistent record of quality work and could focus on emerging filmmakers rather than established ones with declining ratings. This strategy helps maintain a balance between new talent and well-known directors.

Academically, the study opens avenues for research on the impact of career longevity on creative output, exploring whether long careers contribute positively or negatively to film quality. It also invites comparisons with other creative industries like music and literature, highlighting potential industry-specific trends and the influence of genre demands on a director's performance.


## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

To proceed with this R project, you'll need several specific packages. If these aren't already on your system, you can acquire them using the install.packages() command. For those packages you've previously installed, activate them with the library() function.
- library(tidyverse) 
- library(dplyr) 
- library(readr) 
- library(tinytex) 

To knit RMarkdown documents by using make and your command prompt, the pandoc package needs to be installed and added to your path.
See below the instructions for this for different types of devices

## Step 1: Install Pandoc

### Windows
- Download the installer from [Pandoc's official website](https://pandoc.org/installing.html) and install it.

### Mac (Homebrew)
1. Open **Terminal** (`Cmd + Space`, type `Terminal`, and press Enter).
2. Install Pandoc using Homebrew:
   Run: brew install pandoc
3. Verify the installation:
   Run: pandoc --version

### Linux (Debian/Ubuntu)
1. Open **Terminal** (`Ctrl + Alt + T`).
2. Install Pandoc:
   Run: sudo apt install pandoc
3. Verify the installation:
   Run: pandoc --version

## Step 2: Add Pandoc to System PATH

### Windows
1. Find the Pandoc installation path (e.g., `C:\Program Files\Pandoc`).
2. Open **Environment Variables**:
   - Press `Win + R`, type `sysdm.cpl`, and hit Enter.
   - Go to **Advanced** → **Environment Variables**.
3. Under **System variables**, find `Path` → Click **Edit**.
4. Click **New**, add `C:\Program Files\Pandoc`, and press **OK**.

### Mac/Linux
1. Add the following line to your shell configuration file (`~/.bashrc`, `~/.zshrc`, or `~/.bash_profile`):
   Run: export PATH="$HOME/.local/bin:$PATH"
2. Then apply the changes:
   Run:source ~/.bashrc  # or source ~/.zshrc

## Step 3: Verify Installation
Run in **Command Prompt (Windows)** or **Terminal (Mac/Linux)**:
Run: pandoc --version

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team < x > members: < insert member details>
