#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} CUSTOMERVENDOR
    9 – Implemente uma validação na exclusão de
Cadastros de Fornecedores. O sistema deverá
perguntar se o usuário confirma a exclusão do
cadastro, se ele confirmar, o cadastro deverá ser
excluído, caso contrário, deverá permanecer na
tela de exclusão.
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
                lRet := MSGYESNO("Deseja realmente excluir", "atenção")
            ENDIF
        ENDIF
    ENDIF
RETURN lRet
