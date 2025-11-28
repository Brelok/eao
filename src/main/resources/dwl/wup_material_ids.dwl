%dw 2.0
output application/json
var validComponentTypes = ["P", "SA", "FG", "KIT", "PH"]
var filteredComponents = (vars.bomArticleItem.assembly_item[0].components filter ((component) -> 
    (validComponentTypes contains component.component_item_type_code) and (component.component_item_status_code != "Inactive")) 
) map {
    MaterialID: $.component_item_number,
    MaterialType: $.component_item_type_code
}
---
if (sizeOf(filteredComponents) > 0)
    filteredComponents
else
    null
