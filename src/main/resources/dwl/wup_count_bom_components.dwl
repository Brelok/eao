%dw 2.0
/*if all components will be internal we set numberOfComponents=0 
 * so later we will throwing away in 'Generate payload without components'
 * According to documentation FORMAT-WUP has to contain at least 1 component
*/
output application/java
import modules::functions
var components = (vars.bomOfBomArticleItem.assembly_item[0].components default [])
var filteredComponents = components
        filter ((c) -> ["P","SA","FG","KIT","PH"] contains (c.component_item_type_code default ""))
        filter ((c) -> c.component_item_status_code != "Inactive")
        filter ((c) -> not functions::isInternalMovementComponent(c))
---
{
    MaterialID: vars.currentMaterialID,
    numberOfComponents: sizeOf(filteredComponents)
}
