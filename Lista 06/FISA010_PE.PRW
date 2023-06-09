#INCLUDE "PROTHEUS.CH"

/*/{Protheus.doc} FISA010
    10 � Desenvolva um PE na rotina FISA010 (Cadastro
de Munic�pios � M�dulo 09). Esse PE deve ser
utilizado para que, quando o usu�rio confirmar a
inclus�o de um novo munic�pio seja verificado se o
nome j� existe para a UF selecionada.
Se j� existir, exibir uma mensagem e impedir que o
processo continue. Caso contr�rio, deixar o
programa prosseguir normalmente.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @return lRet, Logico, retorna .T. ou .F. dependendo da resposta do usu�rio 
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
