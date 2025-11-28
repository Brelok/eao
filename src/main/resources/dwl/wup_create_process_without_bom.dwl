%dw 2.0
import modules::functions
output application/xml

fun getLastProductionDate(statusCode) =
    if (statusCode == "Inactive") "2000.01.01" else "2999.12.31"
var itemTypeMappings = {
    "P": "1",
    "SA": "2",
    "FG": "2",
    "KIT": "2",
    "PH": "4"
}
//add filter about internalMovements at the end
var filteredItem = vars.ArticleItem.item filter ($.inventory_org_code == "EHQ" and not (itemTypeMappings[$.item_type_code] == null)) filter ((item) -> !functions::isInternalMovementItem(item))

fun mapItemType(itemType: String): String =
    if (itemTypeMappings[itemType] != null) itemTypeMappings[itemType] else "0" 
---
{
    root: {
        (filteredItem map ((record, index) -> {
            Article: {
                ArticleID: record.item_number,
                Name: record.item_description,
                Type: if (itemTypeMappings[record.item_type_code] != null) itemTypeMappings[record.item_type_code] else "0",
               SubType: (
                   if (record.item_type_code == "P") "" 
                   else if (("SA" default [])  contains record.item_type_code) "1" 
                   else if (record.item_type_code == "KIT") "3" 
                    else if (record.item_type_code == "PH") "4" 
                    else if (record.item_type_code == "FG") "1" 
                    else ""
                ),
                TariffNo: record.customs_tariff_number,
                NonPrefOrigin: record.country_of_origin,
                Unit: record.primary_uom_code,
                LastProductionDate: getLastProductionDate(record.item_status_code)
            }
        }))
    }
}