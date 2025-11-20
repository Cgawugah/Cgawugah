# Covid 19 Global Data Exploration and Vaccination Analysis

This project is an exploratory SQL analysis of global Covid 19 data using the tables `CovidDeaths` and `CovidVaccinations` in the `PORTFOLIO PROJECTS` database.  
The goal is to understand how Covid 19 affected different countries and continents over time and how vaccination rollouts changed the share of the population protected.

All work is done directly in SQL and is suitable for feeding into later visualisation tools such as Power BI or Tableau.

## Project Objectives

• Explore trends in Covid 19 cases and deaths by country and continent  
• Calculate death rates and infection rates for individual countries  
• Identify countries with the highest infection rates and the highest death counts  
• Analyse global case and death trends over time  
• Relate population size to vaccination progress  
• Compute rolling counts of people vaccinated and the percentage of population vaccinated

## Dataset

Tables used

• `CovidDeaths`  
  Contains location, date, total cases, new cases, total deaths, population, continent and related fields.

• `CovidVaccinations`  
  Contains location, date and vaccination metrics including `new_vaccinations`.

Only records where `continent` is not null are used for global and regional analysis to exclude aggregate or non country entries.

## Analysis Performed

1. Basic data selection  
   Selected core columns such as location, date, total cases, new cases, total deaths and population from `CovidDeaths` as the base for analysis.

2. Case fatality analysis  
   For a specific country for example Ghana the script computes  
   `DeathPercentage = total_deaths / total_cases * 100`  
   This shows the likelihood of dying after contracting Covid 19 in that country.

3. Infection rate relative to population  
   Again at country level the script calculates  
   `PercentPopulationInfected = total_cases / population * 100`  
   to show what share of the population has been infected over time.

4. Countries with the highest infection rates  
   Using grouped aggregates the script finds for each country  
   • Maximum recorded total cases  
   • Maximum percentage of the population infected  

5. Countries and continents with the highest death counts  
   Aggregations on `total_deaths` identify  
   • Countries with the highest total death counts  
   • Continents with the highest total death counts  

6. Global time series of cases and deaths  
   By summing `new_cases` and `new_deaths` by date the script calculates  
   • Global new cases per day  
   • Global new deaths per day  
   • Global daily death percentage based on new cases and new deaths

7. Population versus vaccination progress  
   The deaths and vaccination tables are joined on location and date to relate population to vaccination data.  
   Window functions are then used to compute a rolling total of people vaccinated per location:

   `RollingPeopleVaccinated = SUM(new_vaccinations) OVER (PARTITION BY location ORDER BY location, date)`

   From this the percentage of the population vaccinated can be derived as  
   `RollingPeopleVaccinated / population * 100`.

8. Use of CTE and temporary table  
   • A common table expression `PopvsVac` stores intermediate results of the population versus vaccination calculation and then derives the share of population vaccinated.  
   • A temporary table `#PercentPopulationVaccinated` is created and populated with the same logic, allowing repeated querying of vaccination progress without recomputing the window function each time.

9. Creation of a view for visualisation  
   A persistent view `PercentPopulationVaccinated` is created to store the core vaccination progress metrics (location, date, population, new vaccinations and rolling people vaccinated).  
   This view can be consumed directly by reporting tools to build dashboards on vaccination progress over time.
   

## SQL Techniques Demonstrated

• Filtering and basic selection from large tables  
• Aggregate analysis with `GROUP BY` and `MAX`, `SUM`  
• Derived metrics such as death rate and infection rate  
• Window functions with `SUM() OVER (PARTITION BY ... ORDER BY ...)`  
• Common table expressions CTE  
• Temporary tables for intermediate storage  
• Creation of database views for downstream visualisation

## Files in This Repository

• Main SQL script containing all Covid 19 analysis queries  
• README.md providing project documentation

This project demonstrates how SQL alone can be used to explore a real world public health dataset and prepare clean, reusable outputs for dashboards and further analysis.
