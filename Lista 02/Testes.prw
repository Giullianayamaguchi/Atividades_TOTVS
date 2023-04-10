//Bibliotecas
#Include "Protheus.ch"
  
User Function aaa(cUsrLog, cPswLog)
    Local aArea := GetArea()
    Local oGrpLog
    Local oBtnConf
    Private lRetorno := .F.
    Private oDlgPvt
    //Says e Gets
    Private oSayUsr
    Private oGetUsr, cGetUsr := Space(25)
    Private oSayPsw
    Private oGetPsw, cGetPsw := Space(20)
    Private oGetPsw2, cGetPsw2 := Space(20)
    Private oGetErr, cGetErr := ""
    //Dimensões da janela
    Private nJanLarg := 200
    Private nJanAltu := 200
      
    //Criando a janela
    DEFINE MSDIALOG oDlgPvt TITLE "Cadastro" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Grupo de Login
            @ 003, 001     GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Login: "     OF oDlgPvt COLOR 0, 16777215 PIXEL
            //Label e Get de Usuário
            @ 013, 006   SAY   oSayUsr PROMPT "Usuário:"        SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 020, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL
          
            //Label e Get da Senha
            @ 033, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 040, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD

            @ 053, 006   SAY   oSayPsw PROMPT "Confirmar Senha:"          SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 060, 006   MSGET oGetPsw2 VAR    cGetPsw2           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD
          
            //Get de Log, pois se for Say, não da para definir a cor
            @ 073, 006   MSGET oGetErr VAR    cGetErr        SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
            oGetErr:lActive := .F.
            oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
          
            //Botões
            @ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Confirmar"             SIZE (nJanLarg/2)-12, 010 OF oDlgPvt ACTION (fVldUsr()) PIXEL
            @ (nJanAltu/2)-10, 006 BUTTON oBtnSair PROMPT "Sair"                  SIZE (nJanLarg/2)-12, 010 OF oDlgPvt ACTION (fVldUsr()) PIXEL
            oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    ACTIVATE MSDIALOG oDlgPvt CENTERED
      
    //Se a rotina foi confirmada e deu certo, atualiza o usuário e a senha
    If lRetorno
        cUsrLog := Alltrim(cGetUsr)
        cPswLog := Alltrim(cGetPsw)
        cPswLog2 := Alltrim(cGetPsw2)

    EndIf
      
    RestArea(aArea)
Return lRetorno
  
Static Function fVldUsr()
    Local cUsrAux  := Alltrim(cGetUsr)
    Local cPswAux  := Alltrim(cGetPsw)
    Local cPswAux2 := Alltrim(cGetPsw2)

    //Pega o código do usuário
   RPCClearEnv()
        if (len(cUsrAux) >= 5)
            if (len(cPswAux) >= 6) 
                cPswAux := oGetPsw
                
                if (len(cPswAux2) == 6)
                    cPswAux2 := oGetPsw2
                    lRetorno := .T.
                
                Else
                    cGetErr := "Usuário e/ou senha inválidos!"
                    oGetErr:Refresh()


                ENDIF    

            Else
                cGetErr := "Usuário e/ou senha inválidos!"
                oGetErr:Refresh()

            ENDIF
     //Senão atualiza o erro e retorna para a rotina
     Else
         cGetErr := "Usuário e/ou senha inválidos!"
         oGetErr:Refresh()
    EndIf
      
    //Se o retorno for válido, fecha a janela
    If lRetorno
        oDlgPvt:End()
        FwAlertSucess("Usuário cadastrado com sucessso")
    EndIf
Return
