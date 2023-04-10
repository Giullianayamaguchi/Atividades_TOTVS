#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} CUSTOMERVENDOR
    9 � Implemente uma valida��o na exclus�o de
Cadastros de Fornecedores. O sistema dever�
perguntar se o usu�rio confirma a exclus�o do
cadastro, se ele confirmar, o cadastro dever� ser
exclu�do, caso contr�rio, dever� permanecer na
tela de exclus�o.
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


USER FUNCTION CUSTOMERVENDOR()

    Local aParam    := PARAMIXB
    Local lRet      := .T.
    LOCAL cIdPonto  := ''
    Local oObj      := NIL
    Local cIdModel  := ''
    Local nOper     := 0

    If aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        IF cIdPonto == "BUTTONBAR"
        nOper := oObj:nOperation

            IF nOper ==5
                lRet := MSGYESNO("Deseja realmente excluir", "aten��o")
            ENDIF
        ENDIF
    ENDIF
RETURN lRet
