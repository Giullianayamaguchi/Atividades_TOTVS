#include 'protheus.ch'

 /*/{Protheus.doc} M030INC
    6 – Utilizando Ponto de Entrada, crie uma rotina
que fará com que qualquer cliente, quando for
cadastrado no Protheus, tenha o status de
bloqueado (A1_MSBLQL = 1).
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


User Function M030INC()
    Local aArea := GetArea()
    LOCAL aAreaSA1 := SA1->(GetArea())
    LOCAL lRet := .T.


    IF ExistBlock('BloqCli')
       lRet := ExecBlock('BloqCli',.F.,.F.)
    ENDIF

  
    RestArea(aArea)
    RestArea(aAreaSA1)

Return lRet
