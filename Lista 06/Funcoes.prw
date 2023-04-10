#Include "Protheus.ch"
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

// Exerc 1 

USER FUNCTION DescProd()

  Local aArea := GetArea()

  Reclock('SB1', .F.)

  SB1->B1_DESC :=('Cad. Manual - ' + B1_DESC)

  SB1->(MsUnlock())
  RestArea(aArea)

Return

// Exerc

USER FUNCTION BloqPed()
  lOCAL lRet := .T.

  if alltrim(SC5->C5_INCLU) == '2' 
    lRet := .F.
    MSGALERT( "Não é possível excluir pedidos com o tipo Automático", "Erro" )
  ENDIF

RETURN lRet

//Exerc 

User Function BloqAuto()
  LOCAL lRet := .T.

  SB1->B1_MSBLQL := 'sim'

Return lRet

//Exerc 

USER FUNCTION BloqCli()
  lOCAL lRet := .F.

  IF INCLUI
    SA1->A1_MSBLQL := '1'
    lRet := .T.
  ENDIF

RETURN lRet

// Exerc 7
user Function Cadas()
  Local cAlias:= 'SA1'
  Private cCadastro := 'Cadastro de Fornecedores'
  Private aRotina:= {}

  Aadd(aRotina, {'Pesquisar','AxPesqui', 0, 1})
  Aadd(aRotina, {'Incluir','AxInclui', 0, 3})
  Aadd(aRotina, {'Visualizar', 'AxVisual', 0, 2})
  Aadd(aRotina, {'Alterar','AxAltera', 0, 4})
  Aadd(aRotina, {'Excluir','AxDeleta', 0, 5})

  DbSelectArea(cAlias)
  DbSetOrder(1)

  MBrowse(NIL, NIL, NIL, NIL, cAlias)

  DbCloseArea()
Return

// Exerc 9

User Function DescItens()
  Local aArea := GetArea()
  Local aAreaC5 := SC5->(GetArea())
  Local aAreaC6 := SC6->(GetArea())
  Local cPed:= PARAMIXB 
  Local cText := 'Inc. PE - '

  DbSelectArea('SC6') // Abertura da tabela
  DbSetOrder(1) // Selecionado Índice 1

  if DbSeek(xFilial('SC6') + cPed)
    
    while SC6->C6_NUM == cPed 
      RecLock('SC6', .F.) 
      SC6->C6_DESCRI := cText + SC6->C6_DESCRI 
      SC6->(MsUnlock()) 

      SC6->(DbSkip()) 
    enddo
  endif

  SC6->(DbCloseArea())

  RestArea(aArea)
  RestArea(aAreaC5)
  RestArea(aAreaC6)
Return


// Exerc 10

User Function ValidaCidade() 

  Local cEst := M->CC2_EST
  Local cMun := M->CC2_MUN
  Local lRet := .T.

  DBSELECTAREA("CC2")
  CC2->(dbSetOrder(1))
  CC2->(DBGOTOP())

  WHile CC2->(!EOF())

    IF UPPER(ALLTRIM(cMUn)) == ALLTRIM(CC2->CC2_MUN) .and. cEst == CC2->CC2_EST
      lRet := .F.
      help(,,"Atenção",, "Cidade já cadastrada",1,0, NIL, NIL, NIL, NIL, NIL, {"Favor Revisar nome da cidade"})
      EXIT
    ENDIF

    CC2->(DBSKIP())
  Enddo

  CC2->(DBCLOSEAREA())

Return lRet






