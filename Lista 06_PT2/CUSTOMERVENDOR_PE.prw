#include 'protheus.ch'

/*/{Protheus.doc} CUSTOMERVENDOR
    8 – Cri uma rotina que apresentará mensagens
diferentes em cada uma das seguintes situações
dos Cadastros de Fornecedores:
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

    Local aParam   := PARAMIXB 
    Local oObj  := NIL
    Local cIdPonto := ''
    Local cIdModel := ''
    Local lRet := .T.

    if aParam <> NIL 
        oObj := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        // if INCLUI .and. cIdPonto == 'MODELVLDACTIVE'
        //     msgInfo("Seja Bem vindo(a) ao Cadastro de Fornecedores!")
        
        // ELSEIF ALTERA .and. cIdPonto == 'MODELVLDACTIVE'
        //     msgInfo("Você está prestes a alterar o cadastro do fornecedor " + alltrim(SA2->A2_NOME) +"!")
        
        // ELSEIF CCADASTRO == 'Fornecedores - EXCLUIR' .and. cIdPonto == 'MODELVLDACTIVE'
        //     msgInfo("Cuidado, você está prestes a excluir o fornecedor " + alltrim(SA2->A2_NOME) +"!")
        // ENDIF

        if cIdPonto == 'MODELVLDACTIVE'
            IF ExistBlock('MsgCadas')
                lRet := ExecBlock('MsgCadas',.F.,.F.)
            ENDIF
        ENDIF

    ENDIF
RETURN lRet
