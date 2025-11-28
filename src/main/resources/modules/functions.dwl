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
        