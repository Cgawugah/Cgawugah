COVID-19 Data Analysis Project
Overview
This project involves analyzing COVID-19 data using SQL to extract meaningful insights. The data includes information on COVID-19 cases, deaths, and vaccinations across different countries and continents. The analysis aims to understand the impact of COVID-19 on various regions and the effectiveness of vaccination campaigns.

Data Sources
The data used in this project is stored in two tables:

CovidDeaths: Contains data on COVID-19 cases and deaths.
CovidVaccinations: Contains data on COVID-19 vaccinations.

SQL Queries
1. Selecting Data
   SELECT *
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3, 4;

2. Total Cases vs Total Deaths
Shows the likelihood of dying if you contract COVID-19 in your country.

SQL

SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 AS DeathPercentage
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
WHERE location LIKE '%Ghana%'
ORDER BY 1, 2;

3. Total Cases vs Population
Shows what percentage of the population has contracted COVID-19.

SQL

SELECT location, date, population, total_cases, (total_cases / population) * 100 AS PercentPopulationInfected
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
WHERE location LIKE '%Ghana%'
ORDER BY 1, 2;

4. Countries with Highest Infection Rate Compared to Population
SQL

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population) * 100) AS PercentPopulationInfected
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

5. Countries with Highest Death Count per Population
SQL

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

6. Breaking Down by Continent
SQL

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

7. Global Numbers
SQL

SELECT date, SUM(new_cases), SUM(CAST(new_deaths AS INT)) AS total_deaths, (SUM(CAST(new_deaths AS INT)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

8. Total Population vs Vaccination
SQL

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
JOIN [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

9. Using CTE
SQL

WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated) AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
    JOIN [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
    ON dea.location = vac.location AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM PopvsVac;

10. Using Temp Table
SQL

DROP TABLE IF EXISTS #PercentPopulationVaccinated;
CREATE TABLE #PercentPopulationVaccinated (
    continent NVARCHAR(255),
    location NVARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
JOIN [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT *, (RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated;

11. Creating Views
SQL

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
JOIN [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

Conclusion
This project demonstrates the use of SQL for data analysis, focusing on COVID-19 data. The queries provide insights into the spread and impact of the virus, as well as the progress of vaccination efforts. The use of various SQL techniques, including CTEs, temp tables, and views, showcases the versatility and power of SQL in handling complex data analysis tasks.
