%dw 2.0
output application/xml

var itemTypeMappings = {
    "P": "1",
    "SA": "2",
    "FG": "2",
    "KIT": "3",
    "PH": "4"
}

var filteredItem = vars.ArticleItem.item filter ($.inventory_org_code == "EHQ" and not (itemTypeMappings[$.item_type_code] == null))

var assembly_item = vars.bomArticleItem.assembly_item filter ($.inventory_org_code == "EHQ")

fun getLastProductionDate(statusCode) =
    if (statusCode == "Inactive") "2000.01.01" else "2999.12.31"

fun getComponents(record) =
    if ((assembly_item filter ((aItem) -> aItem.assembly_item_id == record.item_id)) != []) 
        (assembly_item[0].components 
         filter ((item) -> ["P","SA","FG","KIT","PH"] contains item.component_item_type_code) 
         filter ((item) -> item.component_item_status_code != "Inactive") 
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
{
    root: (filteredItem map (record) -> 
        transformRecord(record)) filter ($ != null)
}