%dw 2.0
output application/json
---
{
	"error": error.errorMessage.payload default "Unknown error"
}