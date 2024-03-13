select*
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
where continent is not null
order by 3,4


--select*
--from [PORTFOLIO PROJECTS].dbo.Covidvaccinations
--order by 3,4

--select data that we are going to be using
select location, date, total_cases, new_cases, total_deaths, population
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
order by 1,2

--LOOKING AT TOTAL CASES VS TOTAL DEATHS
--Shows the likelyhood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
where location like '%Ghana%'
order by 1,2


--LOOKING AT TOTAL CASES VS POPULATION
--shows what percentge of population has got covid

select location, date, population, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
where location like '%Ghana%'
order by 1,2


--LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

select location, population, max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
--where location like '%Ghana%'
Group by location, population
Order by PercentPopulationInfected desc


--SHOWING COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
--where location like '%Ghana%'
Where continent is not null
Group by location
Order by TotalDeathCount desc


--LETS BREAK THINGS DOWN BY CONTINENT

select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
--where location like '%Ghana%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc


--SHOWING THE CONTINENTS WITH THE HIGHEST DEATH COUNT

select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
--where location like '%Ghana%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc


--GLOBAL NUMBERS

select date, sum(new_cases), sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [PORTFOLIO PROJECTS].dbo.CovidDeaths
--where location like '%Ghana%'
Where continent is not null
Group by date
order by 1,2


--LOOKING AT TOTAL POPULATION VS VACCINATION

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location)
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
Join [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
order by 2,3

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
Join [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
order by 2,3


--USE CTE

With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
Join [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
select*, (RollingPeopleVaccinated/population)*100
from PopvsVac


--TEMP TABLE

Drop table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)


Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
Join [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

select*, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated


--CREATING VIEWS TO STORE DATA FOR LATER VISUALIZATIONS

 Create view PercentPopulationVaccinated as
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
FROM [PORTFOLIO PROJECTS].dbo.CovidDeaths dea
Join [PORTFOLIO PROJECTS].dbo.Covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
--order by 2,3















