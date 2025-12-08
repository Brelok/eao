%dw 2.0
/*
 * Using in both cases:
 * 1) planning_make_buy_Code == "Buy"
 * 	item is Trading Goods type in OEBS, regarding business rules always EHQ
 * 2) Case 3 (no BOM with components in EHQ or ESY)
 * 	item treated also as Trading Good
 */
import modules::functions
output application/xml

var org = "EHQ"   // Buy and Case 3 logic → always EHQ

fun getLastProductionDate(statusCode) =
    if (statusCode == "Inactive") "2000.01.01" else "2999.12.31"
    
var itemTypeMappings = {
    "P": "1",
    "SA": "1",
    "FG": "1",
    "KIT": "1",
    "PH": "1"
}

//add filter about internalMovements at the end
var filteredItems = vars.ArticleItem.item filter ($.inventory_org_code == org and itemTypeMappings[$.item_type_code] != null) filter ((item) -> !functions::isInternalMovementItem(item)) 

---
{
    root: {
        (filteredItems map (item) -> {
            Article: {
                ArticleID: item.item_number,
                Name: item.item_description,
                Type: itemTypeMappings[item.item_type_code],
                SubType: "",
                TariffNo: item.customs_tariff_number,
                NonPrefOrigin: item.country_of_origin,
                Unit: item.primary_uom_code,
                LastProductionDate: getLastProductionDate(item.item_status_code)
            }
        })
    }
}