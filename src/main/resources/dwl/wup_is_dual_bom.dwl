%dw 2.0
output application/json

fun bomForOrg(orgCode) =
    (vars.bomArticleItem.assembly_item default [])
        filter ((a) -> a.inventory_org_code == orgCode)

fun hasValidBom(boms) =
    if (isEmpty(boms)) false
    else 
        !isEmpty((boms[0].components default []) filter ((c) -> (["P", "SA", "FG", "KIT", "PH"] contains c.component_item_type_code) and c.component_item_status_code != "Inactive"))

var ehqHasBom = hasValidBom(bomForOrg("EHQ"))
var esyHasBom = hasValidBom(bomForOrg("ESY"))

---
esyHasBom and ehqHasBom
