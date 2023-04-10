/*15 – Ler 12 elementos de um array e colocá-los em
ordem crescente.
Obs: NÃO é permitido o uso da função ASORT(). */

#INCLUDE "TOTVS.CH"

User Function L5_E15()
    Local aArray := {12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}
    Local nI := 0, nCount := 0, nAux := 0

    For nCount := 1 to len(aArray)
        For nI := 1 to len(aArray)
            if aArray[nI] > aArray[nCount]
                nAux := aArray[nCount]
                aArray[nCount] := aArray[nI]
                aArray[nI] := nAux
            endif
        Next
    Next

    FwAlertInfo(ArrToKStr(aArray, ", ") + ".", "Array exibido com função.")

Return
