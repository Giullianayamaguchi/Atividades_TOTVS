#include "PROTHEUS.CH"

USER fUNCTION L1_E16()
    Local cNome  := ""
    Local cSenh := ""
    Local cConf  := ""
    Local lSair  := .f.
    Local lRet   := .f.

    while !lSair

        cNome:= FwInputBox( "Digite o userName" , "no minimo 5 caracteres: ")

        if (len(cNome) <= 5)
            MSGALERT("nome de usuario incorreta, tente novamente")
            loop
        else 
            lSair := .t.
        ENDIF
    END
    lSair := .f.

    while !lSair
        cSenh := FwInputBox( "Digite uma senha: ")

        if (len(cSenh) >= 6) 

           if (lRet := verifica(cSenh)) == .f.
                MSGALERT("Senha incorreta, verifique se a senha possi 1 letra maiuscula, 1 digito e 1 simbolo") 
                loop
           ENDIF
        else
            MSGALERT("Senha incorreta, verifique se a senha possi mais de 6 caracteres")    
            Loop
        ENDIF
        cConf:= FwInputBox( "Digite a senha novamente: ")
        
        if (cConf == cSenh)
            FwAlertSucess("senha correta, ususario cadastrado com sucesso")
            lSair := .t.
        else 
            MSGALERT("senhas diferentes, favor tentar novamente")
            loop
        ENDIF
    ENDDO
RETURN Nil

static Function verifica(cSenh)

    Local lRetorno := .f.
    Local nCont    := 0
    Local aPossui :={"", "", ""}

    for nCont := 1 to len(cSenh)
    
        if asc(SubStr(cSenh, nCont, 1)) >= 48 .and. asc(SubStr(cSenh, nCont, 1)) <= 57
            aPossui[1] := "ok"
        ENDIF

        if asc(SubStr(cSenh, nCont, 1)) >= 65 .and. asc(SubStr(cSenh, nCont, 1)) <= 90
            aPossui[2] := "ok"
        ENDIF

        if (asc(SubStr(cSenh, nCont, 1)) >= 33 .and. asc(SubStr(cSenh, nCont, 1)) <= 47) .or.(asc(SubStr(cSenh, nCont, 1)) >=58 .and. asc(SubStr(cSenh, nCont, 1)) <=64) .or. (asc(SubStr(cSenh, nCont, 1)) >= 91 .and. asc(SubStr(cSenh, nCont, 1)) <= 96) .or. (asc(SubStr(cSenh, nCont, 1)) >= 123 .and. asc(SubStr(cSenh, nCont, 1)) <= 126)
            aPossui[3] := "ok"
       ENDIF
    NEXT

    if aPossui[1] =="ok" .and. aPossui[2] == "ok" .and. aPossui[3] == "ok"
        lRetorno := .t.
    ENDIF
RETURN lRetorno
