%dw 2.0
output application/json

fun bomForOrg(orgCode) =
    (vars.bomArticleItem.assembly_item default [])
        filter ((a) -> a.inventory_org_code == orgCode)

fun hasValidBom(boms) =
    if (isEmpty(boms)) false
    else 
        !isEmpty((boms[0].components default []) filter ((c) -> (["P", "SA", "FG", "KIT", "PH"] contains c.component_item_type_code) and c.component_item_status_code != "Inactive"))

var ehqBoms = bomForOrg("EHQ")
var esyBoms = bomForOrg("ESY")

var ehqHasBom = hasValidBom(ehqBoms)
var esyHasBom = hasValidBom(esyBoms)

---
if (esyHasBom and ehqHasBom) "ESY"
else if (esyHasBom) "ESY"
else if (ehqHasBom) "EHQ"
else "NONE"

