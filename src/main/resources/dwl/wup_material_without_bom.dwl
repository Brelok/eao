%dw 2.0
/*Also here we are checking if BOM doesn't exist but still will be internalMovements 
*/
import modules::functions
output application/java
---
do {
    var item = vars.originalPayload
    var isInvalid = functions::isInternalMovementComponent(item)
    ---
    {
        MaterialID: vars.currentMaterialID,
        numberOfComponents: if (isInvalid) 0 else 1
    }
}