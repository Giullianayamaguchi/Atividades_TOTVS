#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} L4_E4
    4 – Faça um programa que leia a largura e a altura
de uma parede em metros, calcule sua área e a
quantidade de tinta necessária para pintá-la,
sabendo que cada litro de tinta pinta uma ária de 2
metros quadrados
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

User Function L4_E4()

  LOCAL cTitle := 'área da parede'
  LOCAL cText      :='Digite o tamanho da largura:'
  LOCAL cText2     := 'Digite o tamanho da altura:'
  LOCAL cResul     := ' Ver Cálculo '
  LOCAL cSair      := '    Sair     '
  LOCAL nAlt := space(20)
  LOCAL nLar := space(20)
  LOCAL oDlg := NIL
  LOCAL nOpcao := 0
  Private oDlgPvt  := NIL
  Private nJanLarg := 150
  Private nJanAltu := 350


  DEFINE MSDIALOG oDlg TITLE cTitle from 000, 000 to nJanLarg, nJanAltu pixel
  @ 010, 010 say cText size 55,77 of oDlg pixel
  @ 034, 010 SAY cText2 SIZE 55,77 OF oDlg PIXEL

  @ 010, 060 MSGET nAlt SIZE 55, 11 OF oDlg PIXEL 
  @ 034, 060 MSGET nLar SIZE 55, 11 OF oDlg PIXEL 

  @ 014, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
  @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
  ACTIVATE MSDIALOG oDlg CENTERED

  if nOpcao == 1
    AREA(nLar,nAlt)

  else
    FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
  endif

Return

STATIC FUNCTION AREA(nLar,nAlt)
    LOCAL nArea := 0

    nArea :=(Val(nAlt) * Val(nLar)) / 2
    
    FwAlertSucess("A área a ser pintada é de: " +  Alltrim(str(nArea)))

RETURN
