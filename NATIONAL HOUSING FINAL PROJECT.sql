
SELECT*
FROM NationalHousing

--STANDARDIZED DATE FORMAT

Select saledateconverted, convert(date, saledate)
from [PORTFOLIO PROJECTS].dbo.NationalHousing

Update NationalHousing
set SaleDate = convert(date, saledate)

ALter table NationalHousing
Add saledateconverted Date; 

Update NationalHousing
set saledateconverted = convert(date, saledate)


--POPULATE PROPERTY ADDRESS

Select*
from [PORTFOLIO PROJECTS].dbo.NationalHousing
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress)
from [PORTFOLIO PROJECTS].dbo.NationalHousing a
join [PORTFOLIO PROJECTS].dbo.NationalHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from [PORTFOLIO PROJECTS].dbo.NationalHousing a
join [PORTFOLIO PROJECTS].dbo.NationalHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS, CITY AND STATE)

Select PropertyAddress
from [PORTFOLIO PROJECTS].dbo.NationalHousing
--where PropertyAddress is null
--order by ParcelID

select
SUBSTRING(propertyAddress, 1, CHARINDEX(',', PropertyAddress)) as Address,
SUBSTRING(propertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as Address
from [PORTFOLIO PROJECTS].dbo.NationalHousing



ALter table NationalHousing
Add PropertySplitAddress NVARCHAR(255); 

Update NationalHousing
set PropertySplitAddress  = SUBSTRING(propertyAddress, 1, CHARINDEX(',', PropertyAddress) + 1)


ALter table NationalHousing
Add PropertySplitCity NVARCHAR(255); 

Update NationalHousing
set PropertySplitCity = SUBSTRING(propertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))


select*
from NationalHousing


select OwnerAddress
from NationalHousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from NationalHousing



ALter table NationalHousing
Add OwnerSplitAddress NVARCHAR(255); 

Update NationalHousing
set OwnerSplitAddress  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALter table NationalHousing
Add OwnerSplitCity NVARCHAR(255); 

Update NationalHousing
set OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALter table NationalHousing
Add OwnerSplitState NVARCHAR(255); 

Update NationalHousing
set OwnerSplitState  = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

select*
from NationalHousing

--CHANGE Y AND N TO YES AND NO IN 'SOLD AS VACANT FIELD'

SELECT DISTINCT(SoldAsVacant), count(SoldAsVacant)
from NationalHousing
Group by SoldAsVacant
Order by 2

select SoldAsVacant,
CASE When SoldAsVacant = 'y' then 'Yes'
     When SoldAsVacant = 'n' then 'No'
else SoldAsVacant
end 
from NationalHousing


UPDATE NationalHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'y' then 'Yes'
     When SoldAsVacant = 'n' then 'No'
else SoldAsVacant
end 


--REMOVE DUPLICATES

with RowNumCTE AS(
SELECT*,
      ROW_NUMBER() OVER (
	  PARTITION BY ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   Order by
				       UniqueID
					   )Row_Num
FROM NationalHousing
--Order By ParcelID
)
SELECT*
from RowNumCTE
where row_num > 1
--Order by PropertyAddress 


--DELETE UNUSED COLUMNS

Select*
from NationalHousing

ALTER TABLE  NationalHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE  NationalHousing
DROP COLUMN SaleDate


