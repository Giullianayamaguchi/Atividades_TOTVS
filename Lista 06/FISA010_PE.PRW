#INCLUDE "PROTHEUS.CH"

/*/{Protheus.doc} FISA010
    10 – Desenvolva um PE na rotina FISA010 (Cadastro
de Municípios – Módulo 09). Esse PE deve ser
utilizado para que, quando o usuário confirmar a
inclusão de um novo município seja verificado se o
nome já existe para a UF selecionada.
Se já existir, exibir uma mensagem e impedir que o
processo continue. Caso contrário, deixar o
programa prosseguir normalmente.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @return lRet, Logico, retorna .T. ou .F. dependendo da resposta do usuário 
    /*/



USER FUNCTION FISA010()

    Local aParam   := PARAMIXB
    Local lRet     := .T.
    Local oObj     := Nil
    Local cIdPonto := ''
    Local cIdModel := ''

    IF aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
         
        IF cIdPonto == "MODELPOS"
            IF ExistBlock('ValidaCidade')
                lRet := ExecBlock('ValidaCidade',.F.,.F.)
            ENDIF
        ENDIF

    ENDIF
    
RETURN lRet
