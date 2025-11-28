%dw 2.0
var filterEnabled = (Mule::p("internal.movements.filter.enabled") default false) as Boolean
var flagValues = (Mule::p("internal.movements.flag.values") default "") splitBy "," map trim($)
var flagField = (Mule::p("internal.movements.flag.field") default "") as String

fun isInternalMovement (obj) = 
	if (!filterEnabled) false
	else 
        do {
            var flag = (obj[flagField] default "") as String
            ---
            flagValues contains (flag)
        }