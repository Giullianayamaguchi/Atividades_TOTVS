#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} L4_E5
    5 – Escreva um programa que pergunte a
quantidade de Km percorridos por um carro
alugado e a quantidade de dias pelos quais ele foi
alugado. Calcule o preço a pagar, sabendo que o
carro custa R$60,00/dia e R$0,15/Km rodado.
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

USER FUNCTION L4_E5()

  LOCAL cTitle := 'Valor do aluguel'
  LOCAL cPerg1 := 'Digite a quantidade de Km percorridos'
  LOCAL cPerg2 := 'Digite quantos dias o carro foi alugado'
  LOCAL cResul     := ' Ver extrado '
  LOCAL cSair      := '    Sair     '
  LOCAL nKm    := SPACE(20)
  LOCAL nDias  := SPACE(20)
  LOCAL oDlg   := NIL
  LOCAL nOpcao := 0
  Private oDlgPvt  := NIL
  Private nJanLarg := 150
  Private nJanAltu := 370

  DEFINE MSDIALOG oDlg  TITLE cTitle from 000, 000 to nJanLarg, nJanAltu PIXEL
  @ 010, 010 SAY cPerg1 SIZE 55, 77 OF oDLG PIXEL
  @ 034, 010 SAY cPerg2 SIZE 55, 77 OF oDlg PIXEL

  @ 010, 065 MSGET nKm   SIZE 55, 11 OF oDlg PIXEL
  @ 034, 065 MSGET nDias SIZE 55, 11 OF oDlg PIXEL 

  @ 014, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
  @ 034, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
  ACTIVATE MSDIALOG oDlg CENTERED

  if nOpcao == 1
    PRECO(nKm, nDias)

  else
    FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
  endif
Return


STATIC FUNCTION PRECO(nKm, nDias)

  LOCAL nCust   := 60
  LOCAL nKmCus  := 0.15
  LOCAL nTtKm := 0
  LOCAL nTtCus := 0 
  LOCAL nTtFinal  := 0

  nTtKm := Val(nKm) * nKmCus
  nTtCus := Val(nDias) * nCust
  nTtFinal  := nTtKm + nTtCus

  FwAlertSucess("O valor por Km rodados com o carro foi de: " + alltrim(str(nTtKm)) +CRLF + ;
  "E o total de dias alugado foi de " + alltrim(str(nTtCus)) + CRLF + ;
  "logo o valor final do aluguel é de: " + alltrim(str(nTtFinal)))

RETURN
