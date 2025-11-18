%dw 2.0
output application/java
var validComponentTypes = ["P", "SA", "FG", "KIT", "PH"]
---
{
    MaterialID: vars.currentMaterialID,
    numberOfComponents: sizeOf(
        vars.bomOfBomArticleItem.assembly_item[0].components filter ((component) -> 
            (validComponentTypes contains component.component_item_type_code) and (component.component_item_status_code != "Inactive")
        )
    )
}
