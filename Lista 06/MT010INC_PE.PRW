#include 'protheus.ch'

/*/{Protheus.doc} MT010INC
    5 – Utilizando Ponto de Entrada, crie uma rotina
que fará com que qualquer produto, quando for
cadastrado no Protheus, tenha o status de
bloqueado (B1_MSBLQL = 1)
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return lRet, Logico, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function MT010INC()
    Local aArea := GetArea()
    LOCAL aAreasb1 := sb1->(GetArea())
    LOCAL lRet := .T.

    IF ExistBlock('BloqAuto')
       lRet := ExecBlock('BloqAuto',.F.,.F.)
    ENDIF
    
    RestArea(aArea)
    RestArea(aAreasb1)

Return lRet
