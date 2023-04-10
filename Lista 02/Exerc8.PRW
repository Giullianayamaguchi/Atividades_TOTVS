
 #INCLUDE 'PROTHEUS.CH'

 USER Function L1_E8()

    Local cName := "Giu"
    Local cSennha :="Senha"
    Local cNome 
    Local ctenta

    cNome = FWINPUTBOX("Digite o login: ", "")
    cTenta = FWINPUTBOX("Digite a senha: ", "")

    if ((cNome = cName) .and. (cTenta = cSennha))
        MsgAlert(" Acesso permitido")

    else 
        MsgStop("Usuário ou senha inválido")
    
    ENDIF


 RETURN
