#Include "Protheus.ch"

/*/{Protheus.doc} L4_E7
    7 -Fazer um programa que simule um cadastro de
usuário e senha para um sistema qualquer.
O usuário informará um “username” e uma senha
que deverá ser digitada duas vezes (confirmação
de senha).
Realizar as seguintes consistências:
o O “username” deve possuir mais do que 5
caracteres.
o A senha e a confirmação da senha devem ser
idênticas.
o A senha deve possuir ao menos 6 caracteres
e deve conter obrigatoriamente:
? Ao menos uma letra maiúscula, um dígito
numérico e um símbolo.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return lRetorno, Logico, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function L4_E7(cUsrLog, cPswLog, cPswLog2)
    Local aArea := GetArea()
    Local oGrpLog
    Local oBtnConf
    LOCAL cUser      := 'Digite o Usuário: '
    LOCAL cPasw     := 'Digite a Senha: '
    LOCAL cPasw2     := 'Digite a Confirmação da Senha: '
    LOCAL cResul     := '  Entrar  '
    LOCAL cSair      := ' Cancelar '
    Private lRetorno := .F.
    Private oDlgPvt
    Private oSayUsr
    Private oGetUsr, cGetUsr := Space(25)
    Private oSayPsw
    Private oGetPsw, cGetPsw := Space(20)
    Private oGetPsw2, cGetPsw2 := Space(20)
    Private oGetErr, cGetErr := ""

    //Dimensões da janela
    Private nJanLarg := 200
    Private nJanAltu := 250
      
    //Criando a janela
    DEFINE MSDIALOG oDlgPvt TITLE "Cadastro" FROM 000, 000 TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Grupo de Login
    @ 003, 001     GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Login: "     OF oDlgPvt COLOR 0, 16777215 PIXEL
            //Label e Get de Usuário
    @ 013, 006   SAY   oSayUsr PROMPT cUser    SIZE 055, 007 OF oDlgPvt                    PIXEL
    @ 020, 006   MSGET oGetUsr VAR    cGetUsr  SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL
          
            //Label e Get da Senha
    @ 033, 006   SAY   oSayPsw PROMPT cPasw    SIZE 055, 007 OF oDlgPvt                    PIXEL
    @ 040, 006   MSGET oGetPsw VAR    cGetPsw  SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD

    @ 053, 006   SAY   oSayPsw PROMPT cPasw2   SIZE 055, 007 OF oDlgPvt                    PIXEL
    @ 060, 006   MSGET oGetPsw2 VAR   cGetPsw2 SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD

    @ 90, 006   MSGET oGetErr VAR    cGetErr  SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
    oGetErr:lActive := .F.
    oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
  
            //Botões
    @ 073, 006 BUTTON oBtnConf PROMPT cResul   SIZE (nJanLarg/2)-12, 010 OF oDlgPvt ACTION (ValidaUsuario()) PIXEL
    @ 083, 006 BUTTON oBtnSair PROMPT cSair    SIZE (nJanLarg/2)-12, 010 OF oDlgPvt ACTION (ValidaUsuario()) PIXEL

    ACTIVATE MSDIALOG oDlgPvt CENTERED

    If lRetorno
        cUsrLog := Alltrim(cGetUsr)
        cPswLog := Alltrim(cGetPsw)
        cPswLog2 := Alltrim(cGetPsw2)

    EndIf
      
    RestArea(aArea)
Return lRetorno
  
Static Function ValidaUsuario()
    Local cUsrAux  := Alltrim(cGetUsr)
    Local cPswAux  := Alltrim(cGetPsw)
    Local cPswAux2 := Alltrim(cGetPsw2)

   RPCClearEnv()
        if (len(cUsrAux) >= 5)
            if (len(cPswAux) >= 6) 
                
                if ((cPswAux2) == (cPswAux))
                    if ValdiaSenha(cPswAux)
                        lRetorno := .T.

                    Else
                    cGetErr := FwAlertError("Favor revisar se a senha contém uma letra maiúscula, um dígito, um numérico e um símbolo.!")
                    oGetErr:Refresh()

                    ENDIF
                Else
                    cGetErr := "Favor revisar sem as senhas estão iguais"
                     oGetErr:Refresh()

                ENDIF    

            Else
                cGetErr := "Favor revisar se a senha contem mais de 6 caracteres"
                oGetErr:Refresh()

            ENDIF
     //Senão atualiza o erro e retorna para a rotina
     Else
         cGetErr := "Usuário inválido!"
         oGetErr:Refresh()
    EndIf
      
    //Se o retorno for válido, fecha a janela
    If lRetorno
        oDlgPvt:End()
        FwAlertSucess("Usuário cadastrado com sucessso")
    EndIf

RETURN

static Function ValdiaSenha(cPswAux)

    Local lRetorno := .f.
    Local nCont    := 0
    Local aPossui :={"", "", ""}

    for nCont := 1 to len(cPswAux)
    
        if asc(SubStr(cPswAux, nCont, 1)) >= 48 .and. asc(SubStr(cPswAux, nCont, 1)) <= 57
            aPossui[1] := "ok"
        ENDIF

        if asc(SubStr(cPswAux, nCont, 1)) >= 65 .and. asc(SubStr(cPswAux, nCont, 1)) <= 90
            aPossui[2] := "ok"
        ENDIF

        if (asc(SubStr(cPswAux, nCont, 1)) >= 33 .and. asc(SubStr(cPswAux, nCont, 1)) <= 47) .or.(asc(SubStr(cPswAux, nCont, 1)) >=58 .and. asc(SubStr(cPswAux, nCont, 1)) <=64) .or. (asc(SubStr(cPswAux, nCont, 1)) >= 91 .and. asc(SubStr(cPswAux, nCont, 1)) <= 96) .or. (asc(SubStr(cPswAux, nCont, 1)) >= 123 .and. asc(SubStr(cPswAux, nCont, 1)) <= 126)
            aPossui[3] := "ok"
       ENDIF
    NEXT

    if aPossui[1] =="ok" .and. aPossui[2] == "ok" .and. aPossui[3] == "ok"
        lRetorno := .t.
    ENDIF
RETURN lRetorno


