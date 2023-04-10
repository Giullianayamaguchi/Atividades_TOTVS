
#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E1
    1 – Ler dois números positivos e apresentar a
soma, diferença, produto e quociente entre eles.
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


User Function L4_E1()

    Local cTitle      := 'Soma, subtração, divisão, multiplicação'
    Local nNumero1    :=  Space(20)
    Local nNumero2    :=  Space(20)
    Local cMsg        := 'w'
    Local oDlg        := NIL
    Local nOpcao      := 0
    Private oDlgPvt   := NIL
    Private nJanLarg  := 150
    Private nJanAltu  := 380
    Private cTexto    := 'Digite o número:'
    Private cResul    := 'Ver Resultado'
    Private cSair     := '    Sair     '
      

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanLarg, nJanAltu PIXEL
    @ 014, 010 SAY   cTexto   SIZE 55, 07 OF oDlg PIXEL
    @ 030, 010 SAY   cTexto   SIZE 55, 07 OF oDlg PIXEL
    
    @ 014, 055 MSGET nNumero1 SIZE 55, 11 OF oDlg PIXEL 
    @ 030, 055 MSGET nNumero2 SIZE 55, 11 OF oDlg PIXEL 

    @ 014, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED


    if nOpcao == 1

        cMsg := Soma(nNumero1, nNumero2, cMsg)
        cMsg := Multiplicacao(nNumero1, nNumero2, cMsg)
        cMsg := Divisao(nNumero1, nNumero2, cMsg)
        cMsg := Subtracao(nNumero1, nNumero2, cMsg)

        MensagemFinal(cMsg)

    else
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
        RETURN
    endif

Return

Static Function Soma(nNumero1, nNumero2, cMsg)

    LOCAL  nSoma := 0

    nSoma := (val(nNumero1)) + (val(nNumero2))
    cMsg := 'Soma: ' + CVALTOCHAR(nSoma) + CRLF

RETURN cMsg

Static Function Multiplicacao(nNumero1, nNumero2, cMsg)

    LOCAL  nMulti := 0

    nMulti := (val(nNumero1)) * (val(nNumero2))
    cMsg += 'Multiplicação: ' + CVALTOCHAR(nMulti) + CRLF

RETURN cMsg

Static Function Divisao(nNumero1, nNumero2, cMsg)

    LOCAL  nDivi := 0

    nDivi := (val(nNumero1)) / (val(nNumero2))
    cMsg += 'Divisão: ' + CVALTOCHAR(nDivi) + CRLF

RETURN cMsg

Static Function Subtracao(nNumero1, nNumero2, cMsg)

    LOCAL  nSub := 0

    nSub := (val(nNumero1)) - (val(nNumero2))
    cMsg += 'Subtração: ' + CVALTOCHAR(nSub) 

RETURN cMsg

Static Function MensagemFinal(cMsg)

     FwAlertSucess(cMsg + CRLF )

RETURN 
