%dw 2.0
/*Modify org, we are using variable that we created earlier and based on this we're modifying two functions
*/
import modules::functions
output application/json

var itemTypeMappings = {
    "P": "1",
    "SA": "2",
    "FG": "2",
    "KIT": "3",
    "PH": "4"
}
//setup earlier -> "Decide Org to use"
var org = (vars.orgToUse default "EHQ")

//change here, use var org during filter and add extra filter at the end (internalMovements)
var filteredItem = (vars.ArticleItem.item default []) filter ($.inventory_org_code == org and not (itemTypeMappings[$.item_type_code] == null)) filter ((item) -> !functions::isInternalMovementItem(item)) 

//change here, use var org during filter
var assembly_item = (vars.bomArticleItem.assembly_item default []) filter ($.inventory_org_code == org)

fun getLastProductionDate(statusCode) =
    if (statusCode == "Inactive") "2000.01.01" else "2999.12.31"

fun getComponents(record) =
    if ((assembly_item filter ((aItem) -> aItem.assembly_item_id == record.item_id)) != []) 
		(functions::filterBomComponents(assembly_item[0].components)
         map ((component) -> {
             MaterialID: component.component_item_number,
             Quantity: component.quantity,
             Sequence: component.sequence_number
         }))
    else []

fun transformRecord(record) = 
    if (getComponents(record) != []) {
        ({
            Article: {
                ArticleID: record.item_number,
                Name: record.item_description,
                Type: if (itemTypeMappings[record.item_type_code] != null) itemTypeMappings[record.item_type_code] else "0",
                SubType: (
                    if (record.item_type_code == "P") "" 
                    else if (("SA" default []) ++ ("FG" default []) contains record.item_type_code) "1" 
                    else if (record.item_type_code == "KIT") "3" 
                    else if (record.item_type_code == "PH") "4" 
                    else ""
                ),
                TariffNo: record.customs_tariff_number,
                NonPrefOrigin: record.country_of_origin,
                Unit: "",
                LastProductionDate: getLastProductionDate(record.item_status_code),
                Component: getComponents(record)
            }
        })
    } else null

---
//{
//    root: (filteredItem map (record) -> 
//        transformRecord(record)) filter ($ != null)
//}
filteredItem