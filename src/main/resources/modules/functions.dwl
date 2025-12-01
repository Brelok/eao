%dw 2.0
var filterEnabled = (Mule::p("internal.movements.filter.enabled") default false) as Boolean
var itemFlagValues = (Mule::p("internal.movements.item.flag.values") default "") splitBy "," map trim($)
var itemFlagField = (Mule::p("internal.movements.item.flag.field") default "") as String
var componentFlagValues = (Mule::p("internal.movements.component.flag.values") default "") splitBy "," map trim($)
var componentFlagField = (Mule::p("internal.movements.component.flag.field") default "") as String

fun hasInternalFlag(obj, fieldName, values) = 
	if (!filterEnabled or isBlank(fieldName)) false
	else 
        do {
            var flag = (obj[fieldName] default "") as String
            ---
            values contains (flag)
        }
        
fun isInternalMovementItem(item) =
    hasInternalFlag(item, itemFlagField, itemFlagValues)

fun isInternalMovementComponent(component) =
    hasInternalFlag(component, componentFlagField, componentFlagValues)
    
// if BOM component is "important" for FORMAT-WUP
fun isValidBomComponent(comp) =
    ["P","SA","FG","KIT","PH"] contains (comp.component_item_type_code default "") and
    (comp.component_item_status_code default "") != "Inactive" and
    not isInternalMovementComponent(comp)

// common filter to all places where we are processing BOM
fun filterBomComponents(components) =
    (components default [])
        filter isValidBomComponent
        