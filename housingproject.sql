Select *
From PortfolioProject.housingdatacleaning




--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

select *
from housingdatacleaning

select saleDate, CONVERT(Date, saleDate)
from housingdatacleaning


Select saleDateConverted, CONVERT(Date,SaleDate)
From housingdatacleaning


Update housingdatacleaning
SET SaleDate = CONVERT(Date,SaleDate)



ALTER TABLE housingdatacleaning
Add SaleDateConverted Date;

Update housingdatacleaning
SET SaleDateConverted = CONVERT(Date,SaleDate)


 --------------------------------------------------------------------------------------------------------------------------

select propertyaddress
from housingdatacleaning

Select propertyaddress
From housingdatacleaning
Where PropertyAddress is null
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From housingdatacleaning a
JOIN housingdatacleaning b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From housingdatacleaning a
JOIN housingdatacleaning b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------




Select PropertyAddress
From housingdatacleaning
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From housingdatacleaning


ALTER TABLE housingdatacleaning
Add PropertySplitAddress Nvarchar(255);

Update housingdatacleaning
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE housingdatacleaning
Add PropertySplitCity Nvarchar(255);

Update housingdatacleaning
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




Select *
From housingdatacleaning





Select OwnerAddress
From housingdatacleaning


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From housingdatacleaning



ALTER TABLE housingdatacleaning
Add OwnerSplitAddress Nvarchar(255);

Update housingdatacleaning
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE housingdatacleaning
Add OwnerSplitCity Nvarchar(255);

Update housingdatacleaning
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE housingdatacleaning
Add OwnerSplitState Nvarchar(255);

Update housingdatacleaning
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



 




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select SoldAsVacant
From housingdatacleaning

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From housingdatacleaning
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From housingdatacleaning




Update housingdatacleaning
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
       
       select soldasvacant
       from housingdatacleaning





-----------------------------------------------------------------------------------------------------------------------------------------------------------



WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From housingdatacleaning
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From housingdatacleaning




---------------------------------------------------------------------------------------------------------





Select *
From housingdatacleaning


ALTER TABLE  housingdatacleaning
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate















 
 