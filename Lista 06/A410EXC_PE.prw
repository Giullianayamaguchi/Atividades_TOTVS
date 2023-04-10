#Include "Protheus.ch"

/*/{Protheus.doc} A410EXC
    2 � Crie um campo na tabela SC5 com as seguintes
caracter�sticas:
o Nome do Campo: Tipo de Inclus�o
o Op��es do Campo (Lista): Manual / Autom�tico
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

User Function A410EXC()

    Local aArea := GetArea()
    LOCAL aAreaSC5 := SC5->(GetArea())
    LOCAL lRet := .T.
    
    IF ExistBlock('BloqPed')
       lRet := ExecBlock('BloqPed',.F.,.F.)
    ENDIF

    RestArea(aArea)
    RestArea(aAreaSC5)

Return lRet
     