%dw 2.0
output application/java

fun hasBomWithComponents(orgCode) =
    do {
        var assemblies =
            (vars.bomArticleItem.assembly_item default [])
                filter ((a) -> a.inventory_org_code == orgCode)
---               
if (isEmpty(assemblies)) false
else
!isEmpty((assemblies[0].components default []) filter ((c) -> (["P", "SA", "FG", "KIT", "PH"] contains c.component_item_type_code) and c.component_item_status_code != "Inactive"))
    }

var ehqHasBom = hasBomWithComponents("EHQ")
var esyHasBom = hasBomWithComponents("ESY")

---
if (ehqHasBom and (not esyHasBom)) "EHQ"         // Case 1
else if ((not ehqHasBom) and esyHasBom) "ESY"    // Case 2
else if (ehqHasBom and esyHasBom) "ESY"        // Case 4 – ESY preferred
else "NONE"                                    // Case 3 – no BOM from component