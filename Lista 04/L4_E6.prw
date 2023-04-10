#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E6
    6 – Faça um algoritmo para ler um nome de usuário
(user name) e uma senha. Caso correspondam aos
dados armazenados internamente no programa
através do uso de constantes (hard coded), deve
ser apresentada a mensagem “Acesso permitido”.
Caso o usuário/senha não coincidam, exibir a
mensagem “Usuário ou senha inválido”. A
verificação da senha só deverá ocorrer caso o
usuário coincida, porém o usuário não deve saber
especificamente se foi o nome de usuário ou a
senha que não coincidiu.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return 
    @example
    (examples)
    @see (links_or_references)
    /*/

USER FUNCTION L4_E6()
    LOCAL cTitle     := "Cadastro"
    LOCAL cText      := 'Digite o usuário'
    LOCAL cText2     := 'Digite a senha'
    LOCAL cResul     := ' Entrar '
    LOCAL cSair      := '   Sair '
    LOCAL nUser      := Space(20)
    LOCAL nPasw      := Space(20)
    LOCAL oDlg       := NIL
    LOCAL nOpcao     := 0
    Private oDlgPvt  := NIL
    Private nJanLarg := 150
    Private nJanAltu := 370


    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanLarg, nJanAltu PIXEL
    @ 014, 010 SAY cText  SIZE 55, 07 OF oDlg PIXEL
    @ 030, 010 SAY cText2 SIZE 55, 07 OF oDlg PIXEL

    @ 014, 060 MSGET nUser SIZE 55, 11 OF oDlg PIXEL 
    @ 030, 060 MSGET nPasw SIZE 55, 11 OF oDlg PIXEL 

    @ 014, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        ValidaUsuario(nPasw, nUser)
    
    else 
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
        RETURN

    ENDIF
RETURN

STATIC FUNCTION ValidaUsuario(nPasw, nUser)

    LOCAL CUsuario := 'GIUGIU'
    LOCAL cSenha   := "Teste21'"

    if ((CUsuario) == (nPasw))

        if ((nPasw) == (cSenha))
            FwAlertSucess("Acesso permitido")
        else 
        FwAlertError("Usuário ou senha inválido")
        ENDIF

    else 
        FwAlertError("Usuário ou senha inválido")
    ENDIF

RETURN
